;; http://d.hatena.ne.jp/tm_tn/20110605/1307238416
(use-package hlinum
  :config
  (hlinum-activate))

;; powerline
(use-package powerline
  :config
  (powerline-default-theme))

(use-package stripe-buffer
  :config
  (set-face-background 'stripe-highlight "gray9")
  :bind
  (("M-s M-s" . stripe-buffer-mode)))

(use-package volatile-highlights
  :config
  (volatile-highlights-mode t))
