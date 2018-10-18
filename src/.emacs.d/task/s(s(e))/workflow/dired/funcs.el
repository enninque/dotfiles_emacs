(defvar --vikara-dired-omit-mode-hidden-patterns '("^\\\.")
  "Rules for hidden patterns.")

(defvar --vikara-dired-omit-mode-omitted-patterns '("^flycheck_\.+\\.el$"
                                                    "\\.$"
                                                    "\\.\\.$")
  "Rules for omitted patterns.")

(defvar --vikara-dired-omit-mode-bits 2
  "Bitmap for rule selection.
0x - bit of hidden files;
x0 - bit of omitted files.")

(defvar vikara-dired-helm-locations () 
  "Locations for `dired-helm-locations'")

(defun <dired>apply-omit-rules ()
  "Creates omit rules for `dired-omit-mode'."
  ;; todo: replace ugly code
  (setq dired-omit-files
        (string-join (cons "^I AM A MAN, WHO WALKS ALONE, AND WHEN I'm WALKING A DARK ROAD$"
                           (append (if (= (logand --vikara-dired-omit-mode-bits
                                                  2)
                                          2)
                                       --vikara-dired-omit-mode-omitted-patterns
                                     ())
                                   (if (= (logand --vikara-dired-omit-mode-bits
                                                  1)
                                          1)
                                       --vikara-dired-omit-mode-hidden-patterns
                                     ())))
                     "\\|"))
  (dired-revert))

(defun <dired>toggle-hidden ()
  "Toggles flag of hidden files."
  (interactive)
  (setq --vikara-dired-omit-mode-bits
        (logxor --vikara-dired-omit-mode-bits
                1))
  (<dired>apply-omit-rules))

(defun <dired>toggle-omitted ()
  "Toggles flag of omitted files."
  (interactive)
  (setq --vikara-dired-omit-mode-bits
        (logxor --vikara-dired-omit-mode-bits
                2))
  (<dired>apply-omit-rules))

(defun <dired>open-this-directory ()
  "Opens dired in this directory."
  (interactive)
  (dired default-directory))

(defun <dired>create-directory ()
  (interactive)
  (call-interactively 'dired-create-directory)
  (revert-buffer))

(defun <dired>header-length ()
  "Return the length of the header in current dired buffer."
  2)

(defun <dired>footer-length ()
  "Return the length of the header in current dired buffer."
  1)

(defun <dired>omit-header ()
  "When cursor at the beginning of the buffer move it to the beginning of actual content."
  (forward-line (max (- (<dired>header-length)
                        (1- (line-number-at-pos)))
                     0)))

(defun <dired>omit-footer ()
  "When cursor at the end of the buffer move it to the end of actual content."
  (forward-line (min 0
                     (- 1
                        (max 0
                             (- (line-number-at-pos)
                                (- (count-lines (point-min) (point-max))
                                   (<dired>footer-length))))))))

(defun <dired>move-to-beginning ()
  "Move cursor to the beginning of actual content."
  (interactive)
  (evil-goto-first-line)
  (<dired>omit-header)
  (dired-move-to-filename))

(defun <dired>move-to-end ()
  "Move cursor to the end of actual content."
  (interactive)
  (evil-goto-line)
  (<dired>omit-footer)
  (dired-move-to-filename))

(defun <dired>move-to-top ()
  "Move cursor to the top of the displayed content, except footer."
  (interactive)
  (evil-window-top)
  (<dired>omit-header)
  (dired-move-to-filename))

(defun <dired>move-to-bottom ()
  "Move cursor to the bottom of the displayed content, except footer."
  (interactive)
  (evil-window-bottom)
  (<dired>omit-footer)
  (dired-move-to-filename))

(defun <dired>page-down (&optional count)
  "Scroll COUNT pages down with footer omitted."
  (interactive "P")
  (evil-scroll-page-down (or count 1))
  (<dired>omit-footer)
  (dired-move-to-filename))

(defun <dired>page-up (&optional count)
  "Scroll COUNT pages up with header omitted."
  (interactive "P")
  (evil-scroll-page-up (or count 1))
  (<dired>omit-header)
  (dired-move-to-filename))

(defun <dired>half-page-down (&optional count)
  "Scroll COUNT halfpages down with footer omitted."
  (interactive "P")
  (evil-scroll-down (or count 1))
  (<dired>omit-footer)
  (dired-move-to-filename))

(defun <dired>half-page-up (&optional count)
  "Scroll COUNT halfpages up with header omitted."
  (interactive "P")
  (evil-scroll-up (or count 1))
  (<dired>omit-header)
  (dired-move-to-filename))

(defun <dired>next-line (&optional count)
  "Move cursor to COUNT lines down."
  (interactive "P")
  (evil-next-line (or count 1))
  (<dired>omit-footer)
  (dired-move-to-filename))

(defun <dired>previous-line (&optional count)
  "Move cursor to COUNT lines down."
  (interactive "P")
  (evil-previous-line (or count 1))
  (<dired>omit-header)
  (dired-move-to-filename))

(defun <dired><shn>split ()
  "Split selected files using `shntool' utility"
  (interactive)
  (let ((marked-files (dired-get-marked-files)))
    (if (= 2 (length marked-files))
        (progn
          (<shn>split (first marked-files) (second marked-files))
          (dired-unmark-all-marks)
          (revert-buffer t t))
      (error "2 marked files are required for `shn-split'"))))

(defun <dired>uncompress ()
  "Uncompress selected archive files in dired buffer.
Supports: rar, zip, tar.gz archives."
  (interactive)
  (let ((--input (read-string "Path: " nil default-directory))
        (--target))
    (setq --target (cond
                    ((string= ""
                              --input)
                     default-directory)
                    ((f-absolute-p --input) --input)
                    (t (f-join default-directory
                               --input))))
    (unless (f-dir-p --target)
      (f-mkdir --target))
    (setq default-directory
          --target)
    (cl-loop for --item in (dired-get-marked-files)
             do (let ((--cmd (format (cond
                                      ((string-match "\\.zip$" --item)
                                       "unzip -d %s \"%s\"")
                                      ((string-match "\\.rar$" --item)
                                       "cd %s && unrar x \"%s\"")
                                      ((string-match "\\.tar.gz" --item)
                                       "cd %s && tar xvf \"%s\"")
                                      (t (error "Unsupported archive format.")))
                                     (s-replace-all '(("\"" . "\\\"")
                                                      (" "  . "\\ "))
                                                    default-directory)
                                     --item)))
                  (when --cmd
                    (shell-command --cmd)
                    (dired-revert)
                    (dired-unmark-all-marks))))))

(defun <dired>visit-path (path)
  "Construct lambda that visits PATH.
If PATH is invalid return nil."
  (interactive)
  (dired path))

(defun <dired>setup-buffer ()
  "Configure `dired-mode' buffers."
  (<evil>{activate} :evil-state 'dired)

  (setq truncate-lines t)

  (auto-revert-mode +1)

  (dired-omit-mode  +1)
  (dired-hide-details-mode -1))

(造init
  "Configure `dired'."
  (<eg>add-install :type 'download
                   :name 'dired+
                   :src "https://raw.githubusercontent.com/shinkiley/emacswiki.org/master/dired%2B.el"
                   :parents '("install dired"))

  (<eg>add-github (dired-helm-locations "shinkiley/dired-helm-locations"))

  (<eg>add-by-name 'dired
    ("require")
    (~require 'dired
              'dired-x
              'dired+
              'dired-helm-locations
              'dired-evil-state)

    ("settings")
    (progn
      (~set (dired-recursive-deletes 'always)
            (dired-dwim-target       t))

      ;; Omit some files with patterns
      (~set (dired-omit-verbose nil))

      (~set (dired-compress-file-suffixes '(("\\.zip\\'" ".zip" "unzip"))))

      ;; `dired-helm-locations'
      (eval `(dired-helm-locations-add ,@vikara-dired-helm-locations)))

    ("keymap")
    (progn
      (<keymap>{save}{create} dired-mode-map))

    ("global-keymap")
    (<keymap>{define}global
      ("C-x d" #'<dired>open-this-directory))

    ("hook")
    (<hook>add 'dired-mode-hook
               #'<dired>setup-buffer))

  (<eg>add-by-parents ("keymap evil")
    'dired
    (progn
      (<keymap>{create} evil-dired-state-map)

      (<which-key>create dired-mode evil-dired-state-map
        ;; arstd
        ("s s"     #'dired-mark                                      "Select.")
        ("s S"     #'dired-mark-unmarked-files                       "Select all.")
        ("s u"     #'dired-unmark                                    "Unselect.")
        ("s U"     #'dired-unmark-all-marks                          "Unselect all.")

        ("d c"     #'dired-do-copy                                   "Do copy.")
        ("d r"     #'dired-do-rename                                 "Do rename.")
        ("d d"     #'dired-do-delete                                 "Do delete.")
        ("d o"     #'dired-do-chown                                  "Do change ownership.")
        ("d g"     #'dired-do-chgrp                                  "Do change group.")

        ("m f"     #'helm-find-files                                 "Make file")
        ("m d"     #'<dired>create-directory                         "Make directory")
        ("m s"     #'dired-do-symlink                                "Make symlink")
        ("m h"     #'dired-do-hardlink                               "Make hardlink")

        ("t h"     #'<dired>toggle-hidden                            "Toggle hidden")
        ("t o"     #'<dired>toggle-omitted                           "Toggle omitted")
        ("t d"     (<func>toggle-minor-mode dired-hide-details-mode) "Toggle details")

        ;; qwfpg  
        ("q"       #'<buffer>{kill}current                           "Close")
        ("w"       #'dired-helm-locations-open                       "Open location")

        ("n"       #'dired-up-directory                              "Parent directory")
        ("e"       #'<dired>next-line                                "Next line")
        ("i"       #'<dired>previous-line                            "Prev line")
        ("o"       #'dired-find-file                                 "Open")

        ("I"       #'<dired>move-to-top                              ""                         )
        ("E"       #'<dired>move-to-bottom                           "")
        ;; 12345
        ("A-1"     #'evil-search-forward                             "")
        ("A-!"     #'evil-search-backward                            "")

        ("C-x C-s" #'ignore                                          "")
        ;; C-
        ("C-q"     (<buffer>{kill}by-major-mode   'dired-mode)       ""))

      (<keymap>{bind}digits evil-dired-state-map #'digit-argument))))
