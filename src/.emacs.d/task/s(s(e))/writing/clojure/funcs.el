(defun <clojure>? ()
  "Return t if major mode is `clojure-mode'."
  (eq major-mode
      'clojure-mode))

(defun <cider>eval-last-sexp ()
  "Executes last sexp.
 Differences from the original `cider-eval-last-sexp' that it respects `evil-mode'."
  (interactive)

  (if (not (or evil-mode
               evil-local-mode))
      (call-interactively #'cider-eval-last-sexp)
    (evil-insert-state)
    (unless (eq (point)
                (point-max))
      (forward-char 1))
    (call-interactively #'cider-eval-last-sexp)

    (evil-normal-state)))

(造setuper clojure
  (when (<clojure>?)
    (<var>ensure-local
     (tab-width      2)
     (truncate-lines t))

    (<evil>{activate} :evil-shift-width 2
                      :evil-state       'normal)
    (<smartparens>{activate})
    (<aggressive-indent>{activate})

    (<flycheck>{activate})
    (<yasnippet>{activate})
    (<company>{activate})

    (<eldoc>{activate})

    (<activate>interface-plugins)))

(造init
  "Configure `clojure-mode'."
  (<eg>add-github (clojure-mode "enquer/clojure-mode")
                  (cider        "enquer/cider"))

  (<eg>add-by-name 'clojure
    ("require")
    (~require 'cider
              'evil)

    ("settings")
    (<filetype>register 'clojure-mode
                        "\\.clj\\'"
                        "\\.cljs\\'")

    ("settings smartparens")
    (<smartparens>{create}local 'clojure-mode
      ("("    ")")
      ("{"    "}")
      ("["    "]")
      ("\""   "\"")
      ("`"    "'")
      ("\\\"" "\\\""))

    ("settings multi-compile")
    (<multi-compile>configure clojure-mode
      ("Eval this file"   "clojure %path"))

    ("keymap")
    (progn
      (<keymap>prog clojure-mode-map
        :multi-compile t 
        :bindings (("C-c C-c" #'cider-jack-in)

                   ("C-c e"   #'<cider>eval-last-sexp)
                   ("C-c E"   #'cider-eval-buffer)))

      (<keymap>{save}{create} cider-repl-mode-map
        ("A-n"     #'backward-char)
        ("A-i"     #'cider-repl-previous-input)
        ("A-e"     #'cider-repl-next-input)
        ("A-o"     #'forward-char)

        ("A-N"     #'beginning-of-line)
        ("A-O"     #'end-of-line)

        ("A-H-i"   #'cider-repl-previous-matching-input)
        ("A-H-e"   #'cider-repl-next-matching-input)

        ("C-k"     #'cider-repl-kill-input)
        ("C-c h"   #'cider-repl-history)

        ("C-c C-l" #'cider-repl-clear-buffer)

        ("RET"     #'cider-repl-return)
        ("TAB"     #'cider-repl-tab))

      (<keymap>{save}{create} cider-repl-history-mode-map))

    ("hook")
    (<hook>add 'clojure-mode-hook
               #'<clojure>{setup})))
