(造init
  "Configure `compilation-mode'."
  (<eg>add-by-name 'compilation
    ("require")
    (~require 'compile)

    ("settings")
    (setq compilation-scroll-output t)))
