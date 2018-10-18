(造init
  "Configure theme."
  (<eg>add-github (razviraya "raisatu/emacs-razviraya-theme"))

  (<eg>add-by-name 'razviraya-theme
    ("base require")
    (~require 'razviraya)

    ("base interface")
    (load-theme 'razviraya t)))
