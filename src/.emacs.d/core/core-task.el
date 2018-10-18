;;; package --- Summary
;;; Commentary:
;;; Code:

;; (require 'core-util)

;; Vars
(defvar vikara-tasks (list)
  "List of tasks that will be executed.")

;; Funcs
(defun <task>add (task)
  "Add TASK to `vikara-tasks'."
  (add-to-list 'vikara-tasks task t))

(defun <task>execute (task)
  "Execute subtask TASK of PARENT-TASK."
  (cl-flet ((--eval-file (file)
                         (load-file file)
                         (with-temp-buffer
                           (insert-file-contents file)
                           (emacs-lisp-mode)
                           (goto-char (point-max))
                           (backward-sexp)
                           (eval (sexp-at-point)))))
    (cl-flet ((--load-funcs (file)
                            (when (fboundp 'init)
                              (fset '--temp-init 'init)
                              (fmakunbound 'init))
                            (--eval-file file)
                            (when (fboundp 'init)
                              (progn
                                (init)
                                (fmakunbound 'init)))
                            ;; restore `init' function
                            (when (fboundp '--temp-init)
                              (fset 'init '--temp-init)
                              (fmakunbound '--temp-init))))
      (let* ((module-path (<path>join vikara-task-directory
                                          task
                                          "module"))
             (funcs-path (<path>join vikara-task-directory
                                         task
                                         "funcs.el"))
             (funcs-path-compiled (<path>join vikara-task-directory
                                                  task
                                                  "funcs.elc")))
        (cond
         ((file-exists-p funcs-path)
          (--load-funcs funcs-path))
         ((file-exists-p funcs-path-compiled)
          (--load-funcs funcs-path-compiled)))

        (let ((--temporary-tasks ())
              (--module-info     nil)
              (--temp))
          (dolist (dir (directory-files (<path>join vikara-task-directory
                                                        task)
                                        t))
            (when (and (file-directory-p dir)
                       (not (string-match "\/\\.$" dir))
                       (not (string-match "\/\\.\\.$" dir)))
              (add-to-list '--temporary-tasks
                           (<path>join task
                                           (file-name-nondirectory (directory-file-name dir))))))

          ;; todo: describe code below
          (when (file-exists-p module-path)
            (setq --module-info
                  (split-string (<file>read-to-string module-path)))
            (cl-loop for --task in --module-info
                     do
                     (setq --temp (<path>join task
                                                  --task))
                     (when (cl-member --temp --temporary-tasks
                                      :test 'equal)
                       ;; todo: somehow avoid copying of `--temporary-tasks'
                       (setq --temporary-tasks
                             (cons --temp (delete --temp --temporary-tasks))))))

          (setq vikara-tasks (nconc --temporary-tasks vikara-tasks)))))))

(defun <task>execute-all ()
  "Execute all task defined by `vikara-tasks'."
  (while (> (length vikara-tasks) 0)
    (<task>execute (pop vikara-tasks))))

(provide 'core-task)
;;; core-task.el ends here
