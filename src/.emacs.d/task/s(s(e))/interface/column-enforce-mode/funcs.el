(造activator column-enforce)

(造init
  "Configure `column-enforce-mode'."
  (<eg>add-github
   (column-enforce-mode "raisatu/column-enforce-mode"))

  (<eg>add-by-name 'column-enforce
    ("require")
    (~require 'column-enforce-mode)

    ("settings")
    (<var>set
      (column-enforce-column-getter (lambda ()
                                      80)))))
