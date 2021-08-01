emacs --batch \
      --eval "(require 'org)" \
      --eval "(org-babel-do-load-languages 'org-babel-load-languages'((shell . t)))" \
      --eval "(setq org-babel-default-header-args:fish '((:tangle . \"yes\")))" \
      --eval '(org-babel-tangle-file (concat (getenv "PATH_TO_DOTFILES_REPO") "/fish/fishProfile.org"))'
