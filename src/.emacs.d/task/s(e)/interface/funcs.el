;; Vars
(~defv vikara-interface-font-default "DejaVu Sans Mono"
       "This variable contains font name that will be used by default.")

(~defv vikara-interface-font-power 12
       "This variable contains the power of the fonts.")

(造init
  "Configure interface."
  (<eg>add-by-parents ("base interface")
    'hide-gui-parts
    (progn
      (tool-bar-mode -1)

      (menu-bar-mode (if (<system>mac-p) 1 -1))

      (scroll-bar-mode -1)
      (tooltip-mode -1))

    'set-variables
    (progn
      (setq-default bidi-display-reordering        nil
                    cursor-in-non-selected-windows nil)

      (setq blink-matching-paren           nil
            show-help-function             nil
            indicate-empty-lines           nil
            highlight-nonselected-windows  nil
            indicate-buffer-boundaries     nil

            resize-mini-windows            'grow-only
            max-mini-window-height         0.3
            mode-line-default-help-echo    nil

            use-dialog-box                 nil
            visible-cursor                 nil
            x-stretch-cursor               nil
            ring-bell-function             #'ignore
            visible-bell                   nil)

      (blink-cursor-mode -1))

    'set-font
    (progn
      (set-face-attribute 'default nil
                          :font (concat vikara-interface-font-default
                                        " "
                                        (number-to-string vikara-interface-font-power)))
      (set-frame-font (concat vikara-interface-font-default
                              " "
                              (number-to-string vikara-interface-font-power))
                      nil t))))
