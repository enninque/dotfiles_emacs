(造init
  "Configure window key bindings."
  (<eg>add-github   (ace-window "enquer/ace-window"))

  (<eg>add-by-name 'window
    ("require")
    (~require 'ace-window
              'nyamacs-windmove)

    ("settings")
    (progn
      (setq aw-keys '(?a ?r ?s ?t ?d ?h ?n ?e ?i ?o)
            aw-dispatch-always t))

    ("settings hydra")
    (<hydra>define window
      ("q" nil "Cancel")

      ("a" #'<window>{split}right          "Split right")
      ("r" #'<window>{split}down           "Split below")

      ("z" #'<window>{delete}current       "Kill window")
      ("b" #'<window>{balance}             "Balance windows")
      
      ("n" #'<window>{focus}left           "Focus left")
      ("e" #'<window>{focus}down           "Focus down")
      ("i" #'<window>{focus}up             "Focus up")
      ("o" #'<window>{focus}right          "Focur right")

      ("N" #'<window>{shrink}horizontally  "Decrease width")
      ("E" #'<window>{enlarge}vertically   "Increase height")
      ("I" #'<window>{shrink}vertically    "Decrease height")
      ("O" #'<window>{enlarge}horizontally "Increase width"))

    ("global-keymap")
    (<keymap>{define}global
      ("C-w q" #'ignore)
      ("C-w w" #'ace-window)
      ("C-w f" #'hydra-window/body)

      ("C-w a" #'<window>{split}right)
      ("C-w r" #'<window>{split}down)

      ("C-w n" #'<window>{focus}left)
      ("C-w e" #'<window>{focus}down)
      ("C-w i" #'<window>{focus}up)
      ("C-w o" #'<window>{focus}right)

      ("C-w N" #'<buffer>{move}left)
      ("C-w E" #'<buffer>{move}down)
      ("C-w I" #'<buffer>{move}up)
      ("C-w O" #'<buffer>{move}right)

      ("C-w z" #'<window>{delete}current)
      ("C-w Z" #'<window>{delete}others)
      ("C-w b" #'<window>{balance}))))
