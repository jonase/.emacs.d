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
(tool-bar-mode -1)
(scroll-bar-mode -1)
(fringe-mode 0)

(setq default-input-method "MacOSX"
      mac-option-modifier nil
      mac-command-modifier 'meta
      x-select-enable-clipboard t)

(dolist (package '(clojure-mode
		   cider
		   company
		   paredit
		   zenburn-theme))
  (unless (package-installed-p package)
    (package-install package)))

(add-hook 'clojure-mode-hook
	  (lambda ()
	    (paredit-mode)
	    (company-mode)))

(add-hook 'cider-mode-hook
	  (lambda ()
	    (company-mode)
	    (eldoc-mode)))

(add-hook 'before-save-hook #'delete-trailing-whitespace)

(setq cider-repl-pop-to-buffer-on-connect nil
      cider-prompt-for-symbol nil
      cider-prompt-save-file-on-load 'always-save)

(load-theme 'zenburn t)

(setq ido-everywhere t
      ido-enable-flex-matching t)

(ido-mode 1)
