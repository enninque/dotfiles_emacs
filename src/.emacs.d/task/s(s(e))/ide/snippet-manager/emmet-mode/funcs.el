(defun <emmet>expand ()
  "Custom expand line. It ensures that `emmet-expand-line' will be invoked correctly in `evil-mode'."
  (interactive)

  (if (or evil-mode evil-local-mode)
      (cond ((evil-insert-state-p)
             (progn
               (evil-normal-state)
               (forward-char 1)
               (call-interactively 'emmet-expand-line)
               (evil-insert-state)))
            ((evil-normal-state-p)
             (save-excursion
               (evil-insert-state)
               (forward-char 1)
               (call-interactively 'emmet-expand-line)
               (evil-normal-state))))
    (call-interactively 'emmet-expand-line)))

(造activator emmet)

(造init
  "Configure `emmet-mode'."
  (<eg>add-github (emmet-mode "shinkiley/emmet-mode"))

  (<eg>add-by-name 'emmet-mode
    ("require")
    (progn
      (defvar emmet-mode-keymap (make-sparse-keymap))
      ;; Because `emmet' uses keymap as local variable
      (require 'emmet-mode))

    ("settings")
    (<var>set
      (emmet-preview-default nil))))
