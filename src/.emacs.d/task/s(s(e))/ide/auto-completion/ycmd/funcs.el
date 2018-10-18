(defvar vikara-ycmd-path nil
  "")

(造activator ycmd)

(造init
  "Configure ycmd"
  (<eg>add-github (emacs-ycmd "shinkiley/emacs-ycmd"))

  (<eg>add-by-name 'ycmd
    ("require")
    (~require 'ycmd
              'company-ycmd
              'flycheck-ycmd)

    ("settings")
    (progn
      (let ((ycmd-path (eval vikara-ycmd-path)))
        (setq ycmd-server-command (list "python"
                                        ycmd-path))
        (setq ycmd-global-config (f-join vikara-conf-directory
                                         ".global_config.py"))
        (setq ycmd-force-semantic-completion t)))))
