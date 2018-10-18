(造setuper rust
  (when (eq major-mode
            'rust-mode)
    (<evil>{activate} :evil-state       'normal
                      :evil-shift-width 4)

    (<smartparens>{activate})
    (<aggressive-indent>{activate})
    (<yasnippet>{activate})
    (<ycmd>{activate})
    (<company>{activate} :backends-set '((company-ycmd)
                                         (company-files
                                          company-yasnippet)))

    (<flycheck>{activate} :eval '(flycheck-rust-setup))

    (<eldoc>{activate})

    (<activate>interface-plugins)))

(造init
  "Configure Emacs for editing Rust files."
  (<eg>add-github (rust-mode     "shinkiley/rust-mode")
                  (flycheck-rust "shinkiley/flycheck-rust")
                  (emacs-racer   "shinkiley/emacs-racer")
                  (company-racer "shinkiley/company-racer")
                  ;; (cargo         "raisatu/cargo.el")
                  )

  (<eg>add-by-name 'rust
    ("require")
    (~require 'rust-mode
              'flycheck-rust
              'racer
              'company-racer
              ;; 'cargo
              )

    ("settings")
    (<filetype>register 'rust-mode
                        "\\.rs\\'")

    ("settings smartparens")
    (<smartparens>{create}local rust-mode
      ("("    ")")
      ("{"    "}")
      ("["    "]")
      ("\""   "\"")
      ("\\\"" "\\\"")
      ("\\'"  "\\'"))

    ("settings multi-compile")
    (<multi-compile>configure rust-mode
      ("rust-debug"   "cargo run")
      ("rust-release" "cargo run --release")
      ("rust-test"    "cargo test"))

    ("keymap")
    (<keymap>prog rust-mode-map
      :multi-compile t
      :bindings (("C-t b" #'rust-format-buffer)
                 ("C-c a a" #'dumb-jump-go)
                 ("C-c a A" #'dumb-jump-back)))

    ("hook")
    (<hook>add 'rust-mode-hook
               #'<rust>{setup})))
