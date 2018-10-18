(造init
  "Configure buffers."
  (<eg>add-by-name 'buffer-settings
    ("global-keymap")
    (<keymap>{define}global
      ("C-b l" #'ibuffer)

      ("C-b x" #'<buffer>copy)
      ("C-b c" #'<buffer>replace))))
