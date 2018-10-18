(造activator aggressive-indent)
(造toggler aggressive-indent)

(造init
  "Configure `aggressive-indent'."
  (<eg>add-github (aggressive-indent "shinkiley/aggressive-indent-mode"))

  (<eg>add-by-name 'aggressive-indent
    ("require")
    (~require 'aggressive-indent)

    ("settings")
    (<var>set
      (aggressive-indent-dont-indent-if '()))

    ("global-keymap")
    (<keymap>{define}global
      ("C-x t a" #'<aggressive-indent>{toggle}))))
