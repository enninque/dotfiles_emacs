(造activator smartparens)

(~defm <smartparens>{create}local (mode &rest args)
  "Configure smartparens locally."
  (declare (indent 1))

  `(let ((mode ',mode))
     ,@(cl-loop for (beg end) in args
                collect
                `(sp-local-pair mode
                                ,beg
                                ,end))))

(~defn <smartparens>clear ()
  "Remove all default pairs."
  (let ((pairs-to-delete (list "\\\\("
                               "\\{"
                               "\\("
                               "\\\""
                               "/*"
                               "\""
                               "'"
                               "("
                               "["
                               "{"
                               "`")))
    (dolist (pair-to-delete pairs-to-delete)
      (sp-pair pair-to-delete nil :actions :rem))))

(造init
  "Configure smartparens."
  (<eg>add-github (smartparens "shinkiley/smartparens"))

  (<eg>add-by-name 'smartparens
    ("require")
    (~require 'smartparens)

    ("settings")
    (<smartparens>clear)))
