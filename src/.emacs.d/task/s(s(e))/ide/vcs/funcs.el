(造init
  "Configure `magit'."
  (<eg>add-github
   (git-messenger "raisatu/emacs-git-messenger"))

  (<eg>add-by-name 'vcs
    ("require")
    (~require 'git-messenger)

    ("global-keymap")
    (<keymap>{define}global
      ("C-x C-v m" #'git-messenger:popup-message))))
