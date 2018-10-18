;;; package --- Summary -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(require '--execution-graph)
(require 'core-util)
(require 'url)

(defvar --vikara-execution-graph nil
  "Execution graph for all tasks.")

(defun <eg>create (&rest packages)
  (setq --vikara-execution-graph (eg/create))

  (dolist (task '(
                  ;; pre task
                  "-w"

                  ;; zero tasks
                  "zero require"
                  "zero configure"

                  ;; these tasks replaces Emacs' built-ins
                  "zero opt install"
                  "zero opt require"
                  "zero opt configure"

                  ;; these tasks add new libraries to Emacs
                  "zero lib install"
                  "zero lib require"

                  ;; these tasks contain utility functions
                  "zero util"

                  ;; some configuration
                  "zero post"

                  ;; base tasks
                  "base install"
                  "base require"
                  "base configure"
                  "base interface"

                  "base post install"
                  "base post require"

                  ;; tasks
                  "install"
                  "require"
                  "interface"
                  "settings"
                  "keymap"
                  "global-keymap"
                  "hook"
                  "post"
                  "post activate"
                  "post execute"))
    (eg/create-path --vikara-execution-graph task)))

(defmacro <eg>add-github (&rest packages)
  "Create git install task and add it to the default execution graph."
  `(progn
     ,@(cl-loop for (name src &key extra-path) in packages
                collect
                `(<eg>add-install :type 'git
                                  :name ',name
                                  :src  ,(format "https://github.com/%s"
                                                 src)
                                  ,@(when extra-path
                                      `(:extra-path ',extra-path))))))

(defmacro <eg>add-git (&rest packages)
  "Create git install task and add it to the default execution graph."
  `(progn
     ,@(cl-loop for (name src &key extra-path) in packages
                collect
                `(<eg>add-install :type 'git
                                  :name ',name
                                  :src  ,src
                                  ,@(when extra-path
                                      `(:extra-path ',extra-path))))))

(defmacro <eg>add-download (&rest packages)
  "Create git install task and add it to the default execution graph."
  `(progn
     ,@(cl-loop for (name src &keys (rename-to nil rename-to-p)) in packages
                collect
                `(<eg>add-install :type 'download
                                  :name ',name
                                  :src  ,src))))

(cl-defun <eg>add-install (&key (type         'package)
                                (package-list '())
                                (name         '__unnamed__)
                                (parents      nil)
                                (src          nil)
                                (post-hook    nil)
                                (extra-path   '()))
  "Add new execution node which installs PACKAGE-LIST."
  (let ((--type         (or type    'package))
        (--parents      (or parents '("install")))
        (--package-list package-list)
        (--lambda))
    (setq --lambda
          (cond
           ((eq --type 'download)
            (create-download-installer src))
           ((eq --type 'git)
            (create-git-installer src extra-path post-hook))
           (t nil)))

    (when --lambda
      (eg/add --vikara-execution-graph
              :parents --parents
              :name    name
              :func    --lambda))))

(defun create-download-installer (src)
  "Create lambd"
  (when (stringp src)
    (lambda ()
      (let ((--destination (<path>join vikara-plugin-directory
                                       (url-unhex-string (file-name-nondirectory src)))))
        (unless (file-exists-p --destination)
          (url-copy-file src
                         --destination))))))

(defun create-git-installer (src extra-path post-hook)
  "Create git installer lambda function."
  (when (stringp src)
    (lambda ()
      (let ((--destination (<path>join vikara-plugin-directory
                                       (file-name-nondirectory src))))
        (unless (file-exists-p --destination)
          (shell-command-to-string (format "git clone %s %s"
                                           src
                                           --destination))
          (when post-hook
            (shell-command-to-string (format "cd %s && %s"
                                             --destination
                                             post-hook))))

        (when (file-accessible-directory-p --destination)
          (add-to-list 'load-path --destination)

          (cl-loop for --ep in extra-path
                   do
                   (when (file-accessible-directory-p (<path>join --destination
                                                                  --ep))
                     (add-to-list 'load-path (<path>join --destination --ep)))))))))

(defun <eg>$create-function-from-list (list-arg)
  (cond
   ((eq (car list-arg)
        'function)
    (lambda ()
      (eval (cdr list-arg))))
   (t
    (lambda ()
      (eval list-arg)))))

(defun <eg>$create-function (arg)
  (cond
   ((null arg)
    arg)
   ((functionp arg)
    arg)
   ((symbolp arg)
    (symbol-value arg))
   ((listp arg)
    (<eg>$create-function-from-list arg))
   (t
    (error "%s can't become a function" arg))))

(defun <eg>$filter-parents (args)
  (cl-loop for arg in args by #'cddr
           collect arg))

(defun <eg>$filter-functions (args)
  (cl-loop for arg in (cdr args) by #'cddr
           collect (<eg>$create-function arg)))

(defun <eg>$filter-names (args)
  (cl-loop for arg in args by #'cddr
           collect (cadr arg)))

(cl-defun <eg>add (&key (parents nil)
                        (name    '__unnamed__)
                        (func    nil)
                        (node    nil node-p))
  "Add new execution node."
  (if node-p
      (eg/add --vikara-execution-graph
              :parents parents
              :node    node)
    (eg/add --vikara-execution-graph
            :parents parents
            :name    name
            :func    (<eg>$create-function func))))

(defmacro <eg>add-by-name (name &rest args)
  ""
  (declare (indent 1))
  (let ((parents-list (<eg>$filter-parents args))
        (function-list (<eg>$filter-functions args))
        (name (nth 1 name)))
    (cl-assert (eq (length parents-list)
                   (length function-list)))
    `(let ((name ',name))
       ,@(cl-loop for parents  in parents-list
                  for function in function-list
                  collect
                  `(eg/add --vikara-execution-graph
                           :name    ',name
                           :parents ',parents
                           :func    ',function)))))

(defmacro <eg>add-by-parents (parents &rest args)
  ""
  (declare (indent 1))

  (let ((names-list    (<eg>$filter-names     args))
        (function-list (<eg>$filter-functions args)))
    (cl-assert (eq (length names-list)
                   (length function-list)))

    `(let ((parents ',parents))
       ,@(cl-loop for name     in names-list
                  for function in function-list
                  collect
                  `(eg/add --vikara-execution-graph
                           :name    ',name
                           :func    ',function
                           :parents ',parents)))))

(defun <eg>execute ()
  "Execute execution graph."
  (eg/execute --vikara-execution-graph))

(provide 'core-execution)
;;; core-execution.el ends here
