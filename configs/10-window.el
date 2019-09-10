;; popup-select-window
(setq load-path (append
                 '("~/.emacs.d/packages/popup-select-window")
                 load-path))
(require 'popup-select-window)
(global-set-key "\C-xo" 'popup-select-window)
;; /popup-select-window

(use-package shackle
  :init
  (setq shackle-rules
        '(;; *compilation*は下部に2割の大きさで表示
          (compilation-mode :align below :ratio 0.2)
          ;; ヘルプバッファは右側に表示
          ;; ("*Help*" :align right)
          ;; 補完バッファは下部に3割の大きさで表示
          ("*Completions*" :align below :ratio 0.3)
          ("*Google Translate*" :align below :ratio 0.3)
          ("*Warning*" :ignore t)
          ("*Warnings*" :ignore t)
          ("\\`\\*Helm.*?\\*\\'" :regexp t :align t :size 0.4)
          ;; 上部に表示
          ;; ("foo" :align above)
          ;; 別フレームで表示
          ;; ("bar" :frame t)
          ;; 同じウィンドウで表示
          ;; ("baz" :same t)
          ;; ポップアップで表示
          ;; ("hoge" :popup t)
          ;; 選択する
          ;; ("abc" :select t)
          ))
  (setq shackle-lighter "")
  (shackle-mode 1)
  (winner-mode 1)
  :bind
  (("C-z" . winner-undo))) ;;; C-zで直前のウィンドウ構成に戻す
