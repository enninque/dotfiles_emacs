(cl-defun <company>{activate} (&key (backends-add nil backends-add-p)
                                    (backends-set nil backends-set-p))
  ""
  (when (and backends-add-p
             backends-set-p)
    (error "`backends-add' and `backends-set' was provided simultaneously"))

  (when backends-add-p
    (set (make-local-variable 'company-backends)
         (cons backends-add company-backends)))

  (when backends-set-p
    (set (make-local-variable 'company-backends)
         backends-set))

  (company-mode            +1)
  (company-statistics-mode +1)
  (company-quickhelp-mode  +1))

(造init
  "Configure `company'."
  (<eg>add-github (company-mode       "shinkiley/company-mode")
                  (company-statistics "shinkiley/company-statistics")
                  (company-quickhelp  "shinkiley/company-quickhelp"))

  (<eg>add-by-name 'company
    ("require")
    (~require 'company
              'company-quickhelp
              'company-statistics)

    ("settings")
    (progn
      ;; company
      (setq company-minimum-prefix-length 1)
      (setq company-mode/enable-yas t)
      (setq company-idle-delay 0.1)
      (setq company-backends
            '((company-files
               company-keywords
               company-capf
               :separate
               company-yasnippet)
              (company-abbrev company-dabbrev)))
      (setq company-show-numbers t)

      ;;company-quickhelp
      (setq company-quickhelp-delay 0.1)

      ;; company-statistics
      (setq company-statistics-file (f-join vikara-tmp-directory
                                            "company-statistics-cache.el")))

    ("keymap")
    (progn
      (<keymap>{create} company-active-map
        ("A-n" #'company-abort)
        ("A-e" #'company-select-next)
        ("A-o" #'company-complete-selection)
        ("A-i" #'company-select-previous))

      (<keymap>bind company-active-map
                    ;; todo: change it to mapcar style
                    ("A-1"
                     "A-2"
                     "A-3"
                     "A-4"
                     "A-5"
                     "A-6"
                     "A-7"
                     "A-8"
                     "A-9"
                     "A-0")
                    #'company-complete-number))))
