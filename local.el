(setq x-super-keysym 'meta)

(add-to-list 'default-frame-alist '(font . "VL Gothic-10"))


;; Mozc settings
(use-package mozc
  :config
  (setq default-input-method "japanese-mozc"))

(use-package mozc-popup
  :config
  (setq mozc-candidate-style 'popup))
