;; HEY HEY HEY YOU SHOULD'T COMMIT CHANGES TO THIS
;; PUT THEM IN dotEmacs.org instead!

;; set to the current directory to find all the other stuff
(setq user-init-file (or load-file-name (buffer-file-name)))
(setq user-emacs-directory (file-name-directory user-init-file))
(load (concat user-emacs-directory "./.emacs"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(company emacsql-sqlite evil-collection evil-easymotion evil-org
	     evil-surround evil-terminal-cursor-changer fish-mode
	     forge go-mode goto-chg graphql-mode helm-org-rifle
	     kubernetes-evil ob-mermaid org org-bullets org-roam-ui
	     org-super-agenda powerline-evil protobuf-mode smartparens
	     sqlite3 tree-sitter-langs undo-tree use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
