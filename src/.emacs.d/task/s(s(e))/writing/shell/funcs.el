(defun <sh>execute ()
  "Execute marked text or line."
  (interactive)
  (let ((--proc        (get-process "shell"))
        (--proc-buffer  nil)
        (--min          nil)
        (--max          nil)
        (--command      nil))
    (unless --proc
      (let ((--current-buffer (current-buffer)))
        (shell)
        (switch-to-buffer --current-buffer)
        (setq --proc
              (get-process "shell"))))
    (setq --proc-buffer (process-buffer --proc))
    (if (not (use-region-p))
        (setq --min (point-at-bol)
              --max (point-at-eol))
      (setq --min (region-beginning)
            --max (region-end))
      (deactivate-mark))
    (setq --command (concat (buffer-substring --min
                                              --max)
                            "\n"))
    (with-current-buffer --proc-buffer
      (goto-char (process-mark --proc))
      (insert --command)
      (move-marker (process-mark --proc)
                   (point)))
    (process-send-string --proc
                         --command)
    (other-window 1)
    (display-buffer (process-buffer --proc) t)))

(造setuper sh
  (when (eq major-mode
            'sh-mode)
    (<var>ensure-local
     (tab-width      2)
     (truncate-lines t))
    (<evil>{activate} :evil-shift-width 2
                      :evil-state       'normal)
    (<smartparens>{activate})
    (<aggressive-indent>{activate})

    (<yasnippet>{activate})
    (<flycheck>{activate})

    (<eldoc>{activate})
    (<company>{activate} :backends-set '(company-shell
                                         company-shell-env))

    (<activate>interface-plugins)))

(造init
  "Configure `sh-mode'."
  (<eg>add-github (company-shell "shinkiley/company-shell"))

  (<eg>add-by-name 'sh
    ("require")
    (~require 'company-shell)

    ("settings")
    (<filetype>register 'sh-mode
                        "\\.sh\\'"
                        "\\.zsh\\'"
                        "\\.zshrc\\'"
                        "\\.zshenv\\'"
                        "\\.zprofile\\'"
                        "\\.xinit\\'")

    ("settings multi-compile")
    (add-to-list 'multi-compile-alist '(sh-mode . (("bash" . "bash  %path")
                                                   ("zsh"  . "zsh   %path"))))

    ("settings smartparens")
    (<smartparens>{create}local sh-mode
      ("("    ")")
      ("{"    "}")
      ("["    "]")
      ("\""   "\"")
      ("'"    "'")
      ("\\\"" "\\\""))

    ("keymap")
    (<keymap>prog sh-mode-map
      :multi-compile t
      :bindings (("C-c C-c" #'<sh>execute)))

    ("hook")
    (<hook>add 'sh-mode-hook
               #'<sh>{setup})))
