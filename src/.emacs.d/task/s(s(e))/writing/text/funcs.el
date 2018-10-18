(造setuper text
  (<var>ensure-local
   (tab-width 4))
  (<evil>{activate} :evil-shift-width 4
                    :evil-state 'normal)
  (<linum-relative>{activate}))

(造init
  "Configure `text-mode'."
  (<eg>add-by-name 'text
    ("settings")
    (<filetype>register 'text-mode
                        "\\.txt\\'")

    ("keymap")
    (<keymap>{save}{create} text-mode-map
      ("C-c C-z |" 'table-insert)

      ("C-c C-n"   'table-backward-cell)
      ("C-c <C-o>" 'table-forward-cell)

      ("C-c N"   'table-narrow-cell)
      ("C-c E"   'table-heighten-cell)
      ("C-c I"   'table-shorten-cell)
      ("C-c O"   'table-widen-cell)

      ("C-c t r" 'table-insert-row)
      ("C-c t c" 'table-insert-column)
      ("C-c t R" 'table-delete-row)
      ("C-c t C" 'table-delete-column)
      ("C-c t _" 'table-split-cell-vertically)
      ("C-c t |" 'table-split-cell-horizontally)
      ("C-c t j" 'table-justify))

    ("hook")
    (<hook>add 'text-mode-hook
               #'<text>{setup})))
