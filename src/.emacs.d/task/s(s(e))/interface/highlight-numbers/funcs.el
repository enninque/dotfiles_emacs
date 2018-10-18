(造activator highlight-numbers)

(造init
  "Configure `highlight-numbers'."
  (<eg>add-github (highlight-numbers "raisatu/highlight-numbers"))

  (<eg>add-by-name 'highlight-numbers
    ("require")
    (~require 'highlight-numbers)))
