(造activator undo-tree
  (global-undo-tree-mode +1))

(造init
  "Configure `undo-tree'."
  (<eg>add-github (undo-tree "shinkiley/undo-tree"))

  (<eg>add-by-name 'undo-tree
    ("require")
    (progn
      ;; this doesn't work for some reason
      ;; todo: make this work
      ;; (<keymap>create undo-tree-map
      ;;   ("A-/" #'undo-tree-undo)
      ;;   ("A-?" #'undo-tree-redo))
      (~require 'undo-tree))

    ("global-keymap")
    (<keymap>{define}global
      ("A-/" #'undo-tree-undo)
      ("A-?" #'undo-tree-redo))

    ("post activate")
    (<undo-tree>{activate})))
