;;; -*- lexical-binding: t -*-

(require 'cl-lib)

(defconst vikara-emacs-min-version "25.3.1"
  "Minimal version of Emacs.")

(defun <vikara> ()
  "Initialize."
  (if (not (version<= vikara-emacs-min-version
                      emacs-version))
      (error (concat "Your version of Emacs (%s) is too old.\n"
                     "Vikara requires Emacs version %s or above.")
             emacs-version vikara-emacs-min-version)
    (progn
      (load-file (concat (file-name-directory load-file-name)
                         (file-name-as-directory "core")
                         "core-load-path.el"))
      (require 'core-vikara)
      (require 'nyamacs)
      (<vikara>init)
      (require 'vikara-misc))))

(<vikara>)

(provide 'init)
;;; init.el ends here
