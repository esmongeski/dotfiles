;; HEY HEY HEY YOU SHOULD'T COMMIT CHANGES TO THIS
;; PUT THEM IN dotEmacs.org instead!

(require 'package)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)

(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

;; set to the current directory to find all the other stuff
(setq user-init-file (or load-file-name (buffer-file-name)))
(setq user-emacs-directory (file-name-directory user-init-file))
(load (concat user-emacs-directory "./.emacs"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files
   '("~/Dropbox/org/personalProjects.org" "~/Dropbox/org/funThings.org" "~/Dropbox/org/homeProjects.org" "~/Dropbox/org/workStuff.org"))
 '(org-priority-lowest 74)
 '(package-selected-packages
   '(org-bullets helm-org org-evil monitor dash powerline-evil ## org-link-minor-mode org-mobile-sync evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
