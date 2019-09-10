(use-package company
  :config
  (global-company-mode +1)
  ;; https://qiita.com/syohex/items/8d21d7422f14e9b53b17
  (set-face-attribute 'company-tooltip nil :foreground "black" :background "lightgrey")
  (set-face-attribute 'company-tooltip-common nil :foreground "black" :background "lightgrey")
  (set-face-attribute 'company-tooltip-common-selection nil :foreground "white" :background "steelblue")
  (set-face-attribute 'company-tooltip-selection nil :foreground "black" :background "steelblue")
  (set-face-attribute 'company-preview-common nil :background nil :foreground "lightgrey" :underline t)
  (set-face-attribute 'company-scrollbar-fg nil :background "orange")
  (set-face-attribute 'company-scrollbar-bg nil :background "gray40")
  (set-face-attribute 'company-tooltip-search nil :foreground "black" :background "steelblue")
  (set-face-attribute 'company-tooltip-search-selection nil :foreground "white" :background "gray40")
  (defun edit-category-table-for-company-dabbrev (&optional table)
    (define-category ?s "word constituents for company-dabbrev" table)
    (let ((i 0))
      (while (< i 128)
        (if (equal ?w (char-syntax i))
            (modify-category-entry i ?s table)
          (modify-category-entry i ?s table t))
        (setq i (1+ i)))))
  (edit-category-table-for-company-dabbrev)
  (setq company-dabbrev-char-regexp "\\cs")
  (push 'company-files company-backends)
  (setq company-dabbrev-downcase nil)
  :bind*
  (("C-M-i" . company-complete))
  :bind
  ;; C-n, C-pで補完候補を次/前の候補を選択
  (:map company-active-map
        ("C-n" . company-select-next)
        ("C-p" . company-select-previous)
        ("C-n" . company-select-next)
        ("C-p" . company-select-previous)
        ;; C-sで絞り込む
        ("C-s" . company-filter-candidates)
        ;; TABで候補を設定
        ("C-i" . company-complete-selection)))

(use-package company-quickhelp
  :config
  (company-quickhelp-mode +1)
  (setq company-quickhelp-delay nil)
  :bind
  (:map company-active-map
        ("C-c h" . company-quickhelp-manual-begin)))

(use-package company-lsp
  :requires company
  :config
  (add-to-list 'company-backends '(company-lsp :with company-dabbrev))
  (add-to-list 'company-backends '(company-capf :with company-dabbrev))
  (setq company-transformers nil
        company-lsp-async t
        company-lsp-cache-candidates nil))
