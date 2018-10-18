(造activator indent-guide)

(造init
  "Configure `indent-guide'."
  (<eg>add-github (indent-guide "raisatu/indent-guide"))

  (<eg>add-by-name 'indent-guide
    ("require")
    (~require 'indent-guide)

    ("settings")
    (<var>set
      (indent-guide-delay 0.1))))
