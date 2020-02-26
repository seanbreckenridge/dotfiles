;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Sean Breckenridge"
      user-mail-address "seanbrecke@gmail.com")

(setq
 doom-font (font-spec :family "monospace" :size 15)
 doom-theme 'doom-one
 projectile-project-search-path '("~/code/")
 display-line-numbers-type 'relative
 org-directory "~Documents/org/"
 )

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

;; xclip
(xclip-mode 1)

;; line wrapping
;; (remove-hook 'text-mode-hook #'auto-fill-mode) ; disable hard wrapping
;; (add-hook 'text-mode-hook #'visual-line-mode) ; enable soft wrapping
(global-visual-line-mode 1)
