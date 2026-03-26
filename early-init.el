(setq package-enable-at-startup nil)

(require 'package)
(setq load-prefer-newer t)
(setq package-install-upgrade-built-in t)
(setq package-user-dir (expand-file-name "~/.emacs.d/elpa"))
(setq package-archives
      '(("gnu" . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa" . "https://melpa.org/packages/")))
(setq package-archive-priorities
      '(("gnu" . 30)
        ("nongnu" . 20)
        ("melpa" . 10)))
(setq package-pinned-packages
      '((org . "gnu")))
(package-initialize t)

(defconst es/early-minimum-org-version "9.7.19")

(defun es/early-package-version-string (desc)
  "Return DESC version as a string."
  (package-version-join (package-desc-version desc)))

(defun es/early-find-installed-package-desc (name)
  "Return the newest installed package descriptor for NAME."
  (car (sort (mapcar #'cadr (seq-filter (lambda (pkg) (eq (car pkg) name))
                                        package-alist))
             (lambda (a b)
               (version-list-< (package-desc-version b)
                               (package-desc-version a))))))

(defun es/early-activate-package-desc (desc)
  "Prefer DESC on `load-path' for the current Emacs session."
  (when desc
    (let ((dir (package-desc-dir desc)))
      (setq load-path (cons dir (delete dir load-path))))))

(let* ((org-desc (es/early-find-installed-package-desc 'org))
       (org-version (and org-desc (es/early-package-version-string org-desc))))
  (when (or (null org-desc)
            (version< org-version es/early-minimum-org-version))
    (unless package-archive-contents
      (package-refresh-contents))
    (when (and org-desc
               (version< org-version es/early-minimum-org-version))
      (package-delete org-desc t))
    (let ((package-load-list '(all)))
      (package-install 'org))
    (setq org-desc (es/early-find-installed-package-desc 'org)))
  (es/early-activate-package-desc org-desc))
