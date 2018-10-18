(造init
  "Configure `magit'."
  (<eg>add-install :type       'git
                   :name       'magit
                   :src        "https://github.com/shinkiley/magit"
                   :extra-path '("lisp"))

  (<eg>add-github (ghub        "shinkiley/ghub")
                  (magit-popup "shinkiley/magit-popup")
                  (with-editor "shinkiley/with-editor"))

  (<eg>add-by-name 'magit
    ("require")
    (~require 'magit)

    ("global-keymap")
    (<keymap>{define}global
      ("C-x C-v i" #'magit-init)
      ("C-x C-v s" #'magit-status)
      ("C-x C-v c" #'magit-clone))))
