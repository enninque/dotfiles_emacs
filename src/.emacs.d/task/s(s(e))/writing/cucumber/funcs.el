(造setuper cucumber
  (when (eq major-mode
            'feature-mode)
    (<var>ensure-local
     (tab-width      2)
     (truncate-lines t))
    (<evil>{activate} :evil-state 'normal
                      :evil-shift-width 2)

    (<smartparens>{activate})

    (<activate>interface-plugins)))

(造init
  "Configure `cucumber'."
  (<eg>add-github (cucumber "shinkiley/cucumber.el"))

  (<eg>add-by-name 'cucumber
    ("require")
    (~require 'feature-mode)

    ("settings")
    (<filetype>register 'feature-mode
                        "\\.feature\\'")

    ("settings smartparens")
    (<smartparens>{create}local emacs-lisp-mode
      ("("  ")")
      ("{"  "}")
      ("["  "]")
      ("\"" "\""))

    ("keymap")
    (<keymap>{save}{create} feature-mode-map)

    ("hook")
    (<hook>add 'feature-mode-hook
               #'<cucumber>{setup})))
