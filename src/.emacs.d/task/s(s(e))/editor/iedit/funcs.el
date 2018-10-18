(造init
  "Configure `iedit'."
  (<eg>add-github (iedit "shinkiley/iedit"))

  (<eg>add-by-name 'iedit
    ("require")
    (~require 'iedit)

    ("keymap")
    (progn
      (<keymap>{save}{create} iedit-mode-keymap)
      (<keymap>{save}{create} iedit-mode-occurrence-keymap))))
