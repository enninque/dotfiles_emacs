(造init
  "Install and configure libraries."
  (dolist (package '((emacs-ef         "https://github.com/shinkiley/emacs-ef"      :require)
                     (dash             "https://github.com/shinkiley/dash.el"       :require)
                     (ht               "https://github.com/shinkiley/ht.el"         :require)
                     (s                "https://github.com/shinkiley/s.el"          :require)
                     (f                "https://github.com/shinkiley/f.el"          :require)
                     (htmlize          "https://github.com/shinkiley/emacs-htmlize" :require)

                     (alert            "https://github.com/shinkiley/alert")
                     (async            "https://github.com/shinkiley/emacs-async")
                     (avy              "https://github.com/shinkiley/avy")
                     (deferred         "https://github.com/shinkiley/emacs-deferred")
                     (hierarchy        "https://github.com/shinkiley/hierarchy")
                     (libmpdee         "https://github.com/shinkiley/libmpdee")
                     (page-break-lines "https://github.com/shinkiley/page-break-lines")
                     (popup            "https://github.com/shinkiley/popup-el")
                     (pos-tip          "https://github.com/shinkiley/pos-tip")
                     (request          "https://github.com/shinkiley/emacs-request")
                     (tablist          "https://github.com/shinkiley/tablist")
                     (xml+             "https://github.com/shinkiley/xml-plus")
                     (websocket        "https://github.com/shinkiley/emacs-websocket")
                     (grizzl           "https://github.com/shinkiley/grizzl")
                     (edit-indirect    "https://github.com/shinkiley/edit-indirect")
                     (pkg-info         "https://github.com/shinkiley/pkg-info.el")
                     (epl              "https://github.com/shinkiley/epl")
                     (spinner          "https://github.com/shinkiley/spinner.el")
                     (parent-mode      "https://github.com/raisatu/parent-mode")
                     (log4e            "https://github.com/raisatu/log4e")
                     (uuidgen          "https://github.com/raisatu/uuidgen-el")
                     (pcache           "https://github.com/raisatu/pcache")))
    (cl-destructuring-bind (name src &optional require) package
      (<eg>add-install :type    'git
                       :name    name
                       :src     src
                       :parents '("zero lib install"))
      (when require
        (<eg>add :name    name
                 :parents '("zero lib require")
                 :func    `(~require ',name)))))

  (<eg>add-download (hexrgb    "https://raw.githubusercontent.com/shinkiley/emacswiki.org/master/hexrgb.el")
                    (queue     "https://elpa.gnu.org/packages/queue-0.2.el")
                    (highlight "https://raw.githubusercontent.com/raisatu/emacswiki.org/master/highlight.el"))) 
