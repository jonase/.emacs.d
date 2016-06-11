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
(global-hl-line-mode 1)

(when (eq system-type 'darwin)
  (setq default-input-method "MacOSX"
	mac-option-modifier nil
	mac-command-modifier 'meta
	x-select-enable-clipboard t))

(dolist (package '(clojure-mode
		   aggressive-indent
		   cider
		   company
		   paredit
		   utop
		   dockerfile-mode
		   zenburn-theme))
  (unless (package-installed-p package)
    (package-install package)))


(load-theme 'zenburn t)

(setq ido-everywhere t
      ido-enable-flex-matching t)

(ido-mode 1)

;; Clojure
(add-hook 'clojure-mode-hook
	  (lambda ()
	    (paredit-mode)
	    (aggressive-indent-mode)
	    (define-clojure-indent
	      (context '(:defn (1)))
	      (GET '(:defn (1)))
	      (POST '(:defn (1)))
	      (PUT '(:defn (1)))
	      (DELETE '(:defn (1))))))

(add-hook 'cider-mode-hook
	  (lambda ()
	    (company-mode)
	    (eldoc-mode)))

(add-hook 'cider-repl-mode-hook #'paredit-mode)

(add-hook 'before-save-hook
	  (lambda ()
	    (delete-trailing-whitespace)
	    (when (eq 'clojure-mode major-mode)
	      (clojure-sort-ns))))

(setq cider-repl-display-help-banner nil
      cider-repl-pop-to-buffer-on-connect nil
      cider-repl-use-pretty-printing t
      cider-prompt-for-symbol nil
      cider-prompt-save-file-on-load 'always-save)

;; Emacs lisp
(add-hook 'emacs-lisp-mode-hook
	  (lambda ()
	    (paredit-mode)
	    (company-mode)
	    (eldoc-mode)))

;; Ocaml
;; Note: Assumes that tuareg and merlin is installed via opam:
;; $ opam install tuareg
;; $ opam install merlin
(setq opam-share
      (substring (shell-command-to-string "opam config var share 2> /dev/null")
		 0 -1))

(load (concat opam-share "/emacs/site-lisp/tuareg-site-file"))

(add-to-list 'load-path (concat opam-share "/emacs/site-lisp"))

(require 'merlin)

;; Use the opam installed utop
(setq utop-command "opam config exec -- utop -emacs")

(autoload 'utop-minor-mode "utop" "Minor mode for utop" t)

(add-hook 'tuareg-mode-hook
	  (lambda ()
	    (merlin-mode)
	    (utop-minor-mode)))

(add-hook 'merlin-mode-hook 'company-mode)
