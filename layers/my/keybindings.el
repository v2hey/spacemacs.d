;; keybindings.el --- My Layer packages File for Spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;; License: GPLv3

;; A complementary binding to the apropos-command (C-h a)
(define-key 'help-command "A" 'apropos)
(define-key 'help-command (kbd "C-f") 'find-function)
(define-key 'help-command (kbd "C-k") 'find-function-on-key)
(define-key 'help-command (kbd "C-v") 'find-variable)
(define-key 'help-command (kbd "C-l") 'find-library)
(define-key 'help-command (kbd "C-i") 'info-display-manual)

;; (define-key 'ivy-occur-grep-mode-map (kbd "C-d") 'evil-scroll-down)
(global-set-key [(shift return)] 'zhanghe/smart-open-line)
