(~defm <which-key>-define-keys (mode keymap-name &rest bindings)
  (declare (indent 2))
  (let ((keymap-bindings      (cl-loop for (kbd func desc) in bindings
                                       collect (list kbd func)))
        (binding-descriptions (cl-loop for (kbd func desc) in bindings
                                       collect kbd
                                       collect desc)))
    `(progn
       (<keymap>{define} ,keymap-name
         ,@keymap-bindings)
       ,(if mode
            `(which-key-add-major-mode-key-based-replacements ',mode
               ,@binding-descriptions)
          `(which-key-add-key-based-replacements
             ,@binding-descriptions)))))

(~defm <which-key>create (mode keymap &rest bindings)
  (declare (indent 2))
  ;; fix leak here
  (let ((mode mode))
    `(progn
       (setq ,keymap (make-sparse-keymap))
       (<which-key>-define-keys ,mode ,keymap
         ,@bindings))))

(~defm <which-key>define (mode keymap-name &rest bindings)
  (declare (indent 2))
  `(<which-key>-define-keys ,mode
       ,keymap-name
     ,@bindings))

(~defm <which-key>define-global (&rest bindings)
  `(<which-key>-define-keys nil
       global-map
     ,@bindings))

(造activator which-key)

(造init
  "Configure `which-key'."
  (<eg>add-github (which-key "shinkiley/emacs-which-key"))

  (<eg>add-by-name 'which-key
    ("require")
    (~do
     (~require 'which-key))

    ("settings")
    (~do
     (~set (which-key-idle-delay 0.2))
     (which-key-setup-side-window-bottom))

    ("post activate")
    (<which-key>{activate})))
