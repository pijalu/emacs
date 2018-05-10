;; If needed
;; emacs --batch --eval '(byte-recompile-directory "~/.emacs.d")'

;;
;; disable bell
(setq visible-bell t)
;; no splash
(setq inhibit-splash-screen t)
;; no backup
(setq make-backup-files nil)
;; no bars
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
;;(if (window-system)
;;    (menu-bar-mode 1)
;;  (menu-bar-mode -1)
;;)

;; add elisp load path
(setq load-path (cons "~/.emacs.d/my.elisp" load-path))

;; text stuff
;; (
;;  if window-system
;;     ()
;;    (load "~/elisp/nw-emacs.el")
;; )

;; (modify-frame-parameters (selected-frame) 
;;   `((alpha . 98)))

;; Display the column number of the point in the mode line
(column-number-mode t)
(line-number-mode t)

;; highlight parentheses
(show-paren-mode t) 

;; syn
(global-font-lock-mode t)

;; make marked region highlighted
(setq transient-mark-mode t)
;; reread buffer from file
(global-set-key "\C-x\C-r" 'revert-buffer)

;; Comment region
(global-set-key "\C-c\C-c\C-c" 'comment-region)

;; Use K&R for C/C++
(add-hook 'c-mode-hook		      '(lambda()(c-set-style "k&r")))
(add-hook 'c++-mode-hook	      '(lambda()(c-set-style "stroustrup")))
(setq c-mode-hook
    (function (lambda ()
		(c-set-style "k&r")
		(setq c-basic-offset 2)
                (setq indent-tabs-mode nil)
                (setq c-indent-level 4))))

;; no backup
(setq make-backup-files nil)
(setq c-basic-offset 2)
(global-set-key "%" 'match-paren)

(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
        (t (self-insert-command (or arg 1))))
)

;; mouse mode
(xterm-mouse-mode t)

;; compile 
(global-set-key [(f5)] 'compile)

;; buffer-menu
(global-set-key [(f6)] 'buffer-menu)

;; load gtags
;;(require 'gtags)

;; winmove
(require 'windmove)
(when (fboundp 'windmove-default-keybindings)
 (windmove-default-keybindings))

;; some other nice trick
;; Pgup/dn will return exactly to the starting point.
(setq scroll-preserve-screen-position 1)
;; don't automatically add new lines when scrolling down at
;; the bottom of a buffer
(setq next-line-add-newlines nil)

;; format the title-bar to always include the buffer name
(setq frame-title-format "emacs - %b")
;; replace highlighted text with what I type rather than just
;; inserting at a point
(delete-selection-mode t)
;; resize the mini-buffer when necessary
(setq resize-minibuffer-mode t)
;; highlight incremental search
(setq search-highlight t)
;; remove scroll
;;(scroll-bar-mode nil)

;; Save last position
(setq save-place-file "~/.emacs.d/saveplace") ;; keep my ~/ clean


(require 'saveplace)                          ;; get the package
(if (>= emacs-major-version 25)
		(save-place-mode 1)
	(setq-default save-place t)
)

;; uniquify
(require 'uniquify) 
(setq 
  uniquify-buffer-name-style 'forward
  uniquify-separator "/")

;; frame 
(global-set-key (kbd "C-c <C-left>") 'shrink-window-horizontally)
(global-set-key (kbd "C-c <C-right>") 'enlarge-window-horizontally)
(global-set-key (kbd "C-c <C-down>") 'shrink-window)
(global-set-key (kbd "C-c <C-up>") 'enlarge-window)

;; clean up buffers
(require 'midnight)

;; stop bothering me
(fset 'yes-or-no-p 'y-or-n-p)

;; Some blabla
;; Diff the current buffer with the file contents
(defun my-diff-current-buffer-with-disk ()
 "Compare the current buffer with it's disk file."
 (interactive)
 (diff-buffer-with-file (current-buffer)))
(global-set-key (kbd "C-c w") 'my-diff-current-buffer-with-disk)


;; mac stuff
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)

;; ido
;; (require 'ido)
;; (ido-mode t)
;; (setq ido-enable-flex-matching t) ;; enable fuzzy matching


;; shell compile
;; (defun sh-check-finish-hook (buf msg)
;;  "Function, that is executed at the end of sh check"
;;  (when (not (string-match "finished" msg))
;;    (next-error 1 t)))

;;(if window-system(load "~/.emacs.d/my.elisp/emacs-powerline.el"))
;; TTY fix
(load-file "~/.emacs.d/my.elisp/xterm-256color.el")
;; some color theme-setting
;;(load "~/elisp/color-theme-start.el")

;;(iswitchb-mode t)

(setq display-time-day-and-date t
      display-time-24hr-format t)

;;(hs-minor-mode t)
(hide-ifdef-mode t)
;;(display-time)

;;(global-set-key [(f7)] 'semantic-idle-completions-mode)
;; (setq my-font "-*-terminus-medium-r-*-*-14-*-*-*-*-*-*-*")
;; (set-frame-font my-font)
;; (add-hook 'after-make-frame-functions
;;        (lambda (cur-frame)
;;        (modify-frame-parameters cur-frame
;;        (list
;;        (cons 'font my-font)))))

;; ido makes competing buffers and finding files easier
;; http://www.emacswiki.org/cgi-bin/wiki/InteractivelyDoThings
(require 'ido) 
(ido-mode 'both) ;; for buffers and files
(setq 
  ido-everywhere t
  ido-save-directory-list-file "~/.emacs.d/cache/ido.last"

  ido-enable-last-directory-history t ; remember last used dirs
  ido-max-work-directory-list 30   ; should be enough
  ido-max-work-file-list      50   ; remember many
  ido-use-filename-at-point nil    ; don't use filename at point (annoying)
  ido-use-url-at-point nil         ; don't use url at point (annoying)
  ido-enable-flex-matching t       ; try to be too smart
  ido-max-prospects 8              ; don't spam my minibuffer
  ido-create-new-buffer 'always
  ido-file-extensions-order '(".c" ".h" t)
  ido-ignore-extensions '(".o" ".H")
  ido-enable-tramp-completion nil ; no tramp
)


;; when using ido, the confirmation is rather annoying...
(setq confirm-nonexistent-file-or-buffer nil)

(require 'package)
;; Add ELPA path...
(let ((default-directory "~/.emacs.d/elpa/"))
      (normal-top-level-add-to-load-path '("."))
      (normal-top-level-add-subdirs-to-load-path))
;; don't antialias plz...
;;(setq mac-allow-anti-aliasing nil)


;; load theme
(require 'spacemacs-dark-theme)
;;(if (>= emacs-major-version 24)
;;    (load-file "~/.emacs.d/my.elisp/emacs24.el"))

;;(set-default-font "-apple-Inconsolata-medium-normal-normal-*-*-*-*-*-m-0-iso10646-1")

(setq mac-option-modifier 'meta)
(setq ns-function-modifier 'hyper)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-safe-themes
	 (quote
		("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(package-selected-packages
	 (quote
		(govet gotest fish-completion fish-mode dockerfile-mode flycheck-yamllint yaml-mode markdown-preview-mode markdown-mode tide typescript-mode vlf spacemacs-theme spaceline-all-the-icons scala-mode2 sbt-mode protobuf-mode php-extras nodejs-repl log4j-mode json-mode js2-refactor inf-mongo grunt go-snippets go-scratch go-rename go-guru go-gopath go-errcheck go-eldoc go-dlv go-direx go-complete go-autocomplete geben flymake-shell flymake-ruby flymake-json flymake-jslint flymake-google-cpplint flymake-go flymake-css flymake flycheck-gometalinter exec-path-from-shell es-windows es-lib angular-snippets ac-js2 ac-inf-ruby)))
 '(show-paren-mode t)
 '(tool-bar-mode nil))

(defun toggle-fullscreen ()
  "Toggle full screen"
  (interactive)
  (set-frame-parameter
     nil 'fullscreen
     (when (not (frame-parameter nil 'fullscreen)) 'fullscreen))
  (if (frame-parameter nil 'fullscreen)
    (display-time-mode 1))
  (if (not (frame-parameter nil 'fullscreen))
    (display-time-mode 0))
)
(global-set-key [(f2)] 'toggle-fullscreen)

(if window-system(menu-bar-mode 1)
  (menu-bar-mode 0))


;; Emacs package stuffs
;; Add the original Emacs Lisp Package Archive
(add-to-list 'package-archives
             '("elpa" . "http://tromey.com/elpa/"))
;; Add the user-contributed repository
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))

(add-to-list 'package-archives
              '("melpa" . "http://melpa.org/packages/"))

;;(describe-variable 'package-activated-list)
(setq package-list
      '(flycheck seq let-alist pkg-info epl dash flycheck ac-inf-ruby auto-complete popup inf-ruby ac-js2 skewer-mode js2-mode simple-httpd js2-mode angular-snippets dash s es-lib es-windows exec-path-from-shell flycheck-gometalinter flycheck seq let-alist pkg-info epl dash flymake flymake-css flymake-easy flymake-go flymake-google-cpplint flymake-easy flymake-jslint flymake-easy flymake-json flymake-easy flymake-ruby flymake-easy flymake-shell flymake-easy geben go-autocomplete auto-complete popup go-complete go-mode go-direx direx go-dlv go-mode go-eldoc go-mode go-errcheck go-gopath go-guru go-mode go-rename go-mode go-scratch go-mode go-snippets yasnippet grunt dash inf-mongo inf-ruby js2-refactor yasnippet s dash multiple-cursors s js2-mode json-mode json-snatcher json-reformat json-reformat json-snatcher let-alist log4j-mode multiple-cursors nodejs-repl php-extras php-mode php-mode pkg-info epl popup protobuf-mode sbt-mode scala-mode2 seq skewer-mode js2-mode simple-httpd vlf yasnippet))
; activate all the packages (in particular autoloads)
(package-initialize)
; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))
; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
        (package-install package)))

;; angular
(require 'angular-snippets-autoloads)

;; yas
;;(require 'yasnippet-bundle)
;;(yas/load-directory "~/.emacs.d/elpa/angular-snippets-20140513.2223/snippets/")
(add-to-list 'load-path
						 " ~/.emacs.d/yasnippets")
(require 'yasnippet)
(yas-global-mode 1)

(require 'go-autocomplete)

;; Auto complete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(require 'go-autocomplete)
(require 'auto-complete-config)
(ac-config-default)

(setq-default tab-width 2)

;; go
;;(load-file "~/golang/src/golang.org/x/tools/cmd/oracle/oracle.el")

(require 'govet)
;;Go autocomplete
(defun my-go-mode-hook ()
					; Use goimports instead of go-fmt
  (setq gofmt-command "goimports")
					; Call Gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)
					; Customize compile command to run go build
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
	   "go build -v && go test -v && go vet"))
					; Godef jump key binding
  (local-set-key (kbd "M-.") 'godef-jump)
  (local-set-key (kbd "C-?") 'godoc-at-point)
	(local-set-key (kbd "C-.") 'godef-jump-other-window)

	(define-key go-mode-map (kbd "C-c f") 'go-test-current-file)
	(define-key go-mode-map (kbd "C-c t") 'go-test-current-test)
	(define-key go-mode-map (kbd "C-c p") 'go-test-current-project)
	(define-key go-mode-map (kbd "C-c b") 'go-test-current-benchmark)
	(define-key go-mode-map (kbd "C-c v") 'govet)
	(define-key go-mode-map (kbd "C-c x") 'go-run)
	
)
(add-hook 'go-mode-hook 'my-go-mode-hook)

;;go  testing
;;(require 'go-test)


(require 'go-eldoc) ;; Don't need to require, if you install by package.el
(add-hook 'go-mode-hook 'go-eldoc-setup)

(defun auto-complete-for-go ()
(auto-complete-mode 1))
(add-hook 'go-mode-hook 'auto-complete-for-go)

(require 'go-complete)
(add-hook 'completion-at-point-functions 'go-complete-at-point)

(with-eval-after-load 'go-mode
	(require 'go-autocomplete))

(require 'flycheck)
(add-hook 'go-mode-hook 'flycheck-mode)


;; js2
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-hook 'js2-mode-hook 'ac-js2-mode)
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))
(setq ac-js2-evaluate-calls t)
;;(require 'dash)
(require 'js2-refactor)
(js2r-add-keybindings-with-prefix "C-c C-r")
 
;; org mode
(add-hook 'org-mode-hook 'soft-wrap-lines)


(defun soft-wrap-lines ()
"Make lines wrap at window edge and on word boundary,
in current buffer."
(interactive)
(setq truncate-lines nil)
(setq word-wrap t)
)


(require 'multiple-cursors)
(global-set-key (kbd "C-M->") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;;(set-default-font "-*-terminus-medium-r-*-*-14-*-*-*-*-*-*-*")
;; ;; Terminus
;; (set-default-font "-*-terminus-medium-r-*-*-14-*-*-*-*-*-*-*")
;; ;; also for server modeline;; (setq my-font "-*-terminus-medium-r-*-*-14-*-*-*-*-*-*-*")
;; (setq my-font "-*-terminus-medium-r-*-*-14-*-*-*-*-*-*-*")
;; (set-frame-font my-font)
;; (add-hook 'after-make-frame-functions
;; 	  (lambda (cur-frame)
;; 	    (modify-frame-parameters cur-frame
;; 				     (list
;; 				      (cons 'font my-font)))))

;;(load-file "~/elisp/config.javascript.el")

;;(require 'spaceline-config)
;;(spaceline-spacemacs-theme)

;; (defun new-frame-setup (&optional frame)
;;   (if (display-graphic-p)
;;(load "~/.emacs.d/my.elisp/emacs-powerline.el")
;; 	)
;; )
;; ;; Run now
;; (new-frame-setup)
;; ;; run when a new frame is created using server
;; (add-hook 'after-make-frame-functions 'new-frame-setup)


(setq default-directory "~")

;; propose vlf
;;(require 'vlf-integrate)

;; grunt stuff
(require 'grunt)
(global-set-key (kbd "C-M-g") 'grunt-exec)
(setq grunt-base-command "/usr/local/bin/grunt")
 
(require 'exec-path-from-shell)
(setq exec-path-from-shell-check-startup-files nil)
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "GOPATH"))

;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(mode-line ((t (:foreground "#030303" :background "#bdbdbd" :box nil))))
;;  '(mode-line-inactive ((t (:foreground "#f9f9f9" :background "#666666" :box nil)))))

(require 'spaceline-config)
(setq powerline-default-separator 'wave)
(if (display-graphic-p) 
  	(spaceline-spacemacs-theme)		
	(powerline-default-theme)
)

(global-hl-line-mode 1)
(global-prettify-symbols-mode +1)
(setq prettify-symbols-unprettify-at-point t)

(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C-=") 'text-scale-decrease)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
