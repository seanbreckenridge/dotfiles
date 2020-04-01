;;; ~/.doom.d/functions.el -*- lexical-binding: t; -*-

;; Refrence: https://oremacs.com/swiper/#example---counsel-locate

(defun my/counsel-list-config (str)
  "Use fzf to fuzzy match 'str' against config files"
  (progn
    (counsel--async-command
     (format "list-config | fzf -f \"%s\" || printf \"\"" str))
    nil ;; value to display while command is running (display previous results)
    ))

;;;###autoload
(defun my/counsel-edit-config (&optional initial-input)
  "Fuzzy match against the \"list-config\" shell command.
INITIAL-INPUT can be given as the initial minibuffer input."
  (interactive)
  (ivy-read "Edit Config File: " #'my/counsel-list-config
            :initial-input initial-input
            :dynamic-collection t
            :history 'counsel-edit-config-history
            :action (lambda (file)
                      (with-ivy-window
                        (when file
                          (find-file file))))
            :unwind #'counsel-delete-process
            :caller 'counsel-edit-config))


(defun my/current-buffer-file-name ()
  "Gets the name of the file the current buffer is based on."
  (interactive)
  (buffer-file-name (window-buffer (minibuffer-selected-window))))

(defun my/replace-file-extension (filename new-extension)
  "Replaces the extension of filename with new-extension"
  (concat (file-name-sans-extension filename) new-extension)
  )

;;;; markdown


;;;###autoload
(defun my/markdown-open-pdf ()
  "Requires okular to be installed, opens the current buffer
   (with the extension replaced with .pdf)
   Save any markdown file (while in markdown-mode) to generate the assosiated pdf
   "
  (interactive)
  (start-process "okular-output" "okular-buffer"
                 "okular" (my/replace-file-extension (my/current-buffer-file-name) ".pdf"))
  )
