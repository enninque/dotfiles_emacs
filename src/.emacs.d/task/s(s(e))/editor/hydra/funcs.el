(defmacro <hydra>define (name &rest args)
  "Add task that defines hydra."
  (declare (indent 1))

  (let ((hydra-name (intern (format "hydra-%s"
                                    (symbol-name name)))))
    `(defhydra ,hydra-name ()
       ,@args)))

(造init
  "Configure `hydra'."
  (<eg>add-github (hydra "shinkiley/hydra"))

  (<eg>add-by-name 'hydra
    ("require")
    (~require 'hydra)

    ("settings")
    ()))
