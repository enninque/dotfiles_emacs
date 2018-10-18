(造init
  "Configure `dumb-jump'"
  (<eg>add-github (dumb-jump "shinkiley/dumb-jump"))

  (<eg>add-by-name 'dumb-jump
    ("require")
    (~require 'dumb-jump)

    ("settings")
    (setq dumb-jump-selector        'ivy
          dumb-jump-prefer-searcher 'ag)

    ("keymap")
    (progn
      (<keymap>{save}{create} dumb-jump-mode-map))))
