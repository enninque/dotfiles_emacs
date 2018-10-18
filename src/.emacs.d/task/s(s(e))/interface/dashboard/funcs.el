(造init
  "Configure `dasboard'."

  (<eg>add-github (dashboard "shinkiley/emacs-dashboard"))

  (<eg>add-by-name 'dashboard
    ("require")
    (~require 'dashboard)

    ("settings")
    (progn
      (dashboard-setup-startup-hook)
      (setq dashboard-banner-logo-title "Hello :3")
      ;; (setq dashboard-startup-banner    (f-join vikara-images-directory
      ;;                                           "greetings.png"))
      (setq dashboard-startup-banner nil)
      (setq dashboard-items '((recents . 5))))

    ("keymap")
    (progn
      (<keymap>{save}{create} dashboard-mode-map
        ("i" #'widget-backward)
        ("e" #'widget-forward)
        ("o" #'widget-button-press)

        ("I" #'dashboard-previous-section)
        ("E" #'dashboard-next-section)))))
