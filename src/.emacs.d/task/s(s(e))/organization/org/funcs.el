(defun <org>heading? ()
  "Return t if cursor at the line that is an org heading."
  (org-at-heading-p))

(defun <org><C-c><C-n> ()
  (interactive)

  (cond
   ((<org>heading?)
    (org-promote-subtree))

   (t nil)))

(defun <org><C-c><C-e> ()
  (interactive)

  (cond
   (t nil)))

(defun <org><C-c><C-i> ()
  (interactive)

  (cond
   (t nil)))

(defun <org><C-c><C-o> ()
  (interactive)

  (cond
   ((<org>heading?)
    (org-demote-subtree))

   (t nil)))

(defun <org><H-n> ()
  (interactive)

  (cond
   (t nil)))

(defun <org><H-e> ()
  (interactive)

  (cond
   ((<org>heading?)
    (org-move-subtree-down))
   
   (t nil)))

(defun <org><H-i> ()
  (interactive)

  (cond
   ((<org>heading?)
    (org-move-subtree-up))
   
   (t nil)))

(defun <org><H-o> ()
  (interactive)

  (cond
   (t nil)))

(defun <org><A-n> ()
  (interactive)

  (cond
   (t nil)))

(defun <org><A-e> ()
  (interactive)

  (cond
   ((<org>heading?)
    (org-next-visible-heading 1))
   
   (t nil)))

(defun <org><A-i> ()
  (interactive)

  (cond
   ((<org>heading?)
    (org-previous-visible-heading 1))
   
   (t nil)))

(defun <org><A-o> ()
  (interactive)

  (cond
   (t nil)))

(defun <org><A-N> ()
  (interactive)

  (cond
   (t nil)))

(defun <org><A-E> ()
  (interactive)

  (cond
   ((<org>heading?)
    (org-forward-heading-same-level 1))
   
   (t nil)))

(defun <org><A-I> ()
  (interactive)

  (cond
   ((<org>heading?)
    (org-backward-heading-same-level 1))
   
   (t nil)))

(defun <org><A-O> ()
  (interactive)

  (cond
   (t nil)))

(defun <org>? ()
  ""
  (eq major-mode
      'org-mode))

(造setuper org
  (when (<org>?)
    (<var>ensure-local
     (truncate-lines t))

    (<evil>{activate} :evil-state       'normal
                      :evil-shift-width 2)

    (<yasnippet>{activate})

    (<linum-relative>{activate})
    (org-bullets-mode +1)))

(造init
  "Configure `org-mode'."
  (<eg>add-install :type       'git
                   :name       'org-mode
                   :src        "https://code.orgmode.org/bzg/org-mode.git"
                   :parents    '("install org")
                   :extra-path '("lisp")
                   :post-hook  "make")
  
  (<eg>add-github (ob-rust     "shinkiley/ob-rust")
                  (ob-fsharp   "shinkiley/ob-fsharp")
                  (ob-racket   "shinkiley/ob-racket")
                  (ob-ipython  "shinkiley/ob-ipython")
                  (org-bullets "raisatu/org-bullets")
                  (org-dream   "raisatu/emacs-org-dream"))

  (<eg>add-by-name 'org-mode
    ("require")
    (progn
      (<keymap>{save}{create} org-mode-map)

      (~require 'org
                'org-capture
                'org-habit

                'org-bullets
                'org-dream))

    ("settings")
    (progn
      (<filetype>register 'org-mode
                          "\\.org\\'")

      (<var>set
        (org-startup-folded             t)
        (org-catch-invisible-edits      t)
        (org-directory                  (f-join (f-root)
                                                "home"
                                                "data2"
                                                "Data"
                                                "org"))
        (org-todo-keywords              '((sequence "TODO(1)" "NEXT(2)" "|" "DONE(3)" "CANCELLED(4)")
                                          (sequence "PROBLEM(q)" "RESEARCH(w)" "|" "SOLVED(f)")
                                          (sequence "NEED_PROOF(a)" "NEED_PROOF?(r)" "PROOVING(s)" "|" "PROOVED(t)" "DONT_NEED_PROOF(d)")))
        (org-todo-keyword-faces         '(("TODO" . (:foreground "red" :weight bold :underline t))
                                          ("NEXT" . (:foreground "yellow" :weight bold :box (:line-width 1 :color "yellow")))
                                          ("DONE" . (:foreground "green" :weight bold :strike-through t))
                                          ("CANCELLED" . (:foreground "green" :weight bold :strike-through t))
                                          ("PROBLEM" . (:foreground "red" :weight bold :underline t))
                                          ("RESEARCH" . (:foreground "yellow" :weight bold :box (:line-width 1 :color "yellow")))
                                          ("SOLVED" . (:foreground "green" :weight bold :strike-through t))
                                          ("NEED_PROOF" . (:foreground "red" :weight bold :underline t))
                                          ("NEED_PROOF?" . (:foreground "yellow" :weight bold :box (:line-width 1 :color "yellow")))
                                          ("PROOVING" . (:foreground "yellow" :weight bold :box (:line-width 1 :color "yellow")))
                                          ("PROOVED" . (:foreground "green" :weight bold :strike-through t))
                                          ("DONT_NEED_PROOF" . (:foreground "green" :weight bold :strike-through t))))
        (org-log-done                   nil)
        (org-default-notes-file         (f-join org-directory
                                                "gtd"
                                                "inbox.org"))
        (org-startup-with-inline-images t))

      (<var>set
        "Configure tags."

        (org-tag-alist '(("#innerity"  . ?1)
                         ("#leisure"   . ?2)
                         ("#grandness" . ?3)
                         ("#intelial"  . ?4)
                         ("#health"    . ?5)
                         ("$emacs"     . ?e)
                         ("$backend"   . ?b)
                         ("$frontend"  . ?f)))

        (org-tag-faces '(("#health"    . (:background "green"  :foreground "black"  :weight bold))
                         ("#leisure"   . (:background "red"    :foreground "black"))
                         ("#innerity"  . (:background "purple" :foreground "black"))
                         ("#grandness" . (:background "orange" :foreground "black"))
                         ("#intelial"  . (:background "blue"   :foreground "orange")))))

      (<var>set
        "Configure priorities."
        (org-lowest-priority       ?5)
        (org-highest-priority      ?1)
        (org-default-priority      ?3)
        (org-priority-faces        '((?5 . (:foreground "#777777" :background "#444444"))
                                     (?4 . (:foreground "#999999" :background "#333333"))
                                     (?3 . (:foreground "#BBBBBB" :background "#222222"))
                                     (?2 . (:foreground "#DDDDDD" :background "#111111"))
                                     (?1 . (:foreground "#FFFFFF" :background "#000000")))))

      (<var>set
        "Configure agenda."
        (org-agenda-files (append (mapcar (lambda (item)
                                            (f-join org-directory
                                                    "gtd"
                                                    item))
                                          (list "inbox.org"
                                                "tickler.org"
                                                "someday.org"
                                                "habits.org"))
                                  (mapcar (lambda (item)
                                            (f-join org-directory
                                                    "gtd"
                                                    "contexts"
                                                    item))
                                          (list "home.org"))))
        (org-agenda-custom-commands (quote (("h" "Habits" tags-todo "STYLE=\"habit\""
                                             ((org-agenda-overriding-header "Habits")
                                              (org-agenda-sorting-strategy '(todo-state-down effort-up category-keep))))))))

      (<var>set
        "Configure capturing."

        (org-capture-templates `(("t" "Todo" entry
                                  (file+headline ,(f-join org-directory
                                                          "gtd"
                                                          "inbox.org")
                                                 "Tasks")
                                  "* TODO %i%? %^G")
                                 ("T" "Tickler" entry
                                  (file+headline ,(f-join org-directory
                                                          "gtd"
                                                          "tickler.org")
                                                 "Tickler")
                                  "* %i%? \n %U")
                                 ("h" "tHought" entry
                                  (file+headline ,(f-join org-directory
                                                          "gtd"
                                                          "inbox.org")
                                                 "Thoughts")
                                  "* %i%?")
                                 ("H" "Habit" entry
                                  (file+headline ,(f-join org-directory
                                                          "gtd"
                                                          "habits.org")
                                                 "Habits")
                                  "* TODO %i%?\n  SCHEDULED: %T\n:PROPERTIES:\n  :STYLE: habit\n  :END:")))

        (org-capture-before-finalize-hook (lambda () (save-buffer))))

      (<var>set
        "Configure refiling."
        (org-refile-targets '(("gtd.org"     :maxlevel . 1)
                              ("done.org"    :maxlevel . 1)
                              ("someday.org" :maxlevel . 1))))
      (<var>set
        "Configure archiving."
        (org-archive-location (format "~/org/gtd/archive/%s/%s_archive::"
                                      (format-time-string "%Y-%m")
                                      (format-time-string "%Y-%m-%d"))))

      (<var>set
        "`org-dream' setup."
        (org-dream-file-format (f-join org-directory
                                       "dreams"
                                       "%Y-%m"
                                       "%Y-%m-%d.org"))))

    ("keymap")
    (progn
      (<keymap>{define} org-mode-map
        ("TAB"         #'org-cycle)
        ("<backtab>"   #'org-global-cycle)
        ("<C-tab>"     #'yas-expand)
        ("RET"         #'org-open-at-point)

        ("C-c C-l"     #'org-insert-link)
        ("C-c l t"     #'org-toggle-link-display)

        ("C-c C-\\"    #'org-table-create)
        ("C-c \\ a"    #'org-table-align)

        ("C-c C-h"     #'org-insert-heading)
        ("C-c C-c C-h" #'org-insert-subheading)

        ("C-c C-t"     #'org-insert-todo-heading)
        ("C-c C-c C-t" #'org-insert-todo-subheading)
        ("H-t"         #'org-todo)
        ("C-c t n"     #'org-shiftleft)
        ("C-c t o"     #'org-shiftright)
        ("C-c t s"     #'org-schedule)

        ("C-c C-c C-c" #'org-time-stamp)
        ("C-c c t"     #'org-toggle-timestamp-type)
        ("C-c c i"     #'org-clock-in)
        ("C-c c o"     #'org-clock-out)

        ("C-c i t"     #'org-toggle-inline-images)

        ("C-c C-p"     #'org-set-property-and-value)
        ("H-r"         #'org-refile)
        ("H-a"         #'org-archive-subtree)

        ("C-c C-n"     #'<org><C-c><C-n>)
        ("C-c C-e"     #'<org><C-c><C-e>)
        ("C-c C-i"     #'<org><C-c><C-i>)
        ("C-c <C-o>"   #'<org><C-c><C-o>)

        ("C-c <C-i>"   #'org-insert-item)

        ("H-T"         #'org-set-tags-command)

        ("H-n"         #'<org><H-n>)
        ("H-e"         #'<org><H-e>)
        ("H-i"         #'<org><H-i>)
        ("H-o"         #'<org><H-o>)

        ("A-n"         #'<org><A-n>)
        ("A-e"         #'<org><A-e>)
        ("A-i"         #'<org><A-i>)
        ("A-o"         #'<org><A-o>)

        ("A-N"         #'<org><A-N>)
        ("A-E"         #'<org><A-E>)
        ("A-I"         #'<org><A-I>)
        ("A-O"         #'<org><A-O>))

      (<keymap>{save}{create} org-agenda-mode-map
        ("A-e"   #'org-agenda-next-line)
        ("A-i"   #'org-agenda-previous-line)
        ("e"     #'org-agenda-next-item)
        ("i"     #'org-agenda-previous-item)

        ("C-c T" #'org-agenda-todo))

      (<keymap>{save}{create} org-capture-mode-map
        ("C-c C-c" #'org-capture-finalize)
        ("C-c C-r" #'org-capture-refile)
        ("C-c C-k" #'org-capture-kill)
        ("C-c q"   #'org-capture-kill)))

    ("global-keymap")
    (<keymap>{define}global
      ("<f12>" #'org-agenda))

    ("hook")
    (<hook>add 'org-mode-hook
               #'<org>{setup})))
