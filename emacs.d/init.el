(package-initialize)

;------------------------------------------------------------------------------
; THEME
;------------------------------------------------------------------------------
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/solarized")
(load-theme 'solarized t)

;------------------------------------------------------------------------------
; EVIL MODE
;------------------------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/packages/evil")
(require 'evil)
(evil-mode 1)


;------------------------------------------------------------------------------
; ORG MODE
;------------------------------------------------------------------------------
;(add-hook 'org-mode-hook (lambda () (org-indent-mode t)) t)
(with-eval-after-load 'org 
                      (setq org-startup-indented t) 
                      (add-hook 'org-mode-hook #'visual-line-mode))
