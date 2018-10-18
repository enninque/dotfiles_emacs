(造init
  "Configure `ag'."
  (<eg>add-github (ag "shinkiley/ag.el"))

  (<eg>add-by-name 'ag
    ("require")
    (~require 'ag)

    ("settings")
    (setq ag-highlight-search t
          ag-reuse-window     t
          ag-reuse-buffers    t

          ag-arguments        ag-arguments
          ag-executable       (executable-find "ag"))

    ("global-keymap")
    (<which-key>define-global
     ("C-f a" #'ag        "Find by name")
     ("C-f A" #'ag-regexp "Find by regexp"))))
