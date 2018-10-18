(造setuper lisp-interaction
  (when (eq major-mode
            'lisp-interaction-mode)
    (setq tab-width      2
          truncate-lines t)

    (<evil>{activate} :evil-shift-width 2
                      :evil-state       'normal)
    (<smartparens>{activate})
    (<aggressive-indent>{activate})
    (<yasnippet>{activate})

    (<company>{activate})

    (<eldoc>{activate})

    (<activate>interface-plugins)))

(造init
  "Configure `lisp-interaction-mode'."
  (<eg>add-by-name 'lisp-interaction
    ("settings smartparens")
    (<smartparens>{create}local lisp-interaction-mode
      ("("    ")")
      ("{"    "}")
      ("["    "]")
      ("\""   "\"")
      ("`"    "'")
      ("\\\"" "\\\""))

    ("keymap")
    (<keymap>prog lisp-interaction-mode-map
      :bindings (("C-c e"    #'eval-last-sexp)
                 ("C-x C-s"  #'ignore)))

    ("hook")
    (<hook>add 'lisp-interaction-mode-hook
               #'<lisp-interaction>{setup})))
