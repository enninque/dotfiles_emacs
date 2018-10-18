(造init
  "Configure keys."
  
  (<eg>add-by-parents ("global-keymap")
    'unset-bindings
    (<keymap>{clear}global-map)

    'clear-key-translation-map
    (<keymap>{create} key-translation-map)

    'clear-function-key-map
    (<keymap>{clear}function-map)

    'input-decode-map
    (progn
      (define-key input-decode-map [?\C-m] [C-m])
      (define-key input-decode-map [?\C-o] [C-o])
      (define-key input-decode-map [?\C-i] [C-i]))

    ;; TODO: move to another file
    'configure-outline-mode-map
    (<keymap>{save}{create} outline-mode-map)

    'create-new
    (progn
      (dolist (elem '("C-0" "C-1" "C-2" "C-3" "C-4" "C-5" "C-6" "C-7" "C-8" "C-9"))
        (global-set-key (kbd elem) 'digit-argument))

      (<keymap>{define}global
        ("C-`" #'universal-argument))

      (<keymap>{save}{create} universal-argument-map
        ("C-`" #'universal-argument-more))

      (<keymap>{bind}digits universal-argument-map
                            #'digit-argument)

      ;; save/kill
      (<keymap>{define}global
        ("C-x C-s"     #'save-buffer)
        ("C-x C-S-s"   #'<tramp>sudo-write)
        ("C-x C-x C-s" #'<buffer>invoke-save-function)
        ("C-x C-c"     #'<buffer>{kill}current)
        ("C-x C-q"     #'save-buffers-kill-terminal)
        ("C-x C-x C-c" #'<buffer>{kill}current)
        ("C-x C-h"     #'previous-buffer)
        ("C-x C-g"     #'revert-buffer))

      ;; toggles
      (<keymap>{define}global
        ("C-x t r"     #'read-only-mode))

      (<keymap>{define}global
        ("C-x C-t v"   #'yank))

      ;; macro
      (<keymap>{define}global
        ("<C-m> n"     #'kmacro-start-macro-or-insert-counter)
        ("<C-m> r"     #'kmacro-end-or-call-macro))

      ;; misc
      (<keymap>{define}global
        ("C-g"         #'keyboard-quit)
        ("M-r"         #'eval-expression)))))
