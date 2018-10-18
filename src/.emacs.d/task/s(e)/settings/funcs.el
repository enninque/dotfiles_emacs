(造init
  "Configure Emacs settings."
  (<eg>add-by-name 'settings
    ("base configure")
    (progn
      (<var>set
        "Configure gc."
        (gc-cons-threshold            50000000)
        (large-file-warning-threshold 100000000))

      (<var>set
        "Set user name and email."
        (user-full-name    vikara-user-full-name)
        (user-mail-address vikara-user-email))

      (<var>set
        "Auto save and backups."
        (make-backup-files        nil)
        (auto-save-list-file-name nil)
        (auto-save-default        nil))

      (<var>set
        "Temporary files setup"
        (auto-save-list-file-prefix (f-join vikara-tmp-directory
                                            "auto-save-list"
                                            ".saves-"))
        (recentf-save-file (f-join vikara-tmp-directory
                                   "recentf.el"))
        (bookmark-default-file (f-join vikara-tmp-directory
                                       "bookmarks.el")))

      (<var>set
        "Disable default mode selection."
        (auto-mode-alist ()))

      (<var>set
        "Disable verbose mode of `auto-revert-mode'"
        (auto-revert-verbose nil))

      (<var>set-default
        "Use spaces instead of tabs."
        (indent-tabs-mode nil)
        (tab-width        4))

      (<var>set
        "Word wrapping."
        (word-wrap t))

      (<var>set
        "Enable file variables without asking of the user."
        (enable-local-eval      t)
        (enable-local-variables t))

      (<mode>disable electric-pair-mode
                     electric-indent-mode
                     auto-revert-mode))))
