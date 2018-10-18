;;; package --- vikara core configuration -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(require 'core-execution)
(require 'core-task)

(defun <vikara>init ()
  "Initialize `vikara'."
  (<eg>create)

  (<task>add "-w")
  (<task>add "e")
  (<task>add "s(e)")
  (<task>add "s(s(e))")

  (<task>execute-all)

  (<eg>execute))

(provide 'core-vikara)
;;; core-vikara.el ends here
