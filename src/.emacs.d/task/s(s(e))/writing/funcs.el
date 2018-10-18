(defun <activate>interface-plugins ()
  "Activate interface plugins"

  (<settings>show-trailing-whitespaces)
  (<highlight-numbers>{activate})
  (<highlight-symbol>{activate})
  (<highlight-todo>{activate})
  (<rainbow-delimiters>{activate})
  (<rainbow-mode>{activate})
  (<linum-relative>{activate})
  (<indent-guide>{activate})
  (<column-enforce>{activate}))

(defconst <keymap>prog-bindings
  '(("TAB"       #'yas-expand)
    ("<backtab>" #'aya-expand)

    ("C-t ="     #'evil-indent)
    ("C-t /"     #'evilnc-comment-or-uncomment-lines)))

(defconst <keymap>emmet-bindings
  '(("<C-tab>" #'<emmet>expand)))

(defconst <keymap>multi-compile-bindings
  '(("C-c c" #'multi-compile-run)))

(defun append-if (form front tail)
  ""
  (if form
      (append front tail)
    front))

(cl-defmacro <keymap>prog (modesymbol &key
                                      (emmet nil)
                                      (multi-compile nil)
                                      ((:bindings additional-bindings) '() bindings-p))
  ""
  (declare (indent 1))

  (let ((bindings <keymap>prog-bindings))
    (setq bindings
          (append-if emmet
                     bindings
                     <keymap>emmet-bindings))
    (setq bindings
          (append-if multi-compile
                     bindings
                     <keymap>multi-compile-bindings))

    (setq bindings
          (append-if bindings-p
                     bindings
                     additional-bindings))

    `(<keymap>{save}{create} ,modesymbol
       ,@bindings)))
