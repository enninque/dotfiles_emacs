(defun <markdown>? ()
  "Return t if current mode is `markdown-mode'"
  (eq major-mode
      'markdown-mode))

(造setuper markdown
  (when (<markdown>?)
    (<var>ensure-local
     (tab-width                4)
     (show-trailing-whitespace t)
     (truncate-lines           t))

    (<evil>{activate} :evil-shift-width 4)

    (<activate>interface-plugins)))

(造init
  "Configure `markdown'."

  (<eg>add-github (markdown-mode  "shinkiley/markdown-mode")
                  (markdown-mode+ "shinkiley/markdown-mode-plus"))

  (<eg>add-by-name
      'markdown
    ("require")
    (~require 'markdown-mode
              'markdown-mode+)

    ("settings")
    (progn
      (<filetype>register 'markdown-mode
                          "\\.markdown\\'"
                          "\\.md\\'")
      (<filetype>register 'gfm-mode
                          "README\\.md\\'"))

    ("keymap")
    (progn
      (cl-macrolet ((--setup-markdown-keymap
                     (map)
                     `(progn
                        (setq ,map (make-sparse-keymap))

                        ;; `Anchors'
                        (define-key ,map (kbd "C-c a l")    #'markdown-insert-link)
                        (define-key ,map (kbd "C-c a u")    #'markdown-insert-uri)
                        (define-key ,map (kbd "C-c a f")    #'markdown-insert-footnote)
                        (define-key ,map (kbd "C-c a w")    #'markdown-insert-wiki-link)

                        ;; `image'
                        (define-key ,map (kbd "C-c i i")    #'markdown-insert-image)
                        (define-key ,map (kbd "C-c i t")    #'markdown-toggle-inline-images)

                        ;; `style'
                        (define-key ,map (kbd "C-c s e")    #'markdown-insert-italic)
                        (define-key ,map (kbd "C-c s b")    #'markdown-insert-bold)
                        (define-key ,map (kbd "C-c s c")    #'markdown-insert-code)
                        (define-key ,map (kbd "C-c s C")    #'markdown-insert-gfm-code-block)
                        (define-key ,map (kbd "C-c s -")    #'markdown-insert-strike-through)

                        ;; `hr'
                        (define-key ,map (kbd "C-c -")      #'markdown-insert-hr)

                        ;; `headers',
                        (define-key ,map (kbd "C-c t !")    #'markdown-insert-header-setext-1)
                        (define-key ,map (kbd "C-c t @")    #'markdown-insert-header-setext-2)
                        (define-key ,map (kbd "C-c t 1")    #'markdown-insert-header-atx-1)
                        (define-key ,map (kbd "C-c t 2")    #'markdown-insert-header-atx-2)
                        (define-key ,map (kbd "C-c t 3")    #'markdown-insert-header-atx-3)
                        (define-key ,map (kbd "C-c t 4")    #'markdown-insert-header-atx-4)
                        (define-key ,map (kbd "C-c t 5")    #'markdown-insert-header-atx-5)
                        (define-key ,map (kbd "C-c t 6")    #'markdown-insert-header-atx-6)

                        ;; `regions',
                        (define-key ,map (kbd "C-c r p")    #'markdown-pre-region)
                        (define-key ,map (kbd "C-c r q")    #'markdown-blockquote-region)

                        ;; `compile',
                        (define-key ,map (kbd "C-c c b")    #'markdown-other-window)
                        (define-key ,map (kbd "C-c c p")    #'markdown-preview)
                        (define-key ,map (kbd "C-c c e")    #'markdown-export)
                        (define-key ,map (kbd "C-c c v")    #'markdown-export-and-preview)
                        (define-key ,map (kbd "C-c c l")    #'markdown-live-preview-mode)

                        ;; `open'
                        (define-key ,map (kbd "C-c o")      #'markdown-follow-thing-at-point)

                        ;; `promotion'
                        (define-key ,map (kbd "C-c -")      #'markdown-promote)
                        (define-key ,map (kbd "C-c =")      #'markdown-demote)

                        ;; `completion'
                        (define-key ,map (kbd "C-c RET")    #'markdown-complete)

                        ;; `list'
                        (define-key ,map (kbd "<C-return>") #'markdown-insert-list-item)

                        ;; `kill'
                        (define-key ,map (kbd "C-c k")      #'markdown-kill-thing-at-point))))

        (<keymap>{save} markdown-mode-map
                        gfm-mode-map)

        ;; Use new keymaps
        (--setup-markdown-keymap markdown-mode-map)
        (--setup-markdown-keymap gfm-mode-map)))

    ("hook")
    (<hook>add 'markdown-mode-hook #'<markdown>{setup})))
