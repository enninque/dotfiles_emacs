(造init
  "Configure `ivy'."
  (<eg>add-install :type      'git
                   :name      'ivy
                   :src       "https://github.com/abo-abo/swiper"
                   :post-hook "make compile")

  (<eg>add-by-name 'ivy
    ("require")
    (~require 'ivy)

    ("settings")
    (setq ivy-height 10)

    ("keymap")
    (progn
      (<keymap>{save} ivy-mode-map
                      ivy-minibuffer-map
                      ivy-occur-grep-mode-map
                      ivy-switch-buffer-map
                      ivy-occur-mode-map)

      (<keymap>{create} ivy-mode-map)
      (<keymap>{create} ivy-minibuffer-map
        ("A-n" #'minibuffer-keyboard-quit)
        ("A-e" #'ivy-next-line)
        ("A-i" #'ivy-previous-line)
        ("A-o" #'ivy-done)

        ("A-E" #'ivy-end-of-buffer)
        ("A-I" #'ivy-beginning-of-buffer))
      (<keymap>{create} ivy-occur-grep-mode-map)
      (<keymap>{create} ivy-switch-buffer-map)
      (<keymap>{create} ivy-occur-mode-map))))
