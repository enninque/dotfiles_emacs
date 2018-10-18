(defun <whitespace>enable (&optional enable)
  "Enable `whitespace-mode'."
  (whitespace-mode (or enable +1)))

(defun <whitespace>toggle ()
  "Toggle `whitespace-mode'."
  (interactive)
  (whitespace-mode (if whitespace-mode -1 +1)))

(造init
  "Configure `whitespace'."
  (<eg>add-by-name 'whitespace
    ("require")
    (~require 'whitespace)

    ("global-keymap")
    (<keymap>{define}global
      ("C-x t w" #'<whitespace>toggle))))
