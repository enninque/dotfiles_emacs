(造activator linum-relative
  (linum-on)
  (linum-relative-on))

(造init
  "Configure `linum'."
  (<eg>add-github (linum-relative "shinkiley/linum-relative"))

  (<eg>add-by-name 'linum-relative
    ("require")
    (~require 'linum-relative)

    ("settings")
    (setq linum-relative-current-symbol "")))
