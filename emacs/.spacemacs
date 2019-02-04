;; -*- mode: emacs-lisp -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs
   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation nil
   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t
   ;; If non-nil layers with lazy install support are lazy installed.
   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()
   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press <SPC f e R> (Vim style) or
     ;; <M-m f e R> (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     helm
     (auto-completion :variables auto-completion-enable-help-tooltip t)
     better-defaults
     (colors :variables colors-enable-nyan-cat-progress-bar t)
     deft
     emacs-lisp
     git
     markdown
     org
     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom)
     spell-checking
     syntax-checking

     html
     javascript
     (latex :variables latex-enable-auto-fill t)
     python
     (rust :variables rust-enable-rustfmt-on-save t)
     scheme
     typescript
     yaml
     )
   ;; List of additional packages that will be installed without being
   ;; wrapped in a layer. If you need some configuration for these
   ;; packages, then consider creating a layer. You can also put the
   ;; configuration in `dotspacemacs/user-config'.
   dotspacemacs-additional-packages '(
                                      comment-dwim-2
                                      crux
                                      dockerfile-mode
                                      intero
                                      nginx-mode
                                      paredit
                                      puppet-mode
                                      sage-shell-mode
                                      solidity-mode
                                      writegood-mode
                                      xah-math-input
                                      )
   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()
   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '(evil-search-highlight-persist)
   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and uninstall any
   ;; unused packages as well as their unused dependencies.
   ;; `used-but-keep-unused' installs only the used packages but won't uninstall
   ;; them if they become unused. `all' installs *all* packages supported by
   ;; Spacemacs and never uninstall them. (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization function.
This function is called at the very startup of Spacemacs initialization
before layers configuration.
You should not put any user code in there besides modifying the variable
values."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t
   ;; Maximum allowed time in seconds to contact an ELPA repository.
   dotspacemacs-elpa-timeout 5
   ;; If non nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil
   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'.
   dotspacemacs-elpa-subdirectory nil
   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'emacs
   ;; If non nil output loading progress in `*Messages*' buffer. (default nil)
   dotspacemacs-verbose-loading nil
   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official
   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `bookmarks' `projects' `agenda' `todos'."
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))
   ;; True if the home buffer should respond to resize events.
   dotspacemacs-startup-buffer-responsive t
   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode
   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press <SPC> T n to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-dark
                         spacemacs-light)
   ;; If non nil the cursor color matches the state color in GUI Emacs.
   dotspacemacs-colorize-cursor-according-to-state t
   ;; Default font, or prioritized list of fonts. `powerline-scale' allows to
   ;; quickly tweak the mode-line size to make separators look not too crappy.
   dotspacemacs-default-font '("Source Code Pro"
                               :size 13
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   ;; The leader key
   dotspacemacs-leader-key "SPC"
   ;; The key used for Emacs commands (M-x) (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"
   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"
   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"
   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","
   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m")
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs C-i, TAB and C-m, RET.
   ;; Setting it to a non-nil value, allows for separate commands under <C-i>
   ;; and TAB or <C-m> and RET.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil
   ;; If non nil `Y' is remapped to `y$' in Evil states. (default nil)
   dotspacemacs-remap-Y-to-y$ nil
   ;; If non-nil, the shift mappings `<' and `>' retain visual state if used
   ;; there. (default t)
   dotspacemacs-retain-visual-state-on-shift t
   ;; If non-nil, J and K move lines up and down when in visual mode.
   ;; (default nil)
   dotspacemacs-visual-line-move-text nil
   ;; If non nil, inverse the meaning of `g' in `:substitute' Evil ex-command.
   ;; (default nil)
   dotspacemacs-ex-substitute-global nil
   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"
   ;; If non nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil
   ;; If non nil then the last auto saved layouts are resume automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil
   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1
   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache
   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5
   ;; If non nil, `helm' will try to minimize the space it uses. (default nil)
   dotspacemacs-helm-resize nil
   ;; if non nil, the helm header is hidden when there is only one source.
   ;; (default nil)
   dotspacemacs-helm-no-header nil
   ;; define the position to display `helm', options are `bottom', `top',
   ;; `left', or `right'. (default 'bottom)
   dotspacemacs-helm-position 'bottom
   ;; Controls fuzzy matching in helm. If set to `always', force fuzzy matching
   ;; in all non-asynchronous sources. If set to `source', preserve individual
   ;; source settings. Else, disable fuzzy matching in all sources.
   ;; (default 'always)
   dotspacemacs-helm-use-fuzzy 'always
   ;; If non nil the paste micro-state is enabled. When enabled pressing `p`
   ;; several times cycle between the kill ring content. (default nil)
   dotspacemacs-enable-paste-transient-state nil
   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4
   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom
   ;; If non nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t
   ;; If non nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil
   ;; If non nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil
   ;; If non nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90
   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90
   ;; If non nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t
   ;; If non nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t
   ;; If non nil unicode symbols are displayed in the mode line. (default t)
   dotspacemacs-mode-line-unicode-symbols t
   ;; If non nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t
   ;; Control line numbers activation.
   ;; If set to `t' or `relative' line numbers are turned on in all `prog-mode' and
   ;; `text-mode' derivatives. If set to `relative', line numbers are relative.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; (default nil)
   dotspacemacs-line-numbers nil
   ;; Code folding method. Possible values are `evil' and `origami'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil
   ;; If non-nil smartparens-strict-mode will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil
   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc…
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil
   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all
   ;; If non nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil
   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `ag', `pt', `ack' and `grep'.
   ;; (default '("ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("ag" "pt" "ack" "grep")
   ;; The default package repository used if no explicit repository has been
   ;; specified with an installed package.
   ;; Not used for now. (default nil)
   dotspacemacs-default-package-repository nil
   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed'to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup 'changed
   ))

(defun dotspacemacs/user-init ()
  "Initialization function for user code.
It is called immediately after `dotspacemacs/init', before layer configuration
executes.
 This function is mostly useful for variables that need to be set
before packages are loaded. If you are unsure, you should try in setting them in
`dotspacemacs/user-config' first."
  )

(defun dotspacemacs/user-config ()
  "Configuration function for user code.
This function is called at the very end of Spacemacs initialization after
layers configuration.
This is the place where most of your configurations should be done. Unless it is
explicitly specified that a variable should be set before a package is loaded,
you should place your code here."

  ;; keybindings
  (global-set-key (kbd "C-z") 'repeat)
  (global-set-key (kbd "C-x k") (lambda () (interactive) (kill-buffer)))
  (global-set-key (kbd "C-c j") 'just-one-space)
  (global-set-key "\M-9" 'backward-sexp)
  (global-set-key "\M-0" 'forward-sexp)
  (global-set-key (kbd "M-n") 'flycheck-next-error)
  (global-set-key (kbd "M-p") 'flycheck-previous-error)
  (global-set-key (kbd "M-,") 'pop-tag-mark)
  (global-set-key (kbd "C-=") 'er/expand-region)
  (global-set-key (kbd "M-;") 'comment-dwim-2)
  (global-set-key (kbd "C-c m") 'magit-status)
  (global-set-key (kbd "C-c s") 'yas-expand)
  (global-set-key (kbd "C-c d") 'define-word-at-point)
  ;; Hyper
  (global-set-key (kbd "H-a") 'align-regexp)
  (global-set-key (kbd "H-w") 'whitespace-cleanup)
  (global-set-key (kbd "H-s") 'sort-lines)
  (global-set-key (kbd "H-e") 'spacemacs/shell-pop-eshell)
  ;; quick moving, from: http://whattheemacsd.com/key-bindings.el-02.html
  (global-set-key (kbd "C-S-n")
                  (lambda ()
                    (interactive)
                    (ignore-errors (next-line 5))))
  (global-set-key (kbd "C-S-p")
                  (lambda ()
                    (interactive)
                    (ignore-errors (previous-line 5))))
  (global-set-key (kbd "C-S-f")
                  (lambda ()
                    (interactive)
                    (ignore-errors (forward-char 5))))
  (global-set-key (kbd "C-S-b")
                  (lambda ()
                    (interactive)
                    (ignore-errors (backward-char 5))))
  ;; Window move bindings, move focus to window with shift-{left,right,up,down}
  (when (fboundp 'windmove-default-keybindings)
    (windmove-default-keybindings))

  (require 'crux)
  (global-set-key [remap move-beginning-of-line] #'crux-move-beginning-of-line)
  (global-set-key [remap kill-whole-line] #'crux-kill-whole-line)
  (global-set-key (kbd "C-w") 'kill-region)
  (crux-with-region-or-line kill-region)    ; kill line if nothing is marked
  (crux-with-region-or-line kill-ring-save) ; copy line if nothing is marked
  (global-set-key (kbd "C-c e") #'crux-eval-and-replace)

  ;; better upcase/downcase-word, from: http://oremacs.com/2014/12/23/upcase-word-you-silly/
  (defadvice upcase-word (before upcase-word-advice activate)
    (unless (looking-back "\\b")
      (backward-word)))
  (defadvice downcase-word (before downcase-word-advice activate)
    (unless (looking-back "\\b")
      (backward-word)))
  (defadvice capitalize-word (before capitalize-word-advice activate)
    (unless (looking-back "\\b")
      (backward-word)))
  (setq require-final-newline t)
  ;; toggle GUI bars
  (defun toggle-bars ()
    (interactive)
    (if menu-bar-mode (menu-bar-mode 0) (menu-bar-mode))
    (if tool-bar-mode (tool-bar-mode 0) (tool-bar-mode))
    (if scroll-bar-mode (scroll-bar-mode 0) (scroll-bar-mode)))
  (global-set-key [f12] 'toggle-bars)

  ;; dumb-jump
  (global-set-key (kbd "M-g j") 'dumb-jump-go)
  (global-set-key (kbd "M-g b") 'dumb-jump-back)
  (global-set-key (kbd "M-g q") 'dumb-jump-quick-look)

  ;; ace window
  (global-set-key (kbd "M-o") 'ace-window)
  (global-set-key (kbd "C-x C-o") 'ace-swap-window)
  (setq aw-scope 'frame)
  ;; switch window split direction, from https://www.emacswiki.org/emacs/ToggleWindowSplit
  (defun window-toggle-split-direction ()
    "Switch window split from horizontally to vertically, or vice versa.
     i.e. change right window to bottom, or change bottom window to right."
    (interactive)
    (require 'windmove)
    (let ((done))
      (dolist (dirs '((right . down) (down . right)))
        (unless done
          (let* ((win (selected-window))
                 (nextdir (car dirs))
                 (neighbour-dir (cdr dirs))
                 (next-win (windmove-find-other-window nextdir win))
                 (neighbour1 (windmove-find-other-window neighbour-dir win))
                 (neighbour2 (if next-win (with-selected-window next-win
                                            (windmove-find-other-window neighbour-dir next-win)))))
            ;;(message "win: %s\nnext-win: %s\nneighbour1: %s\nneighbour2:%s" win next-win neighbour1 neighbour2)
            (setq done (and (eq neighbour1 neighbour2)
                            (not (eq (minibuffer-window) next-win))))
            (if done
                (let* ((other-buf (window-buffer next-win)))
                  (delete-window next-win)
                  (if (eq nextdir 'right)
                      (split-window-vertically)
                    (split-window-horizontally))
                  (set-window-buffer (windmove-find-other-window neighbour-dir) other-buf))))))))
  (global-set-key (kbd "C-c t") 'window-toggle-split-direction)

  ;; anzu
  (global-set-key (kbd "M-%") 'anzu-query-replace)
  (global-set-key (kbd "M-S-%") 'anzu-query-replace-regexp)
  (global-set-key (kbd "C-c r") 'anzu-query-replace-at-cursor-thing)

  ;; subword mode, treats "CamelCase" as two words
  (global-subword-mode t)

  ;; org mode
  (with-eval-after-load 'org
    (org-babel-do-load-languages
     'org-babel-load-languages
     '((emacs-lisp . t)
       (scheme . t)
       (python . t)))
    (setq org-confirm-babel-evaluate nil)
    (setq org-babel-python-command "python3")
    ;; syntax highlighting with LaTeX export
    (require 'ox-latex)
    (setq org-latex-listings 'minted)
    (add-to-list 'org-latex-packages-alist '("" "minted"))
    ;; latex library in texlive-latex-extra, needs python-pygments
    )

  ;; markdown
  (add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))
  (setq markdown-command "pandoc")
  ;; markdow-toc: don't include title of file in toc
  (custom-set-variables '(markdown-toc-user-toc-structure-manipulation-fn 'cdr))

  ;; deft
  (setq deft-directory "~/Sync/Notes/")
  (global-set-key (kbd "<f8>") 'spacemacs/deft)

  ;; modeline
  (setq display-time-24hr-format t)
  (setq display-time-mail-string "")
  (display-time-mode 1)
  ;; smaller major mode names, from: http://whattheemacsd.com/appearance.el-01.html
  (defmacro rename-modeline (package-name mode new-name)
    `(eval-after-load ,package-name
       '(defadvice ,mode (after rename-modeline activate)
          (setq mode-name ,new-name))))
  (rename-modeline "js2-mode" js2-mode "JS2")

  ;; avy goto
  (global-set-key (kbd "C-'") 'avy-goto-char-2)
  (global-set-key (kbd "C-0") 'avy-goto-char-timer)
  (setq avy-timeout-seconds 0.4)
  (global-set-key (kbd "M-g g") 'avy-goto-line)
  (define-key isearch-mode-map (kbd "C-'") 'avy-isearch)
  (define-key isearch-mode-map (kbd "C-o") 'helm-occur-from-isearch)

  ;; leave point at start match in isearch, from: https://www.emacswiki.org/emacs/ZapToISearch
  (defun isearch-exit-other-end (rbeg rend)
    "Exit isearch, but at the other end of the search string.
     This is useful when followed by an immediate kill."
    (interactive "r")
    (isearch-exit)
    (goto-char isearch-other-end))
  (define-key isearch-mode-map (kbd "C-<return>") 'isearch-exit-other-end)

  ;; frame title, from prelude
  (setq frame-title-format
        '("" (:eval (if (buffer-file-name)
                        (abbreviate-file-name (buffer-file-name))
                      "%b"))))

  ;; Helm
  (global-set-key (kbd "M-y") 'helm-show-kill-ring)
  (global-set-key (kbd "C-x b") 'helm-mini)
  (global-set-key (kbd "C-x C-b") 'helm-mini)
  (global-set-key (kbd "C-h a") 'helm-apropos)
  (global-set-key (kbd "C-c i") 'helm-semantic-or-imenu)
  (global-set-key (kbd "C-c o") 'helm-occur)

  ;; magit
  (setq magit-diff-refine-hunk 'all)

  ;; rainbow mode, colourize hex colour names in buffers
  (add-hook 'html-mode-hook 'rainbow-mode)
  (add-hook 'css-mode-hook 'rainbow-mode)

  ;; prettify symbols
  (global-prettify-symbols-mode t)
  (add-hook 'prog-mode-hook
            (lambda ()
              (setq prettify-symbols-alist
                    '(("lambda" . ?λ)
                      ("<=" . ?≤) (">=" . ?≥)))))

  ;; haskell
  (add-hook 'haskell-mode-hook 'intero-mode)
  (add-hook 'haskell-mode-hook
            (lambda ()
              (setq prettify-symbols-alist
                    '(("\\" . ?λ)
                      ("<=" . ?≤) (">=" . ?≥)))
              (define-key haskell-mode-map (kbd "C-c C-v") 'haskell-check)))

  ;; javascript
  (setq js2-highlight-level 3)
  (setq js2-strict-trailing-comma-warning nil)

  ;; octave mode
  (setq auto-mode-alist
        (cons '("\\.m$" . octave-mode) auto-mode-alist))
  (add-hook 'octave-mode-hook
            (lambda ()
              (define-key octave-mode-map (kbd "C-c C-c") 'octave-send-buffer)
              (define-key octave-mode-map (kbd "C-M-x") 'octave-send-defun)))

  ;; python
  (setq python-shell-interpreter "python3")
  (defun switch-python-version ()
    (interactive)
    (if (equal python-shell-interpreter "python3")
        (setq python-shell-interpreter "python")
      (setq python-shell-interpreter "python3"))
    (message python-shell-interpreter))
  (global-set-key (kbd "<M-f3>") 'switch-python-version)
  (defvaralias 'flycheck-python-flake8-executable 'python-shell-interpreter)
  (setq flycheck-flake8rc "~/.config/flake8")
  (add-hook 'anaconda-mode-hook
            (lambda ()
              (define-key anaconda-mode-map (kbd "M-,") 'anaconda-mode-go-back)
              (define-key anaconda-mode-map (kbd "M-*") 'anaconda-mode-find-assignments)))

  ;; sagemath
  (sage-shell:define-alias)
  (add-hook 'sage-shell-mode-hook #'eldoc-mode)
  (add-hook 'sage-shell:sage-mode-hook #'eldoc-mode)
  (setq sage-shell:use-prompt-toolkit t)

  ;; autoenv files
  (add-to-list 'auto-mode-alist '(".env" . shell-script-mode))

  ;; web mode
  (defun my-web-mode-hook ()
    "Hooks for Web mode."
    (setq web-mode-markup-indent-offset 2)
    (setq web-mode-comment-style 2)
    (setq web-mode-enable-auto-indentation nil))
  (add-hook 'web-mode-hook 'my-web-mode-hook)
  (setq web-mode-engines-alist
        '(("django"    . "\\.html\\'")))

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

  ;; http://stackoverflow.com/a/20967895
  (defun sort-lines-no-case ()
    (interactive)
    (let ((sort-fold-case t))
      (call-interactively 'sort-lines)))

  ;; paredit, from http://www.emacswiki.org/emacs/ParEdit
  (autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
  (add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
  (add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
  (add-hook 'ielm-mode-hook             #'enable-paredit-mode)
  (add-hook 'lisp-mode-hook             #'enable-paredit-mode)
  (add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
  (add-hook 'scheme-mode-hook           #'enable-paredit-mode)

  ;; auto text filling
  (setq-default fill-column 80)
  (spacemacs/add-to-hooks 'auto-fill-mode '(text-mode-hook org-mode-hook latex-mode))

  ;; writegood mode
  (spacemacs/add-to-hooks 'writegood-mode '(text-mode-hook org-mode-hook latex-mode))

  ;; bigger fill column for latex
  (add-hook 'LaTeX-mode-hook
            (lambda ()
              (setq-default fill-column 100)))
  ;; end
  )

;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (puppet-mode solidity-mode ghub let-alist org-mime org-category-capture dockerfile-mode tide typescript-mode winum unfill fuzzy sage-shell-mode deferred intero hlint-refactor hindent helm-hoogle haskell-snippets flycheck-haskell company-ghci company-ghc ghc haskell-mode company-cabal cmm-mode yaml-mode xah-math-input writegood-mode paredit nginx-mode crux comment-dwim-2 yapfify xterm-color web-mode web-beautify toml-mode tagedit smeargle slim-mode shell-pop scss-mode sass-mode rainbow-mode rainbow-identifiers racer pyvenv pytest pyenv-mode py-isort pug-mode pip-requirements orgit org-projectile org-present org org-pomodoro alert log4e gntp org-download mwim multi-term mmm-mode markdown-toc markdown-mode magit-gitflow livid-mode skewer-mode simple-httpd live-py-mode less-css-mode json-mode json-snatcher json-reformat js2-refactor multiple-cursors js2-mode js-doc hy-mode htmlize helm-pydoc helm-gitignore helm-css-scss helm-company helm-c-yasnippet haml-mode gnuplot gitignore-mode gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link gh-md geiser flyspell-correct-helm flyspell-correct flycheck-rust seq flycheck-pos-tip flycheck evil-magit magit magit-popup git-commit with-editor eshell-z eshell-prompt-extras esh-help emmet-mode deft cython-mode company-web web-completion-data company-tern dash-functional tern company-statistics company-quickhelp pos-tip company-auctex company-anaconda company color-identifiers-mode coffee-mode cargo rust-mode auto-yasnippet yasnippet auto-dictionary auctex-latexmk auctex anaconda-mode pythonic ac-ispell auto-complete ws-butler window-numbering which-key volatile-highlights vi-tilde-fringe uuidgen use-package toc-org spaceline powerline restart-emacs request rainbow-delimiters popwin persp-mode pcre2el paradox spinner org-plus-contrib org-bullets open-junk-file neotree move-text macrostep lorem-ipsum linum-relative link-hint info+ indent-guide ido-vertical-mode hydra hungry-delete hl-todo highlight-parentheses highlight-numbers parent-mode highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-projectile helm-mode-manager helm-make projectile pkg-info epl helm-flx helm-descbinds helm-ag google-translate golden-ratio flx-ido flx fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state smartparens evil-indent-plus evil-iedit-state iedit evil-exchange evil-escape evil-ediff evil-args evil-anzu anzu evil goto-chg undo-tree eval-sexp-fu highlight elisp-slime-nav dumb-jump f s diminish define-word column-enforce-mode clean-aindent-mode bind-map bind-key auto-highlight-symbol auto-compile packed dash aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line helm avy helm-core popup async quelpa package-build spacemacs-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
