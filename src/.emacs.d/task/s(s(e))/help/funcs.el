(造init
  "Configure `help-fns+'."
  (<eg>add-download
   (help-fns+ "https://raw.githubusercontent.com/shinkiley/emacswiki.org/master/help-fns%2B.el"))

  (<eg>add-github (helm-descbinds "raisatu/helm-descbinds"))

  (<eg>add-by-name 'help
    ("require")
    (~require 'help
              'helm-descbinds)

    ("global-keymap")
    (<keymap>{define}global
      ("C-h v" #'describe-variable)
      ("C-h f" #'describe-function)
      ("C-h F" #'describe-face)
      ("C-h k" #'describe-key)
      ("C-h K" #'describe-keymap)
      ("C-h b" #'helm-descbinds))))
