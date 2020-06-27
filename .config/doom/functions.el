;;; ~/.doom.d/functions.el -*- lexical-binding: t; -*-

;; Refrence: https://oremacs.com/swiper/#example---counsel-locate

;;;; edit config files

;;;###autoload
(defun seanbr/counsel-list-config (str)
  "Use fzf to fuzzy match 'str' against config files"
  (progn
    (counsel--async-command
     (format "list-config | fzf -f \"%s\" || printf \"\"" str))
    nil ;; value to display while command is running (display previous results)
    ))

;;;###autoload
(defun seanbr/counsel-edit-config (&optional initial-input)
  "Fuzzy match against the \"list-config\" shell command.
INITIAL-INPUT can be given as the initial minibuffer input."
  (interactive)
  (ivy-read "Edit Config File: " #'seanbr/counsel-list-config
            :initial-input initial-input
            :dynamic-collection t
            :history 'counsel-edit-config-history
            :action (lambda (file)
                      (with-ivy-window
                        (when file
                          (find-file file))))
            :unwind #'counsel-delete-process
            :caller 'counsel-edit-config))


;;;; file utilities

(defun seanbr/current-buffer-file-path ()
  "Gets the absolute path of the current buffers assosiated file"
  (buffer-file-name (window-buffer (minibuffer-selected-window))))

(defun seanbr/replace-file-extension (filename new-extension)
  "Replaces the extension of filename with new-extension"
  (concat (file-name-sans-extension filename) "." new-extension)
  )

(defun seanbr/joindirs (root &rest paths)
  "Joins a variable amount of directories together
   Returns a single path, which ends with a '/'"
  (if (not paths)
      (file-name-as-directory root)
    (apply #'seanbr/joindirs
           (concat (file-name-as-directory root) (car paths))
           (cdr paths)))
  )

;;;; markdown

;; uses my compile script to compile an .md to a .pdf
;; https://github.com/seanbreckenridge/dotfiles/blob/e731c35eebd3041fa984d6599eaa9a454d5901aa/.local/scripts/bin/compile
;;;###autoload
(defun seanbr/compile-markdown ()
  (interactive)
  (start-process "compile-markdown" "compile-markdown-buffer"
                 "compile" (seanbr/current-buffer-file-path))
  )

;;;###autoload
(defun seanbr/markdown-open-pdf ()
  "Requires mupdf to be installed, opens the current buffer
   (with the extension replaced with .pdf)
   Save any markdown file (while in markdown-mode) to generate the assosiated pdf
   'compile' will refresh mupdf if its running
   "
  (interactive)
  (start-process "mupdf-output" "mupdf-buffer"
                 "mupdf" (seanbr/replace-file-extension (seanbr/current-buffer-file-path) "pdf"))
  )

;;;; npm
(defun seanbr/npm-bin-path ()
  "Get the global NPM bin directory
Tries to use NPM_CONFIG_PREFIX, else
defaults to ~/.npm"
  (seanbr/joindirs
   (or (getenv "NPM_CONFIG_PREFIX")
       (seanbr/joindirs (getenv "HOME") ".npm"))
   "bin"
   )
  )

