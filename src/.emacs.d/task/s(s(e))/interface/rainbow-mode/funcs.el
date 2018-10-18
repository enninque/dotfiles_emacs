(造activator rainbow-mode
  (rainbow-mode +1))

(造init
  "Configure `rainbow-mode'."
  (<eg>add-github (rainbow-mode "shinkiley/rainbow-mode"))

  (<eg>add-by-name 'rainbow-mode
    ("require")
    (~require 'rainbow-mode)))
