(造setuper xdefaults
  (when (eq major-mode
            'conf-xdefaults-mode)
    (<var>ensure-local
     (tab-width      4)
     (truncate-lines t))

    (<evil>{activate} :evil-shift-width 4
                      :evil-state       'normal)

    (<activate>interface-plugins)))

(造init
  "Configure `xdefaults'."
  (<eg>add-by-name 'xdefaults
    ("settings")
    (<filetype>register 'conf-xdefaults-mode
                        "\\.Xresources\\'")

    ("keymap")
    (<keymap>prog conf-xdefaults-mode-map)

    ("hook")
    (<hook>add 'conf-xdefaults-mode-hook
               #'<xdefaults>setup-buffer)))
