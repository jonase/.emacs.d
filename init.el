(require 'package)

(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
	("melpa-stable" . "http://stable.melpa.org/packages/")))

(package-initialize)

(setq url-http-attempt-keepalives nil)

(setq inhibit-splash-screen t
      inhibit-startup-message t
      backup-inhibited t)

(menu-bar-mode -1)
(scroll-bar-mode -1)
(fringe-mode 0)

(setq default-input-method "MacOSX"
      mac-option-modifier nil
      mac-command-modifier 'meta
      x-select-enable-clipboard t)

(unless (package-installed-p 'clojure-mode)
  (package-install 'clojure-mode))

(unless (package-installed-p 'cider)
  (package-install 'cider))

(unless (package-installed-p 'company)
  (package-install 'company))

(unless (package-installed-p 'paredit)
  (package-install 'paredit))

(add-hook 'clojure-mode-hook #'paredit-mode)
(add-hook 'clojure-mode-hook #'company-mode)
(add-hook 'cider-mode-hook #'company-mode)
(add-hook 'cider-mode-hook #'eldoc-mode)

(setq cider-repl-pop-to-buffer-on-connect nil
      cider-prompt-for-symbol nil
      cider-prompt-save-file-on-load 'always-save)

(unless (package-installed-p 'zenburn-theme)
  (package-install 'zenburn-theme))
(load-theme 'zenburn t)

(setq ido-everywhere t
      ido-enable-flex-matching t)
(ido-mode 1)
