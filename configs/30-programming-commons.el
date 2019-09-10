(use-package lsp-mode
  :defer t
  :config
  (setq lsp-enable-snippet nil)
  :commands lsp)

(use-package lsp-ui
  :after lsp-mode
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  :bind
  (:map lsp-ui-mode-map
        ([remap xref-find-definitions] . #'lsp-ui-peek-find-definitions)
        ([remap xref-find-references] . #'lsp-ui-peek-find-references)))

(use-package flycheck
  :after helm
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode)
  :bind
  (("C-M-c" . helm-flycheck)))
