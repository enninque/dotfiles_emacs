;;; package --- Summary
;;; Commentary:
;;; Code:

(require '--execution-node)

(defconst --execution-graph-identifier 'execution-graph)

;; Private
(defun --eg/find-node-by-name (node-list name)
  ""
  (let ((--node-list node-list)
        (--node      nil))
    (while (and (not --node)
                --node-list)
      (when (eq (en/name (car --node-list))
                name)
        (setq --node (car --node-list)))
      (setq --node-list (cdr --node-list)))
    --node))

(defun --eg/find-child-by-path (node path-list)
  (if path-list
      (let ((--name-list (mapcar #'intern
                                 path-list))
            (--node))
        (setq --node (--eg/find-node-by-name (en/children node)
                                             (car --name-list)))
        (setq --name-list (cdr --name-list))

        (while (and --node
                    --name-list)
          (setq --node (--eg/find-node-by-name (en/children --node)
                                               (car --name-list)))
          (setq --name-list (cdr --name-list)))
        --node)
    node))

(defun --eg/create-empty-children-by-path (node path-parts)
  ""
  (unless (en/p node)
    (error "--eg/create-empty-children-by-path: NODE is not an EN"))

  (unless (eq (length path-parts)
              0)
    (let ((--path-names (mapcar 'intern path-parts))
          (--node)
          (--temp))
      (setq --node (--eg/find-node-by-name (en/children node)
                                           (car --path-names)))
      (unless --node
        (setq --node (en/create :name (car --path-names)))
        (en/link node --node))
      (setq --path-names (cdr --path-names))
      (while --path-names
        (setq --temp --node)
        (setq --node (--eg/find-node-by-name (en/children --node)
                                             (car --path-names)))
        (unless --node
          (setq --node (en/create :name (car --path-names)))
          (en/link --temp --node))
        (setq --path-names (cdr --path-names))))))

(defun --eg/path-string-p (path)
  ""
  (and (stringp path)
       (not (equal path
                   ""))))

;; Public
(defun eg/create ()
  ""
  (list --execution-graph-identifier
        ()))

(defun eg/p (graph)
  ""
  (and graph
       (listp graph)
       (eq (car graph)
           --execution-graph-identifier)))

(defun eg/roots (graph)
  ""
  (unless (eg/p graph)
    (error "eg/get: GRAPH is not an execution graph: %s" graph))

  (nth 1 graph))

(defun eg/create-path (graph path)
  ""
  (unless (eg/p graph)
    (error "eg/create-path: GRAPH is not an execution graph: %s" graph))

  (unless (--eg/path-string-p path)
    (error "eg/get: PATH is not a correct path string: %s" path))

  (let* ((path-parts       (split-string path))
         (--root-node-name (car path-parts))
         (--path-parts     (cdr path-parts))
         (--root-node      (eg/get graph --root-node-name)))
    (unless --root-node
      (setq --root-node (en/create :name (intern --root-node-name)))
      (push --root-node (nth 1 graph)))

    (--eg/create-empty-children-by-path --root-node --path-parts)))

(defun eg/get (graph path)
  ""
  (unless (eg/p graph)
    (error "eg/get: GRAPH is not an execution graph: %s" graph))

  (unless (--eg/path-string-p path)
    (error "eg/get: PATH is not a correct path string: %s" path))

  (let* ((--path-list (split-string path))
         (--root-name (intern (car --path-list)))
         (--node))
    (setq --path-list (cdr --path-list))

    ;; find root
    (setq --node (--eg/find-node-by-name (eg/roots graph) --root-name))

    ;; find child node by path
    (when --node
      (setq --node (--eg/find-child-by-path --node --path-list)))

    --node))

(cl-defun eg/add (graph &key
                        ((:parents parent-paths) nil parents-p)
                        (name                    nil name-p)
                        (func                    nil func-p)
                        (node                    nil node-p))
  ""
  (unless (eg/p graph)
    (error "eg/add: GRAPH is not a correct execution graph"))

  (when (and (or name-p
                 func-p)
             node-p)
    (error "eg/add: (NAME, FUNC) and NODE provided together"))

  (let ((--node (or node
                    (en/create :name (or name
                                         '__unnamed__)
                               :func func)))
        (--parent-paths (or parent-paths
                            '("")))
        (--parent-node))
    (dolist (--parent-path --parent-paths)
      (if (string= --parent-path
                   "")
          ;; add to the roots
          (unless (cl-member --node (eg/roots graph))
            (push --node (nth 1 graph)))
        (let ((--path-parts (split-string --parent-path)))
          ;; add to the children of a certain root
          ;; find this root node
          (setq --parent-node
                (--eg/find-node-by-name (eg/roots graph)
                                        (intern (car --path-parts))))
          ;; If no such parent node, create new root
          (unless --parent-node
            (setq --parent-node
                  (en/create :name (intern (car --path-parts))))
            (push --parent-node (nth 1 graph)))

          (when --parent-node
            (--eg/create-empty-children-by-path --parent-node
                                                (cdr --path-parts))
            (setq --parent-node
                  (--eg/find-child-by-path --parent-node
                                           (cdr --path-parts)))
            ;; If child already exists just replace its func
            (let ((--possible-child (en/child --parent-node
                                              :name (en/name --node))))
              (if (not --possible-child)
                  (en/link --parent-node --node)
                (en/func --possible-child (en/func --node))
                (setq --node --possible-child)))))))

    (when (en/nodes-are-executed-p (en/parents --node))
      (en/execute --node))))

(defun eg/execute (graph)
  ""
  (unless (eg/p graph)
    (error "eg/execute: GRAPH is not an execution graph"))

  (mapc #'en/execute (reverse (eg/roots graph))))

(defun eg/log (graph)
  "Print execution graph."
  (mapcar #'en/log (reverse (eg/roots graph)))
  (switch-to-buffer "*Messages*"))

(provide '--execution-graph)
;;; --execution-graph.el ends here
