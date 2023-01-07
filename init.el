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
;; (setq initial-buffer-choice (lambda ()
;; 			      (org-agenda nil "n")
;; 			      (get-buffer "*Org Agenda*")))
(org-agenda nil "n")
(add-hook 'emacs-startup-hook (lambda ()
				(when (get-buffer "*scratch*")
				  (kill-buffer "*scratch*"))))
(setq org-log-done t)
(define-key global-map [remap find-file] 'helm-find-files)

;;(setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))

;; Set the title
(setq dashboard-banner-logo-title "Welcome to Emacs Dashboard")
;; Content is not centered by default. To center, set
(setq dashboard-center-content t)
(setq dashboard-items '((recents . 5)
			(bookmarks . 5)))
			;;(projects . 5)
;; 			(agenda . 5)))



;; (add-to-list 'dashboard-item-generators '(custom . dashboard-insert-custom))
;; (add-to-list 'dashboard-items '(custom) t)

;; (defun dashboard-insert-custom (list-size)
;;   (dashboard-insert-section
;;    "Global todos:"
;;    '("Custom text")
;;    list-size
;;    "t"
;;    (lambda (&rest _) (jump-to-custom (car el)))
;;    (format "%s" el)))

;; I use that to display org agenda by dahsboard side, maybe its a bit messy, cause
;; I didn't really split the screen anywere
(other-window 1)
(switch-to-buffer "Org Agenda")


(require 'mu4e)
