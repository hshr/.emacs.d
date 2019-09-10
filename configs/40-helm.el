(use-package helm
  :bind
  (("C-;" . helm-for-files))
  :config
  ;; 自動補完を無効
  (custom-set-variables '(helm-ff-auto-update-initial-value nil))
  (helm-migemo-mode +1))

(use-package helm-ag
  :init
  (setq helm-ag-base-command "ag --nocolor --nogroup")
  :bind
  (("C-M-g" . helm-ag)))

(use-package helm-swoop
  :bind
  (("C-M-s" . helm-swoop)
   :map helm-swoop-map
   ;;; isearchからの連携を考えるとC-r/C-sにも割り当て推奨
   ("C-r" . 'helm-previous-line)
   ("C-s" . 'helm-next-line)))

(use-package helm-flycheck)
