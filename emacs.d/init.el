;;##############################################################################
;; General
;;##############################################################################
;;-- Death to tabs!
(setq-default indent-tabs-mode nil)   ;; don't use tabs to indent
(setq-default tab-width 8)            ;; but maintain correct appearance
;;-- Set default browser
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "chromium")
;; Buffer Management
(defun kill-other-buffers ()
  "Kill all buffers but the current one.
Don't mess with special buffers."
  (interactive)
  (dolist (buffer (buffer-list))
    (unless (or (eql buffer (current-buffer)) (not (buffer-file-name buffer)))
      (kill-buffer buffer))))
(global-set-key (kbd "C-c k") 'kill-other-buffers)
;;------------------------------------------------------------------------------
;;-- Packages
;;------------------------------------------------------------------------------
(require 'package)
(package-initialize)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
;;------------------------------------------------------------------------------
;;-- Emacs UI
;;------------------------------------------------------------------------------
(setq inhibit-startup-screen t)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(blink-cursor-mode -1)
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)
(fset 'yes-or-no-p 'y-or-n-p)
(load-theme 'zenburn t)
(set-default-font "Inconsolata-11")
(global-hl-line-mode +1)
;;------------------------------------------------------------------------------
;;-- Backups
;;------------------------------------------------------------------------------
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
      backup-by-copying t    ; Don't delink hardlinks
      version-control t      ; Use version numbers on backups
      delete-old-versions t  ; Automatically delete excess backups
      kept-new-versions 20   ; how many of the newest versions to keep
      kept-old-versions 5    ; and how many of the old
      )
;;------------------------------------------------------------------------------
;;-- Yasnippet
;;------------------------------------------------------------------------------
(yas-global-mode 1)
;;------------------------------------------------------------------------------
;;-- Ido
;;------------------------------------------------------------------------------
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)
;;##############################################################################
;; Code
;;##############################################################################
;;------------------------------------------------------------------------------
;;--Paren Matching
;;------------------------------------------------------------------------------
(require 'paren)
(setq show-paren-style 'parenthesis)
(show-paren-mode +1)
;;------------------------------------------------------------------------------
;;--Autopair
;;------------------------------------------------------------------------------
(electric-pair-mode +1)
;;------------------------------------------------------------------------------
;;-- Ocaml
;;------------------------------------------------------------------------------
(setq auto-mode-alist
      (append '(("\\.ml[ily]?$" . tuareg-mode)
                ("\\.topml$" . tuareg-mode))
              auto-mode-alist))
;;------------------------------------------------------------------------------
;;-- C
;;------------------------------------------------------------------------------
(add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)
;;------------------------------------------------------------------------------
;;-- Python
;;------------------------------------------------------------------------------
(require `nose)
;;------------------------------------------------------------------------------
;;---- EIN (Ipython notebook)
;;------------------------------------------------------------------------------
(defalias 'python-indent-line-function 'python-indent-line)
;;------------------------------------------------------------------------------
;;-- Lisp Like
;;------------------------------------------------------------------------------
;;---- Common Lisp
(load (expand-file-name "~/quicklisp/slime-helper.el"))
  ;; Replace "sbcl" with the path to your implementation
  (setq inferior-lisp-program "sbcl")
;;---- Paredit
(autoload 'paredit-mode "paredit"
  "Minor mode for pseudo-structurally editing Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
(add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
(add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'scheme-mode-hook           (lambda () (paredit-mode +1)))
;;------------------------------------------------------------------------------
;; Org Mode
;;------------------------------------------------------------------------------
(require 'org-latex)
(setq org-agenda-files (quote ("~/org/agenda.org" "~/org/schedule.org")))
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(setq org-log-done t)
;;-- Standard key bindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
;;-- Synatx Highlighting for Code
(setq org-export-latex-listings 'minted)
(add-to-list 'org-export-latex-packages-alist '("" "minted"))
(setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))
(setq org-src-fontify-natively t)
;;-- Blogging
(setq org2blog/wp-blog-alist
      '(("wordpress"
         :url "http://sufficiently-random.com/xmlrpc.php"
         :username "mvc")))
;;##############################################################################
;; Chat
;;##############################################################################
(defun bitlbee ()
  "Connect to IM networks using bitlbee."
  (interactive)
  (erc :server "localhost" :port 6667 :nick "mvc"))
