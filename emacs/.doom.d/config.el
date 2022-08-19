;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Rahiel Kasim"
      user-mail-address "rahielkasim@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(map! "C-x b" #'consult-buffer
      "C-x k" #'kill-current-buffer
      "M-o" #'other-window
      "C-x C-o" #'window-swap-states
      "C-c <left>" #'winner-undo
      "C-c <right>" #'winner-redo
      "M-%" #'anzu-query-replace
      "C-c r" #'anzu-query-replace-at-cursor
      "C-c m" #'magit-status-here
      "M-;" #'comment-dwim-2
      "C-c d" #'define-word-at-point
      "s-n" #'make-frame
      "C-c j" #'just-one-space)

(auto-save-visited-mode 1)

;; Better C-w
(require 'crux)
(crux-with-region-or-line kill-region)    ; kill line if nothing is marked
(crux-with-region-or-line kill-ring-save) ; copy line if nothing is marked

;; Window move bindings, move focus to window with shift-{left,right,up,down}
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

;; insert timestamps
(defun insert-timestamp ()
  (interactive)
  (insert (format-time-string "%a %2d %b %Y %02H:%02M")))
(defun insert-date ()
  (interactive)
  (insert (format-time-string "%2d %b %Y")))
(defun insert-iso-date ()
  (interactive)
  (insert (format-time-string "%F")))

;; web mode
(setq web-mode-engines-alist
      '(("django"    . "\\.html\\'")))
