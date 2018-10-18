(cl-defun <flycheck>{activate} (&key ((:disabled-checkers --fdc) '() --fdc-p)
                                     (select nil select-p)
                                     ((:eval --eval) nil --eval-p))
  "Enable flycheck in current buffer."
  (when --fdc-p
    (setq flycheck-disabled-checkers
          (cond
           ((listp --fdc)
            (setq flycheck-disabled-checkers --fdc))
           ((symbolp --fdc-p)
            (setq flycheck-disabled-checkers (list --fdc)))
           (t (error "Unexpected disabled checkers declaration.")))))

  (when select-p
    (flycheck-select-checker select))

  (flycheck-mode         +1)
  (flycheck-pos-tip-mode +1)

  (when --eval-p
    (eval --eval)))

(defmacro <flycheck>add-mode (mode &rest checkers)
  "Configure CHECKER for MODE."
  (declare (indent 1))
  
  `(progn
     ,@(cl-loop for checker in checkers
                collect
                `(flycheck-add-mode ,checker ',mode))))

(defun <flycheck>show ()
  "Create `flycheck' buffer."
  (interactive)
  (flycheck-list-errors))

(defun <flycheck>hide ()
  "Remove `flycheck' buffers."
  (interactive)
  (<window>{kill}by-modes 'flycheck-error-list-mode))

(defun <flycheck>exists-p ()
  "Return t if any flycheck buffer is created."
  (<buffer>exists? 'flycheck-error-list-mode))

(defun <flycheck>unexists-p ()
  "Return t if any flycheck buffer is created."
  (<buffer>unexists? 'flycheck-error-list-mode))

(defun <flycheck>activated-p ()
  "Return t if flycheck is activated in current buffer"
  flycheck-mode)

(造init
  "Configure `flycheck'."
  (<eg>add-github
   (flycheck         "shinkiley/flycheck")
   (flycheck-pos-tip "raisatu/flycheck-pos-tip"))

  (<eg>add-by-name 'flycheck
    ("require")
    (~require 'flycheck
              'flycheck-pos-tip)

    ("settings")
    (progn
      (add-to-list 'display-buffer-alist
                   `(,(rx bos "*Flycheck errors*" eos)
                     (display-buffer-reuse-window display-buffer-in-side-window)
                     (side            . bottom)
                     (reusable-frames . visible)
                     (window-height   . 0.2)))
      (setq flycheck-check-syntax-automatically '(mode-enabled save idle-change))
      (setq flycheck-idle-change-delay 1))

    ("keymap")
    (progn
      ;; todo: create evil state
      (<keymap>{save}{create} flycheck-error-list-mode-map
        ("n" #'evil-backward-char)
        ("e" #'evil-next-line)
        ("i" #'evil-previous-line)
        ("o" #'evil-forward-char)

        ("q" #'<flycheck>hide))

      (<keymap>{save}{create} flycheck-mode-map))

    ("global-keymap")
    (<keymap>{define}global
      ("C-x s s" '<flycheck>show)
      ("C-x s h" '<flycheck>hide))))
