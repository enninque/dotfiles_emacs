(造activator yasnippet
  (yas-minor-mode +1)

  (yas-recompile-all)
  (yas-reload-all))

(defun <yasnippet>{reload} ()
  "Recompile and reload snippets."
  (interactive)

  (yas-recompile-all)
  (yas-reload-all))

(造setuper yasnippet
  (when (eq major-mode
            'snippet-mode)
    (setq tab-width      2
          truncate-lines t)
    (<evil>{activate} :evil-shift-width 2
                      :evil-state       'normal)
    (<yasnippet>{activate})))

(造init
  "Configure `yasnippet'."
  (<eg>add-github
   (yasnippet "shinkiley/yasnippet")
   (auto-yasnippet "raisatu/auto-yasnippet"))

  (<eg>add-by-name 'yasnippet
    ("settings")
    (progn
      (<keymap>{create} yas-minor-mode-map
        ("C-x y r" #'<yasnippet>reload))

      (<keymap>{create} yas-keymap
        ("A-O"   #'yas-next-field)
        ("A-N"   #'yas-prev-field))

      (<keymap>{create} snippet-mode-map)

      (require 'yasnippet)
      (require 'auto-yasnippet)
      (define-key yas-minor-mode-map [(tab)] nil)
      (define-key yas-minor-mode-map (kbd "TAB") nil)

      (setq yas-snippet-dirs
            (f-join vikara-conf-directory
                    "yasnippet"
                    "snippets"))))

  (<eg>add-by-name 'yasnippet-snippet
    ("settings")
    (<filetype>register 'snippet-mode
                        "\\.yasnippet\\'")

    ("settings smartparens")
    (<smartparens>{create}local snippet-mode
                                ("("    ")")
                                ("{"    "}")
                                ("["    "]")
                                ("\""   "\"")
                                ("'"    "'")
                                ("\\\"" "\\\"")
                                ("\\'"  "\\'"))

    ("keymap")
    (<keymap>{save}{create} snippet-mode-map
      ("TAB" #'yas-expand))

    ("hook")
    (<hook>add 'snippet-mode-hook
               #'<yasnippet>{setup})))
