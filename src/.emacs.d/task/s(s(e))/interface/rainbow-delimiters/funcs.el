(造activator rainbow-delimiters)

(造init
  "Configure `rainbow-delimiters'."
  (<eg>add-github
   (rainbow-delimiters "shinkiley/rainbow-delimiters"))

  (<eg>add-by-name 'rainbow-delimiters
    ("require")
    (~require 'rainbow-delimiters)

    ("settings")
    (<var>set
      (rainbow-delimiters-max-face-count 20))))
