(use-package smartparens
  :config
  (progn
    (smartparens-global-mode t)
    (show-smartparens-global-mode t)))

;; text-adjust
(setq load-path (append
                 '("~/.emacs.d/packages/text-adjust/")
                 load-path))
(require 'text-adjust)

;; ファイル保存時に全角文字と半角文字の間に自動でスペースを開ける
;; http://d.hatena.ne.jp/rubikitch/20090220/text_adjust
(defun text-adjust-space-before-save-if-needed ()
  (when (memq major-mode
              '(org-mode text-mode))
    (text-adjust-space-buffer)))
;; ファイル保存時に自動で "、", "。" を ", ", ". " に変換
(defun text-adjust-kutouten-before-save-if-needed ()
  (when (memq major-mode
              '(org-mode latex-mode))
    (text-adjust-kutouten-buffer)))
(defalias 'spacer 'text-adjust-space-buffer)
(add-hook 'before-save-hook 'text-adjust-space-before-save-if-needed)
(add-hook 'before-save-hook 'text-adjust-kutouten-before-save-if-needed)
;; /text-adjust

(use-package migemo
  :config
  (setq migemo-command "/usr/bin/cmigemo")
  (setq migemo-options '("-q" "--emacs"))
    ;; Set your installed path
  (setq migemo-dictionary "/usr/share/cmigemo/utf-8/migemo-dict")

  (setq migemo-user-dictionary nil)
  (setq migemo-regex-dictionary nil)
  (setq migemo-coding-system 'utf-8-unix))
