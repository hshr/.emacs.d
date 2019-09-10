(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.milkbox.net/packages/") t)
(setq package-user-dir "~/.emacs.d/packages")
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; install packages automatically if not already present on your
;; system to be global for all packages
(require 'use-package-ensure)
(setq use-package-always-ensure t)

(use-package init-loader
  :init
  (setq init-loader-show-log-after-init 'error-only))
(init-loader-load "~/.emacs.d/configs")
