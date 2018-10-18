(defun <darkness>previous-state ()
  "Change current evil state to previous."
  (interactive)

  (evil-change-to-previous-state)

  (when (eq evil-state
            'visual)
    (evil-change-to-previous-state)))

(cl-defun <evil>{activate} (&key ((:evil-shift-width --evil-shift-width) 4       --evil-shift-width-p)
                                 ((:evil-state       --evil-state)       'normal --evil-state-p))
  "Activate evil."
  (evil-local-mode +1)
  (evil-search-highlight-persist +1)
  (evil-mc-mode +1)

  (let ((--state-name (format "evil-%s-state"
                              (symbol-name --evil-state))))
    (if (evil-state-p --evil-state)
        (funcall (symbol-function (intern --state-name)))
      (error "Strange state was proposed to evil")))

  (<var>set (evil-shift-width --evil-shift-width)))

(造toggler evil
  (cond
   (evil-mode
    (evil-mode -1))
   
   (evil-local-mode
    (evil-local-mode -1))
   
   (t
    (evil-local-mode +1)
    (evil-normal-state))))

(defmacro <evil>define (keymap evil-state &rest bindings)
  ""
  (declare (indent 2))

  (if (fboundp (intern (concat "evil-"
                               (symbol-name evil-state)
                               "-state")))
      `(progn
         ,@(cl-loop for (def binding) in bindings
                    collect
                    `(evil-define-key ',evil-state ,keymap
                       (kbd ,def) ,binding)))
    (error "No %s state defined by evil" evil-state)))

(造init
  "Configure `evil'."
  (<eg>add-github
   (evil                   "shinkiley/evil")
   (evil-nerd-commenter    "shinkiley/evil-nerd-commenter")
   (evil-visualstar        "shinkiley/evil-visualstar")
   (evil-matchit           "raisatu/evil-matchit")
   (evil-search-hl-persist "raisatu/evil-search-highlight-persist")
   (evil-mc                "raisatu/evil-mc")
   (evil-indent-plus       "raisatu/evil-indent-plus")
   (ace-jump-mode          "shinkiley/ace-jump-mode")
   (ace-window             "shinkiley/ace-window")
   (expand-region          "shinkiley/expand-region.el")
   (link-hint              "shinkiley/link-hint.el")
   (visual-regexp          "shinkiley/visual-regexp.el")
   (visual-regexp-steroids "shinkiley/visual-regexp-steroids.el")
   (zzz-to-char            "shinkiley/zzz-to-char")
   (spacekiller            "raisatu/emacs-spacekiller")
   (move-text              "raisatu/move-text")
   (yafolding              "raisatu/yafolding.el"))

  (<eg>add-by-name 'evil
    ("require")
    (progn
      (~require 'evil
                'evil-nerd-commenter
                'evil-visualstar
                'evil-matchit
                'evil-search-highlight-persist
                'evil-mc
                'evil-indent-plus
                'ace-jump-mode
                'ace-window
                'expand-region
                'link-hint
                'visual-regexp
                'visual-regexp-steroids
                'zzz-to-char
                'spacekiller
                'move-text
                'yafolding)

      ;; (defalias '<char>forward #'forward-char)
      ;; (defalias '<char>backward #'backward-char)
      ;; (defalias '<char>evil-forward #'evil-forward-char)
      ;; (defalias '<char>evil-backward #'evil-backward-char)
      ;; (defalias '<vline>next #'evil-visual-next-line)
      ;; (defalias '<vline>previous #'evil-visual-previous-line)
      )

    ("settings link-hint")
    (<var>set
      (browse-url-browser-function 'browse-url-firefox))

    ("settings hydra")
    (progn
      (<hydra>define line
        ("q"   nil)

        ("n" #'ignore)
        ("e" #'evil-next-visual-line)
        ("i" #'evil-previous-visual-line)
        ("o" #'ignore)

        ;; "z" #'clear-li
        ("Z" #'evil-delete-line))

      (<hydra>define cursor
        ("q"   nil)

        ("e"   #'evil-mc-make-and-goto-next-match)
        ("i"   #'evil-mc-make-and-goto-prev-match)
        ("A-e" #'evil-mc-skip-and-goto-next-match)
        ("A-i" #'evil-mc-skip-and-goto-prev-match)

        ("n"   #'evil-mc-make-and-goto-next-cursor)
        ("o"   #'evil-mc-make-and-goto-prev-cursor)
        ("A-n" #'evil-mc-skip-and-goto-next-cursor)
        ("A-o" #'evil-mc-skip-and-goto-prev-cursor)

        ("u"   #'evil-mc-undo-all-cursors)))

    ("keymap")
    ()

    ("global-keymap")
    (progn
      (<keymap>{define}global
        ("C-x t e"    #'<evil>{toggle})
        ("M-s"        #'evil-ex)

        ;; arst
        ("A-a"        #'evil-backward-word-begin)
        ("A-A"        #'evil-backward-WORD-begin)
        ("A-r"        #'evil-forward-word-begin)
        ("A-R"        #'evil-forward-WORD-begin)
        ("A-s"        #'evil-forward-word-end)
        ("A-S"        #'evil-forward-WORD-end)
        ("A-t"        #'evil-goto-line)
        ("A-T"        #'evil-goto-first-line)

        ;; qwfpg
        ("A-q"        #'evil-find-char)
        ("A-Q"        #'evil-find-char-backward)
        ("A-w"        #'evil-find-char-to)
        ("A-W"        #'evil-find-char-to-backward)
        ("A-f"        #'evil-forward-paragraph)
        ("A-F"        #'evil-backward-paragraph)
        ("A-p"        #'evil-scroll-page-down)
        ("A-P"        #'evil-scroll-page-up)

        ;; zxcvb
        ("A-z"        #'evil-search-next)
        ("A-Z"        #'evil-search-previous)
        ("A-X"        #'evil-jump-forward)
        ("A-x"        #'evil-jump-backward)

        ;; <Tab>123   
        ("<A-tab>"    #'evilmi-jump-items)
        ("A-1"        #'evil-search-forward)
        ("A-!"        #'evil-search-backward)
        ("A-2"        #'vr/isearch-forward)
        ("A-@"        #'vr/isearch-backward)
        ("A-3"        #'vr/replace)
        ("A-#"        #'vr/query-replace)

        ("<C-return>" #'link-hint-open-link))))

  (<eg>add-by-parents ("keymap evil")
    'emacs
    (<keymap>{define} evil-emacs-state-map)

    'basic-motion
    (<keymap>{define} evil-basic-motion-state-map
      ;; neio
      ("n" #'evil-backward-char)
      ("e" #'evil-next-visual-line)
      ("i" #'evil-previous-visual-line)
      ("o" #'evil-forward-char)

      ("N" #'evil-beginning-of-visual-line)
      ("E" #'evil-window-bottom)
      ("I" #'evil-window-top)
      ("O" #'evil-end-of-visual-line))
    
    'normal
    (progn
      (<keymap>{define} evil-normal-state-map
        ("DEL" #'ignore)
        
        ;; neio
        ("H-e" #'move-text-down)
        ("H-i" #'move-text-up)
        
        ;; qwfpg
        ("q"   #'ace-jump-char-mode)
        ("w"   #'ace-jump-word-mode)
        ("f"   #'yafolding-toggle-element)
        ("F"   #'yafolding-hide-parent-element)

        ;; zxvcb
        ("z"   #'evil-delete)
        ("x"   #'evil-yank)
        ("c"   #'evil-change)
        ("v"   #'evil-paste-after)
        ("V"   #'evil-paste-before)
        ("A-c" #'hydra-cursor/body)

        ;; arstd
        ("a"   #'evil-insert)
        ("A"   #'evil-insert-line)
        ("r"   #'evil-append)
        ("R"   #'evil-append-line)
        ("s"   #'evil-visual-char)
        ("t"   #'evil-visual-line)
        ("d"   #'evil-visual-block)

        ;; jluy;
        ("j"   #'evil-join)
        ("J"   #'evil-join-whitespace)
        ("l"   #'evil-invert-case)
        ("A-l" #'hydra-line/body)

        ;; km,./
        (","   #'evil-repeat)
        ("."   #'undo)
        (">"   #'redo)
        ("/"   #'evil-use-register))

      (<keymap>{bind}digits evil-normal-state-map
                            #'digit-argument))

    'motion
    (<keymap>{define} evil-motion-state-map
      ("n" #'backward-char)
      ("e" #'evil-next-line)
      ("i" #'evil-previous-line)
      ("o" #'forward-char)

      ("N" #'evil-beginning-of-line)
      ("E" #'evil-window-bottom)
      ("I" #'evil-window-top)
      ("O" #'evil-end-of-line)

      ("<deletechar>" 'ignore)
      ("DEL"          'ignore))

    'insert
    (<keymap>{define} evil-insert-state-map
      ("A-n" #'backward-char)
      ("A-e" #'evil-next-visual-line)
      ("A-i" #'evil-previous-visual-line)
      ("A-o" #'forward-char)

      ("A-о" #'backward-char)
      ("A-л" #'evil-next-visual-line)
      ("A-д" #'evil-previous-visual-line)
      ("A-ж" #'forward-char)

      ("A-N" #'beginning-of-line)
      ("A-E" #'evil-window-bottom)
      ("A-I" #'evil-window-top)
      ("A-O" #'end-of-line)

      ("A-О" #'beginning-of-line)
      ("A-Л" #'evil-window-bottom)
      ("A-Д" #'evil-window-top)
      ("A-Ж" #'end-of-line)

      ("RET" #'newline-and-indent)
      ("DEL" #'spacekiller-backspace)

      ;; Exit insert state
      ("C-SPC" #'<darkness>previous-state))

    'replace
    (<keymap>{define} evil-replace-state-map
      ("DEL" #'ignore)

      ("SPC" '<darkness>previous-state))

    'operator-state
    (<keymap>{define} evil-operator-state-map
      ("SPC" #'<darkness>previous-state)

      ("a"   evil-inner-text-objects-map)
      ("r"   evil-outer-text-objects-map))

    'text-objects
    (progn
      (<keymap>{define} evil-outer-text-objects-map
        ("'" #'evil-a-single-quote)
        ("\"" #'evil-a-double-quote)
        ("`" #'evil-a-back-quote)

        ("w" #'evil-a-word)
        ("W" #'evil-a-WORD)
        ("b" #'evil-a-paren)
        ("B" #'evil-a-curly)
        ("[" #'evil-a-bracket)
        ("<" #'evil-an-angle)

        ;; ("z" #'evil-a-tag)
        ;; ("x" #'evil-a-sentence)
        ;; ("c" #'evil-a-paragraph)

        ("i" 'evil-indent-plus-a-indent)
        ("I" 'evil-indent-plus-a-indent-up))

      (<keymap>{define} evil-inner-text-objects-map
        ("'" #'evil-inner-single-quote)
        ("\"" #'evil-inner-double-quote)
        ("`" #'evil-inner-back-quote)

        ("w" #'evil-inner-word)
        ("W" #'evil-inner-WORD)
        ("b" #'evil-inner-paren)
        ("B" #'evil-inner-curly)
        ("[" #'evil-inner-bracket)
        ("<" #'evil-inner-angle)

        ;; ("z" #'evil-inner-tag)
        ;; ("x" #'evil-inner-sentence)
        ;; ("c" #'evil-inner-paragraph)

        ("i" 'evil-indent-plus-i-indent)
        ("I" 'evil-indent-plus-i-indent-up)))

    'ex-keymap
    (<keymap>{define} evil-ex-completion-map
      ("RET" #'exit-minibuffer))

    'visual
    (<keymap>{define} evil-visual-state-map
      ("DEL"     #'ignore)

      ("<A-tab>" #'evil-jump-item)
      ("TAB"     #'er/expand-region)
      ("SPC"     #'evil-exit-visual-state)
      ("C-SPC"   #'ignore)

      ("A-1"     #'evil-visualstar/begin-search-forward)
      ("A-!"     #'evil-visualstar/begin-search-forward)
      
      ("a"       evil-outer-text-objects-map)
      ("r"       evil-inner-text-objects-map)
      ("A"       #'evil-insert)
      ("R"       #'evil-append)

      ("l"       #'evil-invert-case)
      
      ("z"       #'evil-delete)
      ("x"       #'evil-yank)
      ("c"       #'evil-change))))
