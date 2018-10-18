(defun <multi-compile>run ()
  "Saves current buffer and invokes `multi-compile-run'."
  (interactive)

  (save-buffer)
  (multi-compile-run))

(defmacro <multi-compile>configure (m-mode &rest args)
  "Create lambda that configures `multi-compile'."
  (declare (indent 1))

  `(add-to-list 'multi-compile-alist
                ',`(,m-mode . (,@(cl-loop for (name cmd) in args
                                          collect
                                          `(,name . ,cmd))))))

(造init
  "Configure `multi-compile'."
  (<eg>add-github (multi-compile "shinkiley/emacs-multi-compile"))

  (<eg>add-by-name 'multi-compile
    ("require")
    (~require 'multi-compile)

    ("settings")
    (setq multi-compile-alist             ()
          multi-compile-completion-system 'helm
          multi-compile-history-file      (f-join vikara-tmp-directory
                                                  "multi-compile.cache"))))
