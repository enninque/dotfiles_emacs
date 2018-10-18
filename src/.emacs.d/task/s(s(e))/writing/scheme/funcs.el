(造setuper scheme
  (when (eq major-mode
            'scheme-mode)
    (<var>ensure-local
     (tab-width      2)
     (truncate-lines t))
    (<evil>{activate} :evil-state       'normal
                      :evil-shift-width 2)
    (<smartparens>{activate})
    (<aggressive-indent>{activate})

    (<flycheck>{activate})
    (<yasnippet>{activate})
    (<company>{activate})

    (<activate>interface-plugins)))

(造init
  "Configure `scheme-mode'."
  (<eg>add-by-name 'scheme
    ("require")
    (~require 'scheme)

    ("settings")
    (<filetype>register 'scheme-mode "\\.scm\\'")

    ("settings multi-compile")
    (add-to-list 'multi-compile-alist '(scheme-mode . (("mit-scheme" . "scheme"))))

    ("settings smartparens")
    (<smartparens>{create}local scheme-mode
      ("("    ")")
      ("{"    "}")
      ("["    "]")
      ("\""   "\"")
      ("`"    "'")
      ("\\\"" "\\\""))

    ("keymap")
    (<keymap>prog scheme-mode-map
      :multi-compile t)

    ("hook")
    (<hook>add 'scheme-mode-hook
               #'<scheme>{setup})))
