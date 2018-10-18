(造activator mmm-mode
  (mmm-mode +1))

(造init
  "Configure `mmm-mode'."
  (<eg>add-github (mmm-mode "shinkiley/mmm-mode"))

  (<eg>add-by-name 'mmm-mode
    ("require")
    (~require 'mmm-mode)

    ("settings")
    ()))
