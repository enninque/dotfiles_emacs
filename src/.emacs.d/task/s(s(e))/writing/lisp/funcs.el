(defmacro <slime>define-keys (mode &rest args)
  "Define slime keys."
  (declare (indent 1))
  `(slime-define-keys ,mode
     ,@args))

(造setuper lisp
  (when (eq major-mode
            'lisp-mode)
    (setq tab-width      2
          truncate-lines t)

    (<evil>{activate} :evil-shift-width 2
                      :evil-state       'normal)
    (<smartparens>{activate})
    (<aggressive-indent>{activate})
    (<yasnippet>{activate})
    (<company>{activate} :backends-set '((company-slime)
                                         (company-keywords company-files)))
    (<eldoc>{activate})

    (<activate>interface-plugins)))

(造init
  "Configure `lisp-mode'."
  (<eg>add-github (slime         "shinkiley/slime")
                  (slime-company "shinkiley/slime-company"))

  (<eg>add-by-name 'lisp-mode
    ("require")
    (~require 'slime
              'slime-company
              'slime-autoloads)
    
    ("settings")
    (let ((lisp-implementations (eval <cl>implementations)))
      (<filetype>register 'lisp-mode
                          "\\.lsp\\'"
                          "\\.lisp\\'"
                          "\\.cl\\'")
      (setq slime-lisp-implementations      lisp-implementations
            slime-default-lisp              'sbcl
            slime-complete-symbol-function  'slime-fuzzy-complete-symbol
            slime-fuzzy-completion-in-place t
            slime-contribs                  '(slime-fancy slime-company))

      (slime-setup '(slime-fancy slime-company)))

    ("settings smartparens")
    (<smartparens>{create}local lisp-mode
      ("("    ")")
      ("{"    "}")
      ("["    "]")
      ("\""   "\"")
      ("`"    "'")
      ("\\\"" "\\\""))

    ("keymap")
    (<keymap>prog lisp-mode-map
      :bindings (("C-c c" #'slime-eval-last-expression)))

    ("hook")
    (<hook>add 'lisp-mode-hook
               #'<lisp>{setup})))
