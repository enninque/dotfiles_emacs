(造init
  "Configure `projectile'."
  (<eg>add-github (projectile "shinkiley/projectile"))

  (<eg>add-by-name 'projectile
    ("require")
    (~require 'projectile)))
