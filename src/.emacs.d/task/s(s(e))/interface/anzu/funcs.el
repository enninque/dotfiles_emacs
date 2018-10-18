(造activator anzu
  (global-anzu-mode +1))

(造init
  "Configure `anzu'."
  (<eg>add-github (anzu      "shinkiley/emacs-anzu")
                  (evil-anzu "shinkiley/emacs-evil-anzu"))

  (<eg>add-by-name 'anzu
    ("require")
    (~require 'anzu)

    ("require evil")
    (~require 'evil-anzu)

    ("settings")
    (progn
      (setq anzu-cons-mode-line-p nil))

    ("post activate")
    (<anzu>{activate})))
