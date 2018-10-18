;; -*- mode: emacs-lisp -*-

(setq vikara-user-full-name "")
(setq vikara-user-email "")
(setq vikara-ycmd-path '(f-join (f-root)
                                "opt"
                                "shared"
                                "ycmd"
                                "ycmd"))
(let ((names '("sbcl")))
  (setq <cl>implementations
        `(cl-loop for name in ',names
                  collect (list (intern name)
                                (list (executable-find name))))))

(setq vikara-dired-helm-locations
      '("Home"               (func/system/user-home)
        "Org directory"      org-directory
        "Org wiki directory" org-wikinyan-location))
