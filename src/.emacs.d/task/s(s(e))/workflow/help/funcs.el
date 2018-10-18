(造setuper help
  (<evil>{activate} :evil-state 'motion))

(造init
  "Configure `help-mode'."
  (<eg>add-by-name 'help
    ("keymap")
    (progn
      (<keymap>{save}{create} help-mode-map
        ("q" #'<buffer>{kill}current)))

    ("hook")
    (<hook>add 'help-mode-hook
               #'<help>{setup})))
