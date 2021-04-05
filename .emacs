;; BEGIN config
;; END config


;; BEGIN Packagey stuff
(package-initialize)
(require 'package)
(require 'use-package)

(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

(require 'linum)
(require 'linum-relative)
(linum-relative-global-mode)
;; TODO I want both relative and nonrelative 
(global-linum-mode)

(require 'powerline-evil)
(require 'powerline)
(powerline-default-theme)

(use-package evil
	     :ensure t)
(evil-mode 1)

(use-package org
	     :ensure t)
;; END packagey stuff


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (powerline-evil linum-off linum-relative ## use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
