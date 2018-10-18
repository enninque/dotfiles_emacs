(造setuper nasm
  (when (<buffer>check-modes 'nasm-mode)
    (setq tab-width      4
          truncate-lines t)

    (<evil>{activate} :evil-shift-width 4
                      :evil-state       'normal)
    (<smartparens>{activate})
    (<aggressive-indent>{activate})

    (<yasnippet>{activate})
    (<flycheck>{activate})
    (<eldoc>{activate})

    (<activate>interface-plugins)))

(造init
  "Configure Emacs for NASM."
  (<eg>add-github (nasm-mode "shinkiley/nasm-mode"))

  (<eg>add-by-name 'nasm
    ("require")
    (~require 'nasm-mode)

    ("settings")
    (<filetype>register 'nasm-mode
                        "\\.nasm\\'")

    ("keymap")
    (<keymap>prog nasm-mode-map)

    ("hook")
    (<hook>add 'nasm-mode-hook
               #'<nasm>{setup})))
