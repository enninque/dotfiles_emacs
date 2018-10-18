(defun <image>{scroll}left (&optional count)
  "Scroll right."
  (interactive "p")
  (scroll-right 1))

(defun <image>{scroll}down (&optional count)
  "Scroll right."
  (interactive "p")
  (scroll-up 1))

(defun <image>{scroll}up (&optional count)
  "Scroll right."
  (interactive "p")
  (scroll-down 1))

(defun <image>{scroll}right (&optional count)
  "Scroll right."
  (interactive "p")
  (scroll-left 1))

(造init
  "Configure `image-mode'."
  (<eg>add-by-name 'image
    ("require")
    (~require 'image-mode)

    ("settings")
    (progn
      ;; `load-path'
      (<filetype>register 'image-mode
                          "\\.bmp\\'"
                          "\\.jpg\\'"
                          "\\.jpeg\\'"
                          "\\.png\\'")

      (setq image-animate-loop t))

    ("keymap")
    (progn
      (<keymap>{save}{create} image-mode-map
        ("q"     #'<buffer>{kill}current)

        ("n"     #'<image>{scroll}left)
        ("e"     #'<image>{scroll}down)
        ("i"     #'<image>{scroll}up)
        ("o"     #'<image>{scroll}right)

        ("A-E"   #'image-next-file)
        ("A-I"   #'image-previous-file)))))
