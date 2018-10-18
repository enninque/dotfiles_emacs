(造activator beacon)

(造init
  "Configure `beacon'."
  (<eg>add-github (beacon "shinkiley/beacon"))

  (<eg>add-by-name 'beacon
    ("require")
    (~require 'beacon)

    ("settings")
    (setq beacon-blink-when-window-changes           t
          beacon-blink-when-window-scrolls           nil
          beacon-blink-when-point-moves-horizontally nil
          beacon-blink-when-point-moves-vertically   nil)

    ("post activate")
    (<beacon>{activate})))
