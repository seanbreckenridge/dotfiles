;;; ~/.doom.d/functions.el -*- lexical-binding: t; -*-

;; Refrence: https://oremacs.com/swiper/#example---counsel-locate

(defun counsel-list-config (str)
  "Use fzf to fuzzy match 'str' against config files"
   (progn
     (counsel--async-command
       (format "list-config | fzf -f \"%s\"" str))
     nil ;; value to display while command is running (display previous results)
     ))

;;;###autoload
(defun counsel-edit-config (&optional initial-input)
  "Fuzzy match against the \"list-config\" shell command.
INITIAL-INPUT can be given as the initial minibuffer input."
  (interactive)
  (ivy-read "Edit Config File: " #'counsel-list-config
            :initial-input initial-input
            :dynamic-collection t
            :history 'counsel-edit-config-history
            :action (lambda (file)
                      (with-ivy-window
                        (when file
                          (find-file file))))
            :unwind #'counsel-delete-process
            :caller 'counsel-edit-config))
