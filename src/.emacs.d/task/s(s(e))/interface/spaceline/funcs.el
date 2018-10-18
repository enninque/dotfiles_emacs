(defmacro <spaceline>compile (name left right)
  "Compile spaceline modeline."
  `(spaceline-compile ',name
     ',left
     ',right))

(defmacro <spaceline>compile-default-with-extras (name &optional extra-left extra-right)
  "Compile default spaceline modeline with extra segments."
  (declare (indent 1))
  `(<spaceline>compile ,name
       (buffer-id
        (buffer-encoding-abbrev
         point-position
         line-column)
        buffer-modified
        buffer-position
        evil-state
        anzu
        ,@extra-left)

     (org-pomodoro
      version-control
      major-mode
      ,@extra-right)))

(defun <spaceline>compile-default ()
  "Compile default spaceline modeline."
  (<spaceline>compile-default-with-extras main))

(造init
  "Configure `spaceline'."
  (<eg>add-github (powerline "shinkiley/powerline")
                  (spaceline "shinkiley/spaceline"))

  (<eg>add-by-name 'spaceline
    ("require")
    (~require 'spaceline
              'spaceline-segments)

    ("settings")
    (progn
      (setq spaceline-face-func
            (lambda (face active)
              (if active
                  (cond
                   ((eq face 'face1)
                    'powerline-active1)
                   ((eq face 'face2)
                    'powerline-active2)
                   ((eq face 'line)
                    'mode-line)
                   ((eq face 'highlight)
                    'powerline-active2))
                (cond
                 ((eq face 'face1)
                  'powerline-inactive1)
                 ((eq face 'face2)
                  'powerline-inactive2)
                 ((eq face 'line)
                  'mode-line)
                 ((eq face 'highlight)
                  'powerline-inactive2)))))

      (<spaceline>compile-default)

      (setq-default mode-line-format
                    '("%e" (:eval (spaceline-ml-main)))))))
