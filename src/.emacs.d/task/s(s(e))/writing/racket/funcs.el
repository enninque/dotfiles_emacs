(defun <racket>send ()
  "Send a region(if any) or last sexp(otherwise) to racket repl."
  (interactive)
  
  (if (region-active-p)
      (call-interactively #'racket-send-region)
    (call-interactively #'racket-send-last-sexp)))

(造setuper racket
  (when (eq major-mode
            'racket-mode)
    (<var>ensure-local
     (tab-width 2)
     (truncate-lines t))
    (<evil>{activate} :evil-state       'normal
                      :evil-shift-width 2)
    (<smartparens>{activate})
    (<aggressive-indent>{activate})

    (<flycheck>{activate})
    (<yasnippet>{activate})
    (<company>{activate})

    (<activate>interface-plugins)))

(造init
  "Configure `racket'."
  (<eg>add-github (racket-mode "shinkiley/racket-mode"))

  (<eg>add-by-name 'racket
    ("require")
    (~require 'racket-mode)

    ("settings")
    (<filetype>register 'racket-mode "\\.rkt\\'")

    ("settings smartparens")
    (<smartparens>{create}local racket-mode
      ("("    ")")
      ("{"    "}")
      ("["    "]")
      ("\""   "\"")
      ("`"    "'")
      ("\\\"" "\\\""))

    ("keymap")
    (<keymap>prog racket-mode-map
      :bindings (("C-c C-c" #'racket-repl)
                 ("C-c e"   #'<racket>send)
                 ("C-c E"   #'racket-run)))

    ("hook")
    (<hook>add 'racket-mode-hook
               #'<racket>{setup})))
