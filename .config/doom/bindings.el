;; custom global bindings
(map! :leader
      ;; list my config files and let me fuzzy match to edit one
      ;; this rebinds "open project editorconfig", but I don't use that
      :desc "Edit global config files" "fc" #'seanbr/counsel-edit-config
      ;; open URL, defaults to URL under cursor
      :desc "Open URL" "ol" #'browse-url
      ;; bind ispell to spc $
      :desc "Run ispell on current buffer" "$" #'ispell
      )


;;;; terminal
;; set default TERM to xterm to allow colors/scrolling/paging
(map! :after shell
      :leader
      (:prefix "o"
       :desc "open shell here" "t"
       (cmd! (+shell/here "export TERM=xterm"))
       :desc "open external terminal here" "T"
       (cmd! (call-process (getenv "TERMINAL") nil 0 nil))
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
      :desc "Display LaTeX preview pane" "p" #'latex-preview-pane-mode)

;;;; markdown
;; open pdf that corresponds to current buffer in okular
(map! :after markdown-mode
      :map (markdown-mode-map gfm-mode-map)
      :localleader
      :desc "Open compiled markdown in okular" "p" #'seanbr/markdown-open-pdf)

;; run compile on markdown files after saving
(add-hook! '(markdown-mode-hook gfm-mode-hook)
  (add-hook 'after-save-hook #'seanbr/compile-markdown nil 'local))
