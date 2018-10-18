(造activator highlight-symbol)

(造init
  "Configure `highlight-symbol'."
  (<eg>add-github (highlight-symbol "shinkiley/highlight-symbol.el"))

  (<eg>add-by-name 'highlight-symbol
    ("require")
    (~require 'highlight-symbol)

    ("settings")
    (setq highlight-symbol-idle-delay 0.1)))
