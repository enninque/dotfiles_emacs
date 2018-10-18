(造setuper git
  (when (cl-member major-mode
                   '(gitattributes-mode gitconfig-mode gitignore-mode))
    (<var>ensure-local
     (tab-width      4)
     (truncate-lines t))

    (<evil>{activate} :evil-shift-width 4
                      :evil-state       'normal)

    (<activate>interface-plugins)))

(造init
  "Configure Emacs for writing git files."
  (<eg>add-github (git-modes "raisatu/git-modes"))

  (<eg>add-by-name 'git-modes
    ("require")
    (~require 'git-modes)

    ("settings")
    (progn
      (<filetype>register 'gitattributes-mode
                          "\\.gitattributes$"
                          "\\.git/info/attributes$$"
                          "\\.git/attributes$")
      (<filetype>register 'gitconfig-mode
                          "\\.gitconfig$"
                          "\\.git/config$$"
                          "git/config$"
                          "\\.gitmodules$")
      
      (<filetype>register 'gitignore-mode
                          "\\.gitignore$"
                          "\\.git/info/exclude$"
                          "git/ignore$"))

    ("hook")
    (progn
      (<hook>add 'gitattributes-mode-hook
                 #'<git>{setup})
      (<hook>add 'gitconfig-mode-hook
                 #'<git>{setup})
      (<hook>add 'gitignore-mode-hook
                 #'<git>{setup}))))

(provide 'funcs)
