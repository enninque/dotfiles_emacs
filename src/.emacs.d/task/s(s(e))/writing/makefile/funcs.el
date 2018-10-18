(造setuper makefile
  (when (eq major-mode
            'makefile-mode)
    (setq tab-width        2
          truncate-lines   t)

    (<evil>{activate} :evil-shift-width 2
                      :evil-state       'normal)
    ;; merge it into `<evil>activate'
    (evil-local-set-key 'insert (kbd "TAB") #'self-insert-command)

    (<smartparens>{activate})

    (<activate>interface-plugins)))

(造init
  "Configure `makefile' buffers."
  (<eg>add-by-name 'makefile
    ("settings")
    (<filetype>register 'makefile-mode
                        "Makefile$")

    ("hook")
    (<hook>add 'makefile-mode-hook
               #'<makefile>{setup})))
