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

;; load personal functions/bindings
(load! "functions")
(load! "bindings")

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Sean Breckenridge"
      user-mail-address "seanbrecke@gmail.com")

;; general appearance

(setq
 doom-font (font-spec :family "Source Code Pro" :size 15)
 doom-theme 'doom-horizon
 display-line-numbers-type 'relative
 projectile-project-search-path '("~/code/")
 org-directory "~/Documents/org/"
 )

;;;; xclip
(xclip-mode 1)

;; line wrapping
;; (remove-hook 'text-mode-hook #'auto-fill-mode) ; disable hard wrapping
;; (add-hook 'text-mode-hook #'visual-line-mode) ; enable soft wrapping
(global-visual-line-mode 1)

;;;; which-key/company
;; decrease popup time
(setq which-key-idle-delay 0.2)

(after! company
  (setq company-idle-delay 0.2))

;;;; ranger
;; use ranger instead of dired
(global-set-key [remap dired] #'ranger)
(ranger-override-dired-mode t)
(setq
 ranger-clean-up-disable t
 ranger-parent-depth 1
 ranger-width-parents 0.3
 ranger-preview-file nil)

;;;; language configuration

;;;; C/C++

(require 'ccls)

(setq
 ccls-executable "/usr/bin/ccls")

;;;; python
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


;;;; json
;; there are two jsonlint binaries installed on my system, one for
;; an unrelated python package and the javascript one (the one that flycheck expects)
;; specify binary location so that flycheck can find it
(after! (flycheck json)
  (setq flycheck-json-jsonlint-executable (concat (seanbr/npm-bin-path) "jsonlint")))

;;;; elisp
;; Aggressively indent emacslisp
(use-package! aggressive-indent
  :commands (aggressive-indent-mode))
(add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)

;;;; elixir
(add-to-list 'interpreter-mode-alist
             '("elixir" . elixir-mode))
