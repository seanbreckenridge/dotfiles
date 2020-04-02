;; custom global bindings
(map! :leader
      ;; list my config files and let me fuzzy match to edit one
      ;; this rebinds "open project editorconfig", but I don't use that
      (:prefix "f"
        :desc "Edit global config files" "c" #'seanbr/counsel-edit-config)
      ;; open URL, defaults to URL under cursor
      (:prefix "o"
        :desc "Open URL" "l" #'browse-url)
      )


;;;; terminal
;; set default TERM to xterm to allow colors/scrolling/paging
(map! :after shell
      :leader
      (:prefix "o"
        :desc "open shell here" "t"
        (lambda! (+shell/here "export TERM=xterm"))
        :desc "open external terminal here" "T"
        (lambda! (call-process (getenv "TERMINAL") nil 0 nil ">/dev/null 2&1 & disown"))
        ))

;;;; ranger
;; bind . to toggle hidden files
(map! :map ranger-mode-map
      :m "." #'ranger-toggle-dotfiles)

;;;; lang confguration

;;;; latex
;; bind latex preview mode to spc m p
(map! :after latex
      :map LaTeX-mode-map
      :localleader
      :desc "Display LaTeX preivew pane" "p" #'latex-preview-pane-mode)

;;;; markdown
;; open pdf that corresponds to current buffer in okular
(map! :after markdown-mode
      :map (markdown-mode-map gfm-mode-map)
      :localleader
      :desc "Open compiled markdown in okular" "p" #'seanbr/markdown-open-pdf)

;; run compile on markdown files after saving
(add-hook! '(markdown-mode-hook gfm-mode-hook)
  (add-hook 'after-save-hook #'seanbr/compile-markdown nil 'local))
