(造init
  "Pre configuration."
  (<eg>add-by-name 'load-local-pre-config
    ("-w")
    (let* ((--home-dir (lambda () (getenv (if (eq system-type
                                                  'gnu/linux)
                                              "HOME"
                                            "HOMEPATH"))))
           (--local-file-path (concat (file-name-as-directory (funcall --home-dir))
                                      ".vikara.config.el")))
      (when (file-exists-p --local-file-path)
        (load-file --local-file-path)))))
