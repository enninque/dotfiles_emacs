(造setuper toml
  (when (eq major-mode
            'toml-mode)
    (<var>ensure-local
     (tab-width      2)
     (truncate-lines t))

    (<evil>{activate} :evil-shift-width 2
                      :evil-state       'normal)
    (<smartparens>{activate})
    (<aggressive-indent>{activate})

    (<flycheck>{activate})

    (<activate>interface-plugins)))

(造init
  "Configure Emacs for `toml' writing."
  (<eg>add-github (toml-mode "shinkiley/toml-mode.el"))

  (<eg>add-by-name 'toml
    ("require")
    (~require 'toml-mode)

    ("settings")
    (<filetype>register 'toml-mode
                        "\\.toml\\'")

    ("settings smartparens")
    (<smartparens>{create}local toml-mode
      ("("    ")")
      ("{"    "}")
      ("["    "]")
      ("\""   "\"")
      ("'"    "'")
      ("\\\"" "\\\"")
      ("\\'" "\\'"))

    ("keymap")
    (<keymap>prog toml-mode-map)

    ("hook")
    (<hook>add 'toml-mode-hook
               #'<toml>{setup})))
