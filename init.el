;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;;; Settings of Character Encodings
(set-language-environment "Japanese")
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(setq default-file-name-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(setq coding-system-for-write 'utf-8)


;;;
(column-number-mode t)
(show-paren-mode t)
(setq ring-bell-function 'ignore)
(setq inhibit-startup-message t)
(setq pop-up-windows nil)

;; scratch バッファのメッセージを消去
(setq initial-scratch-message "")
(fset 'yes-or-no-p 'y-or-n-p)
(icomplete-mode t)
(global-set-key "\C-x\C-b" 'bs-show)

;; クリップボードからの貼り付けやコピーを有効に設定
(setq x-select-enable-clipboard t)

;; バッファ自動再読み込み
(global-auto-revert-mode t)

;; 同名ファイルを開いたときのバッファ名識別文字列を変更
;; 入っているディレクトリ名などで識別
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; 選択した領域の削除
(delete-selection-mode t)

;; region 関連
(transient-mark-mode t)
(defun backward-kill-word-or-kill-region ()
  (interactive)
  (if (or (not transient-mark-mode) (region-active-p))
      (kill-region (region-beginning) (region-end))
    (backward-kill-word 1)))

;; region の色の設定
(set-face-background 'region "tan1")
(set-face-foreground 'region "black")
(set-face-foreground 'font-lock-string-face "red")

;; スクリプトファイルを実行可能に設定して保存
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

;;; linum-mode 行番号を左端に表示
(global-set-key "\M-s\M-l" 'linum-mode)
(setq linum-format "%4d")

;; タブ幅の設定
(setq tab-width 4)
;; tab をスペースで置き換える
(setq-default indent-tabs-mode nil)

;; バックアップファイルを一箇所に纏める
(setq make-backup-files t)
(setq backup-by-copying t)
(setq backup-directory-alist
      (cons (cons "\\.*$" (expand-file-name "~/.emacs.d/backup"))
            backup-directory-alist))

;; *scratch*を消さない
(defun my-make-scratch (&optional arg)
  (interactive)
  (progn
    ;; "*scratch*" を作成して buffer-list に放り込む
    (set-buffer (get-buffer-create "*scratch*"))
    (funcall initial-major-mode)
    (erase-buffer)
    (when (and initial-scratch-message (not inhibit-startup-message))
      (insert initial-scratch-message))
    (or arg (progn (setq arg 0)
                   (switch-to-buffer "*scratch*")))
    (cond ((= arg 0) (message "*scratch* is cleared up."))
          ((= arg 1) (message "another *scratch* is created")))))

(add-hook 'kill-buffer-query-functions
          ;; *scratch* バッファで kill-buffer したら内容を消去するだけにする
          (lambda ()
            (if (string= "*scratch*" (buffer-name))
                (progn (my-make-scratch 0) nil)
              t)))

(add-hook 'after-save-hook
          ;; *scratch* バッファの内容を保存したら *scratch* バッファを新しく作る
          (lambda ()
            (unless (member (get-buffer "*scratch*") (buffer-list))
              (my-make-scratch 1))))

(define-key global-map "\M-s\M-r"
  (lambda () (interactive) (point-to-register 'r)))
(define-key global-map "\M-s\M-j"
  (lambda () (interactive) (jump-to-register 'r)))

;; Open file or directory as root
(defun file-root-p (filename)
  "Return t if file FILENAME created by root."
  (eq 0 (nth 2 (file-attributes filename))))

(defun th-rename-tramp-buffer ()
  (when (file-remote-p (buffer-file-name))
    (rename-buffer
     (format "%s:%s"
             (file-remote-p (buffer-file-name) 'method)
             (buffer-name)))))

(add-hook 'find-file-hook
          'th-rename-tramp-buffer)

(defadvice find-file (around th-find-file activate)
  "Open FILENAME using tramp's sudo method if it's read-only."
  (if (and (file-root-p (ad-get-arg 0))
           (not (file-writable-p (ad-get-arg 0)))
           (y-or-n-p (concat "File "
                             (ad-get-arg 0)
                             " is read-only.  Open it as root? ")))
      (th-find-file-sudo (ad-get-arg 0))
    ad-do-it))

(defun th-find-file-sudo (file)
  "Opens FILE with root privileges."
  (interactive "F")
  (set-buffer (find-file (concat "/sudo::" file))))

;; ファイルを開くときに、大文字と小文字を区別しない
(setq read-file-name-completion-ignore-case t)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(cua-mode t)
;; C-cやC-vの乗っ取りを阻止
(setq cua-enable-cua-keys nil)

;; dired で .zip ファイルの解凍
(eval-after-load "dired-aux"
   '(add-to-list 'dired-compress-file-suffixes
                 '("\\.zip\\'" ".zip" "unzip")))

(setq dired-listing-switches "-alh")

(ffap-bindings)
(add-hook 'dired-load-hook (lambda ()
                             (define-key dired-mode-map "r"
                               'wdired-change-to-wdired-mode)))
(add-hook 'dired-load-hook (function (lambda () (load "dired-x"))))

(define-key global-map "\C-c\."
  '(lambda ()
     (interactive)
     (insert (format-time-string "%Y/%m/%d"))))


(when window-system
  (setq default-frame-alist
        (append
         '((foreground-color . "gray")  ; 前景色
           (background-color . "gray10"))
         default-frame-alist))
  (scroll-bar-mode 0)
  (tool-bar-mode 0)
  (menu-bar-mode 0))

;; 標準Elispの設定
(load "~/.emacs.d/configs/builtins")

;; 非標準Elispの設定
(load "~/.emacs.d/package")

;; 個別の設定があったら読み込む
(condition-case err
    (load "~/.emacs.d/local")
  (error))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-idle-delay nil)
 '(helm-ff-auto-update-initial-value nil)
 '(package-selected-packages
   (quote
    (recentf-ext google-translate mozc-popup mozc annotate smart-tabs-mode yaml-mode volatile-highlights virtualenv stripe-buffer srefactor smartparens powerline multi-term migemo markdown-mode magit jedi init-loader hlinum helm-swoop helm-c-yasnippet helm-ag git-gutter-fringe flycheck-pos-tip exec-path-from-shell cmake-mode auto-complete-clang-async)))
 '(safe-local-variable-values
   (quote
    ((conding . utf-8)
     (Coding . utf-8-dos)
     (encoding . utf-8)
     (require-final-newline . t))))
 '(vlf-application (quote dont-ask)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
