;;(add-to-list 'load-path "~/.emacs.d/plugins")
(setq default-major-mode 'text-mode)

(custom-set-variables
;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
;; Your init file should contain only one such instance.
'(case-fold-search t)
'(current-language-environment "UTF-8")
'(default-input-method "rfc1345")
'(font-lock-mode 1 t)
'(global-font-lock-mode t nil (font-lock))
'(setq font-lock-keywords t)
'(show-paren-mode t t)
'(transient-mark-mode t))
(custom-set-faces
;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
;; Your init file should contain only one such instance.
)



;; :( Cant get this to work...
;;(require 'yasnippet-bundle)
;;(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
;;(require 'yasnippet) ;; not yasnippet-bundle
;;(yas/initialize)
;;(yas/load-directory "~/.emacs.d/plugins/yasnippet/snippets")

;; Python
;;(require 'python-mode)
;;(autoload 'python-mode "python-mode" "Python editing mode." t)
(add-to-list 'auto-mode-alist '("\\.py$" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
(defun my-python-mode-hook ()
(setq font-lock-keywords python-font-lock-keywords)
(font-lock-mode 1))
(add-hook 'python-mode-hook 'my-python-mode-hook)
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
;;(eval-after-load "pymacs"
;;  '(add-to-list 'pymacs-load-path YOUR-PYMACS-DIRECTORY"))

(add-to-list 'auto-mode-alist '("\\.js\\'" . javascript-mode))
(autoload 'javascript-mode "javascript" nil t)

(require 'ido)
(ido-mode t)

;;;; use the cvs version to speed it up!
;; C-x C-f /remotehost:filename  RET (or /method:user@remotehost:filename)
;; C-x C-f /su::/etc/hosts RET
(setq tramp-default-method "ssh")

(require 'info-look);; C-h S to look up a


(global-set-key "\M-z" 'redo)

(setq font-lock-maximum-decoration t)
(setq x-stretch-cursor t)
(setq minibuffer-max-depth nil)
(setq inhibit-startup-message t)


(add-hook 'find-file-hook 'elide-head)



;;;; Spelling 
;;(setq ispell-dictionary "american")
;;(global-set-key "\M-s" 'ispell-buffer)
;; Dir scan
;;(setq ispell-process-directory (expand-file-name "~/"))
;; Make aspell go faster
;;(setq ispell-program-name "aspell")
;;(setq ispell-extra-args '("--sug-mode=ultra"))
;; Add (prog) fly spelling where its needed
;;(add-hook 'text-mode-hook 'flyspell-mode)
;;(autoload 'flyspell-prog-mode "flyspell" "On-the-fly spelling checker." t)
;;(add-hook 'python-mode-hook 'flyspell-prog-mode)
;;(add-hook 'html-mode-hook 'flyspell-prog-mode)
;;(add-hook 'js2-mode-hook 'flyspell-prog-mode)
;;(add-hook 'php-mode-hook 'flyspell-prog-mode)

