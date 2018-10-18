(造activator highlight-todo
  (hl-todo-mode +1))

(造init
  "Configure `highlight-todo'."
  (<eg>add-github (hl-todo "raisatu/hl-todo"))

  (<eg>add-by-name 'hl-todo
    ("require")
    (~require 'hl-todo)))

(provide 'funcs)
