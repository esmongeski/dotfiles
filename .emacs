(let ((repo-dir (file-name-directory (or load-file-name buffer-file-name))))
  (org-babel-load-file (expand-file-name "dotEmacs.org" repo-dir)))
