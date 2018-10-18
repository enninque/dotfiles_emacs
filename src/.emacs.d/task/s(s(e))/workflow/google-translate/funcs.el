(造init
  "Configure google translate."
  (<eg>add-github (google-translate "raisatu/google-translate"))

  (<eg>add-by-name 'google-translate
    ("require")
    (~require 'google-translate)

    ("global-keymap")
    (<keymap>{define}global
      ("C-x C-t C-t" #'google-translate-query-translate)
      ("C-x C-t C-w" #'google-translate-at-point))))

(provide 'funcs)
