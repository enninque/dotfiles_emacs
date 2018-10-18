(造activator ggtags)

(造init
  (<eg>add-github (ggtags "shinkiley/ggtags"))

  (<eg>add-by-name 'ggtags
    ("require")
    (progn
      (<keymap>{create} ggtags-mode-map)
      (<keymap>{create} ggtags-global-mode-map)
      (<keymap>{create} ggtags-mode-prefix-map)
      (<keymap>{create} ggtags-navigation-map)
      (<keymap>{create} ggtags-navigation-mode-map)
      (<keymap>{create} ggtags-mode-line-project-keymap)
      (<keymap>{create} ggtags-highlight-tag-map)
      (<keymap>{create} ggtags-view-search-history-mode-map)
      (<keymap>{create} ggtags-view-tag-history-mode-map)

      (require 'ggtags))))
