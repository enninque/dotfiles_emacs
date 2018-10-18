;;; package --- Summary -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; Path variables
(defvar vikara-start-directory
  user-emacs-directory
  "Vikara start directory.")

(defconst vikara-core-directory
  (expand-file-name (concat vikara-start-directory
                            (file-name-as-directory "core")))
  "Vikara core directory.")

(defconst vikara-nyamacs-directory
  (expand-file-name (concat vikara-start-directory
                            (file-name-as-directory "core")
                            (file-name-as-directory "nyamacs")))
  "Vikara nyamacs directory.")

(defconst vikara-tmp-directory
  (expand-file-name (concat vikara-start-directory
                            (file-name-as-directory ".tmp")))
  "Vikara directory for temporary files.")

(defconst vikara-task-directory
  (expand-file-name (concat vikara-start-directory
                            (file-name-as-directory "task")))
  "Directory for vikara tasks.")

(defconst vikara-plugin-directory
  (expand-file-name (concat vikara-start-directory
                            (file-name-as-directory "plugin")))
  "Directory for manual installed plugins.")

(defconst vikara-lib-directory
  (expand-file-name (concat vikara-start-directory
                            (file-name-as-directory "lib")))
  "Directory for manual installed libraries.")

(defconst vikara-conf-directory
  (expand-file-name (concat vikara-start-directory
                            (file-name-as-directory "conf")))
  "Directory for various configuration files except `.el'.")

(defconst vikara-layouts-directory
  (expand-file-name (concat vikara-conf-directory
                            (file-name-as-directory "layouts")))
  "Directory for various configuration files except `.el'.")

(defconst vikara-assets-directory
  (expand-file-name (concat vikara-start-directory
                            (file-name-as-directory "assets")))
  "Directory for asset files.")

(defconst vikara-images-directory
  (expand-file-name (concat vikara-start-directory
                            (file-name-as-directory "assets")
                            (file-name-as-directory "images")))
  "Directory for asset files.")

(defconst vikara-sounds-directory
  (expand-file-name (concat vikara-start-directory
                            (file-name-as-directory "assets")
                            (file-name-as-directory "sounds")))
  "Directory for asset files.")

;; Change load-path
(cl-flet ((add-to-load-path (dir)
                            (add-to-list 'load-path dir)))
  (mapc #'add-to-load-path
        `(
          ,vikara-core-directory
          ,vikara-nyamacs-directory
          ,vikara-plugin-directory
          ,vikara-lib-directory
          ,(concat vikara-core-directory "func/")
          ))

  (dolist (base (list vikara-plugin-directory))
    (dolist (f (directory-files base))
      (let ((name (concat base f)))
        (when (and (file-directory-p name)
                   (not (equal f ".."))
                   (not (equal f ".")))
          (add-to-load-path name))))))


;;; core-load-path.el ends here
