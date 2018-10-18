(defvar urn-mode-map (make-sparse-keymap)
  "Urn mode keymap.")

(define-derived-mode urn-mode lisp-mode
  "urn"
  "Major mode for editing urn files."
  :keymap urn-mode-map)

(造setuper urn
  (when (eq major-mode
            'urn-mode)
    (setq tab-width      2
          truncate-lines t)

    (<evil>{activate} :evil-shift-width 2
                      :evil-state       'normal)
    (<smartparens>{activate})
    (<aggressive-indent>{activate})
    (<yasnippet>{activate})
    (<company>{activate} :backends-set '((company-slime)
                                         (company-keywords company-files)))

    (<activate>interface-plugins)))

(造init
  "Configure Emacs for `urn'."
  (<eg>add-by-name 'urn
    ("settings")
    (<filetype>register 'urn-mode
                        "\\.urn\\'")

    ("settings smartparens")
    (<smartparens>{create}local urn-mode
                                ("("    ")")
                                ("{"    "}")
                                ("["    "]")
                                ("\""   "\"")
                                ("`"    "'")
                                ("\\\"" "\\\""))

    ("keymap")
    (<keymap>prog urn-mode-map
      :bindings (("C-c c" #'slime-eval-last-expression)))

    ("hook")
    (<hook>add 'urn-mode-hook
               #'<urn>{setup})))
