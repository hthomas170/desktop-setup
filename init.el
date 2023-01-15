;;; Copyright © 2023 Hugo Thomas <hugo.thomas170@protonmail.com>
(add-to-list 'load-path "~/.guix-profile/share/emacs/site-lisp")

(guix-emacs-autoload-packages)

(global-set-key "\C-x\C-i" (lambda() (interactive)(find-file user-init-file)))

(menu-bar-mode -1)

(use-package spacemacs-theme
  :defer t
  :init (load-theme 'spacemacs-dark t))

(use-package dashboard
  :config
  (dashboard-setup-startup-hook))

(use-package helm
  :config
  ())

(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(setq org-directory "~/.emacs.d/org")
(setq org-agenda-files (list "todo.org" "inbox.org"))

(setq org-capture-templates
      `(("i" "Inbox" entry (file "inbox.org")
	 ,(concat "* TODO %?\n"
		  "/Entered on/ %U"))))

(define-key global-map (kbd "C-c c") 'org-capture)

(defun org-capture-inbox ()
  (interactive)
  (call-interactively 'org-store-link)
  (org-capture nil "i"))

(define-key global-map (kbd "C-c i") 'org-capture-inbox)

(require 'org-agenda)
(org-agenda nil "n")
(add-hook 'emacs-startup-hook (lambda ()
				(when (get-buffer "*scratch*")
				  (kill-buffer "*scratch*"))))
(setq org-log-done t)
(define-key global-map [remap find-file] 'helm-find-files)

;; Set the title
(setq dashboard-banner-logo-title "Welcome to Emacs Dashboard")
;; Content is not centered by default. To center, set
(setq dashboard-center-content t)
(setq dashboard-items '((recents . 5)
			(bookmarks . 5)))

;; I use that to display org agenda by dahsboard side, maybe its a bit messy, cause
;; I didn't really split the screen anywere
(other-window 1)
(switch-to-buffer "Org Agenda")


(require 'mu4e)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;; merge emacs kill-ring and system clipboard
(require 'xclip)
(xclip-mode 1)

;; Assuming the Guix checkout is in ~/src/guix.
(with-eval-after-load 'geiser-guile
  (add-to-list 'geiser-guile-load-path "~/guix_hacking/guix"))

(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
(add-hook 'scheme-mode-hook           #'enable-paredit-mode)

(with-eval-after-load 'tempel
  ;; Ensure tempel-path is a list -- it may also be a string.
  (unless (listp 'tempel-path)
    (setq tempel-path (list tempel-path)))
  (add-to-list 'tempel-path "~/guix_hacking/guix/etc/snippets/tempel/*"))

(setq user-full-name "Hugo Thomas")
(setq user-mail-address "hugo.thomas170@protonmail.com")
(load-file "~/guix_hacking/guix/etc/copyright.el")

(setq copyright-names-regexp
      (format "%s <%s>" user-full-name user-mail-address))

;; Setup corfu popup
(corfu-terminal-mode)
(customize-set-variable 'corfu-cycle t)
(customize-set-variable 'corfu-auto t)
(customize-set-variable 'corfu-auto-delay 0.0)

(global-corfu-mode 1)
(corfu-popupinfo-mode 1)
