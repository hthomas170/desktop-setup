(add-to-list 'load-path "~/.guix-profile/share/emacs/site-lisp")
(guix-emacs-autoload-packages)
(org-babel-load-file (expand-file-name "config.org" "~/desktop-setup/"))
