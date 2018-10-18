(造setuper lua
  (when (eq major-mode
            'lua-mode)
    (<var>ensure-local
     (tab-width      4)
     (truncate-lines t))

    (<evil>{activate} :evil-state       'normal
                      :evil-shift-width 4)

    (<yasnippet>{activate})
    (<flycheck>{activate})
    (<company>{activate} :backends-set '(company-lua))
    (<eldoc>{activate})
    (<flycheck>{activate})

    (<activate>interface-plugins)))

(造init
  "Configure `lua-mode'."
  (<eg>add-github (lua-mode    "shinkiley/lua-mode")
                  (company-lua "ptrv/company-lua"))

  (<eg>add-by-name 'lua
    ("require")
    (~require 'lua-mode
              'company-lua)

    ("settings")
    (<filetype>register 'lua-mode "\\.lua\\'")

    ("settings multi-compile")
    (add-to-list 'multi-compile-alist '(lua-mode . (("Execute" . "lua %path"))))

    ("keymap")
    (<keymap>prog lua-mode-map
      :multi-compile t)

    ("hook")
    (<hook>add 'lua-mode-hook #'<lua>{setup})))
