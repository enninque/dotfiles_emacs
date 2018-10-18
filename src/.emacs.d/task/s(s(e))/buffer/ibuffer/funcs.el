(造setuper ibuffer
           (ibuffer-switch-to-saved-filter-groups "default"))

(造init
  "Configure `ibuffer'."
  (<eg>add-by-name 'ibuffer
    ("require")
    (~require 'ibuffer
              'ibuf-ext
              'nyamacs-ibuffer)

    ("settings")
    (progn
      (setq ibuffer-saved-filter-groups
            '(("default"
               ("dired" (mode . dired-mode)))))
      (setq ibuffer-never-show-predicates '("^\\*")))

    ("keymap")
    (progn
      (<keymap>{save}{create} ibuffer-mode-map
        ;; neio
        ("e"          #'ibuffer-forward-line)
        ("i"          #'ibuffer-backward-line)
        ("E"          #'ibuffer-forward-filter-group)
        ("I"          #'ibuffer-backward-filter-group)

        ;; arstd
        ("a a"        #'<ibuffer>mark)
        ("a A"        #'<ibuffer>mark-all)
        ("a r"        #'<ibuffer>unmark)
        ("a R"        #'ibuffer-unmark-all)
        ("a s"        #'ibuffer-mark-unsaved-buffers)
        ("a S"        #'ibuffer-mark-read-only-buffers)
        ("a t"        #'ibuffer-mark-by-mode)
        ("a d"        #'ibuffer-mark-help-buffers)
        ("a D"        #'ibuffer-mark-dired-buffers)

        ("r a"        #'ibuffer-do-delete)
        ("r A"        #'ibuffer-do-save)

        ("s a"        #'ibuffer-do-sort-by-alphabetic)
        ("s f"        #'ibuffer-do-sort-by-filename/process)
        ("s i"        #'ibuffer-invert-sorting)
        ("s m"        #'ibuffer-do-sort-by-major-mode)
        ("s s"        #'ibuffer-do-sort-by-size)

        ;; qwfpg
        ("q"          #'<buffer>{kill}current)

        ("RET"        #'ibuffer-visit-buffer)
        ("<C-return>" #'ibuffer-visit-buffer-other-window))

      (<keymap>{bind}digits ibuffer-mode-map #'digit-argument))

    ("hook")
    (<hook>add 'ibuffer-mode-hook
               #'<ibuffer>{setup})))
