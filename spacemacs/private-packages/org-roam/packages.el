(defconst org-roam-packages
  '(org-roam))

(defun org-roam-ext-weekly-notes ()
  (interactive)
  (org-roam-dailies-tomorrow
    (- 1 (calendar-day-of-week (calendar-current-date)))))

(defun org-roam/init-org-roam ()
  (use-package org-roam
    :hook
    (after-init . org-roam-mode)
    :custom
    (org-roam-directory "~/Dropbox/work-share/")
    :init
    (progn
      (spacemacs/declare-prefix "ar" "org-roam")
      (spacemacs/set-leader-keys
        "arl" 'org-roam
        "art" 'org-roam-dailies-today
        "arf" 'org-roam-find-file
        "arg" 'org-roam-graph
        "arw" 'org-roam-ext-weekly-notes)

      (spacemacs/declare-prefix-for-mode 'org-mode "mr" "org-roam")
      (spacemacs/set-leader-keys-for-major-mode 'org-mode
        "rl" 'org-roam
        "rt" 'org-roam-dailies-today
        "rb" 'org-roam-switch-to-buffer
        "rf" 'org-roam-find-file
        "ri" 'org-roam-insert
        "rg" 'org-roam-graph
        "rw" 'org-roam-ext-weekly-notes))))
