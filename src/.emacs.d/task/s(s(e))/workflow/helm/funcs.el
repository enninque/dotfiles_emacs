(造activator helm)

(造init
  "Configure `helm'."
  (<eg>add-install :type      'git
                   :name      'helm
                   :src       "https://github.com/shinkiley/helm"
                   :post-hook "make")

  (<eg>add-github (helm-inserter "raisatu/emacs-helm-inserter")
                  (helm-ag       "raisatu/emacs-helm-ag"))

  (<eg>add-by-name 'helm
    ("require")
    (~require 'helm-lib
              'helm-config
              'helm-source
              'helm-buffers
              'helm-ag
              'emacs-helm-inserter)

    ("settings")
    (progn
      (when (executable-find "curl")
        (setq helm-google-suggest-use-curl-p t))

      (<var>set
        "`helm' settings."
        (helm-split-window-in-side-p           t)
        (helm-buffers-fuzzy-matching           t)
        (helm-move-to-line-cycle-in-source     t)
        (helm-ff-search-library-in-sexp        t)
        (helm-ff-file-name-history-use-recentf t))

      (<var>set
        "`emacs-helm-inserter' settings"
        (emacs-helm-inserter-candidates '(("create"           . "造")
                                          ("darkness"         . "暗")
                                          ("enlightenment"    . "悟"))))

      (<var>set
        "`helm-ag' settings"
        (helm-ag-fuzzy-match t)))

    ("keymap")
    (progn
      (<keymap>{save}{create} helm-map
        ;; neio
        ("A-n" #'backward-char)
        ("A-e" #'helm-next-line)
        ("A-i" #'helm-previous-line)
        ("A-o" #'forward-char)

        ("A-E" #'helm-next-source)
        ("A-I" #'helm-previous-source)
        ("A-O" #'helm-execute-persistent-action)

        ("C-g" #'helm-keyboard-quit)

        ("RET" #'helm-maybe-exit-minibuffer)
        ("TAB" #'helm-select-action))

      (<keymap>{save}{create} helm-buffer-map))

    ("global-keymap")
    (<keymap>{define}global
      ("M-a"       #'helm-M-x)
      ("C-x f"     #'helm-find-files)
      ("C-x h y"   #'helm-show-kill-ring)

      ("C-x <C-i>" #'emacs-helm-inserter)

      ("C-f r"     #'helm-ag-this-file))

    ("post activate")
    #'<helm>{activate}))
