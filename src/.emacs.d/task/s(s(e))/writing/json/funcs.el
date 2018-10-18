(造setuper json
  (when (eq major-mode
            'json-mode)
    (<var>ensure-local
     (tab-width      2)
     (truncate-lines t)
     (word-wrap      t))

    (<evil>{activate} :evil-shift-width 2
                      :evil-state       'normal)
    (<smartparens>{activate})
    (<aggressive-indent>{activate})

    (<flycheck>{activate})
    (<company>{activate} :backends-set '((company-keywords company-files)))

    (<activate>interface-plugins)))

(造init
  "Configure `json-mode'."
  (<eg>add-github (json-mode     "shinkiley/json-mode")
                  (json-snatcher "shinkiley/json-snatcher")
                  (json-reformat "shinkiley/json-reformat"))

  (<eg>add-by-name 'json
    ("require")
    (~require 'json-mode)

    ("settings")
    (<filetype>register 'json-mode
                        "\\.json\\'"
                        "\\.babelrc\\'")

    ("settings smartparens")
    (<smartparens>{create}local json-mode
      ("("    ")")
      ("{"    "}")
      ("["    "]")
      ("\""   "\"")
      ("'"    "'")
      ("\\\"" "\\\"")
      ("\\'" "\\'"))

    ("keymap")
    (<keymap>prog json-mode-map)

    ("hook")
    (<hook>add 'json-mode-hook #'<json>{setup})))
