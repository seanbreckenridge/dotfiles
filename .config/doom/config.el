;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(load! "functions")

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Sean Breckenridge"
      user-mail-address "seanbrecke@gmail.com")

;; general appearance

(setq
 doom-font (font-spec :family "Source Code Pro" :size 15)
 doom-theme 'doom-one
 display-line-numbers-type 'relative
 projectile-project-search-path '("~/code/")
 org-directory "~/Documents/org/"
 )

;; custom bindings
(map! :leader
      ;; list my config files and let me fuzzy match to edit one
      (:prefix "f"
        :desc "Edit global config files" "C" #'my/counsel-edit-config)
      ;; open URL, defaults to URL under cursor
      (:prefix "o"
        :desc "Open URL" "l" #'browse-url)
      )

;;;; Fontify html hex codes
;; automatically color hex color strings
(defvar hexcolor-keywords
  '(("#[abcdefABCDEF[:digit:]]\\{6\\}"
     (0 (put-text-property (match-beginning 0)
                           (match-end 0)
                           'face (list :background
                                       (match-string-no-properties 0)))))))

;; xclip
(xclip-mode 1)

;; line wrapping
;; (remove-hook 'text-mode-hook #'auto-fill-mode) ; disable hard wrapping
;; (add-hook 'text-mode-hook #'visual-line-mode) ; enable soft wrapping
(global-visual-line-mode 1)

;;;; language configuration

;;;; C/C++

(require 'ccls)

(setq
 ccls-executable "/usr/bin/ccls")

;;;; python
;; bind pipenv minor mode
(use-package! pipenv
  :hook (python-mode . pipenv-mode)
  :init
  (setq
   pipenv-projectile-after-switch-function
   #'pipenv-projectile-after-switch-extended))

(after! (python flycheck lsp-ui)
  (defun setup-flycheck ()
    (flycheck-add-next-checker 'lsp 'python-pylint)
    )
  )

;; disable mypy
(setq-default flycheck-disabled-checkers '(python-mypy))

(after! lsp
  (setq lsp-pyls-plugins-pycodestyle-enabled nil ;; Disable to ensure sanity
        lsp-pyls-plugins-pylint-enabled nil ;; Disable to ensure performance
        lsp-pyls-plugins-rope-completion-enabled nil ;; Disable to ensure jedi
        lsp-pyls-configuration-sources ["flake8"]
        lsp-print-performance nil
        lsp-enable-indentation nil
        lsp-enable-on-type-formatting nil
        lsp-enable-symbol-highlighting nil
        lsp-log-io nil))

;;;; terminal
;; set default TERM to xterm to allow colors/scrolling
(map! :after shell
      :leader
      (:prefix "o"
        :desc "Open shell here" "T"
        (lambda! (+shell/here "export TERM=xterm"))))

;;;; latex
;; bind latex preview mode to spc m p
(map! :after latex
      :map LaTeX-mode-map
      :localleader
      :desc "Display LaTeX preivew pane" "p" #'latex-preview-pane-mode)

;;;; elisp
;; Aggressively indent emacslisp
(use-package! aggressive-indent
  :commands (aggressive-indent-mode))
(add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)

;;;; markdown
;; open pdf that corresponds to current buffer in okular
(map! :after markdown-mode
      :map (markdown-mode-map gfm-mode-map)
      :localleader
      :desc "Open compiled markdown in okular" "p" #'my/markdown-open-pdf)

;; run compile on markdown files after saving
(add-hook! '(markdown-mode-hook gfm-mode-hook)
  (add-hook 'after-save-hook #'my/compile-markdown nil 'local))
