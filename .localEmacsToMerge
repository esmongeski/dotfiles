  (require 'package)
  (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
  (package-initialize)
  (add-to-list 'load-path "/path/to/org-evil/directory")
  (require 'org-evil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("~/org/todo.org")))
 '(package-selected-packages
   (quote
    (org-evil monitor dash powerline-evil ## org-link-minor-mode org-mobile-sync evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
 ;; Package-Requires: ((dash "2.13.0"))
 (require 'evil)
 (evil-mode 1)
 ;; (add-to-list 'load-path "~/.emacs.d/vendor/emacs-powerline")
 ;; (require 'powerline)
 ;; (require 'cl)

(setq org-todo-keywords
     '((sequence "TODO" "WAITING" "IN-PROGRESS" "|" "DONE" "|" "SOMEDAY")))

(load-theme 'manoj-dark)
