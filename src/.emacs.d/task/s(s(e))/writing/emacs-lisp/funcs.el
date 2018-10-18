(defun <emacs-lisp>? ()
  "Return t if major mode is `emacs-lisp-mode'."
  (eq 'emacs-lisp-mode
      major-mode))

(造setuper emacs-lisp
  (when (<emacs-lisp>?)
    (<var>ensure-local
     (tab-width      2)
     (truncate-lines t))

    (<evil>{activate} :evil-shift-width 2
                      :evil-state       'normal)
    (<smartparens>{activate})
    (<aggressive-indent>{activate})

    (<flycheck>{activate} :disabled-checkers '(emacs-lisp-checkdoc)
                          :eval '(flycheck-cask-setup))

    (<yasnippet>{activate})
    (<company>{activate})

    (<eldoc>{activate})

    (<activate>interface-plugins)))

(造init
  "Configure `emacs-lisp-mode'."
  (<eg>add-github (flycheck-cask "shinkiley/flycheck-cask"))

  (<eg>add-by-name 'emacs-lisp
    ("require")
    (~require 'flycheck-cask)

    ("settings")
    (<filetype>register 'emacs-lisp-mode
                        "\\.el\\'")

    ("settings smartparens")
    (<smartparens>{create}local emacs-lisp-mode
      ("("    ")")
      ("{"    "}")
      ("["    "]")
      ("\""   "\"")
      ("`"    "'")
      ("\\\"" "\\\""))

    ("keymap")
    (<keymap>prog emacs-lisp-mode-map
      :bindings (("C-c e" #'eval-last-sexp)
                 ("C-c E" #'pp-macroexpand-last-sexp)))

    ("hook")
    (<hook>add 'emacs-lisp-mode-hook
               #'<emacs-lisp>{setup})))
