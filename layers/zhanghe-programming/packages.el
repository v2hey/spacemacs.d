(setq zhanghe-programming-packages
      '(
        ;; elpy
        flycheck
        company
        lispy
        web-mode
        lsp-mode
        (python :location built-in)
        ))


(defun zhanghe-programming/post-init-flycheck ()
  (with-eval-after-load 'flycheck
    (progn
      (setq flycheck-display-errors-delay 0.9)
      (setq flycheck-idle-change-delay 2.0)
      )))


(defun zhanghe-programming/init-flycheck-package ()
  (use-package flycheck-package))

(defun zhanghe-programming/init-lispy ()
  (use-package lispy
    :defer t
    :init
    (progn
      (add-hook 'emacs-lisp-mode-hook (lambda () (lispy-mode 1)))
      (add-hook 'ielm-mode-hook (lambda () (lispy-mode 1)))
      (add-hook 'inferior-emacs-lisp-mode-hook (lambda () (lispy-mode 1)))
      ;; (add-hook 'spacemacs-mode-hook (lambda () (lispy-mode 1)))
      (add-hook 'clojure-mode-hook (lambda () (lispy-mode 1)))
      (add-hook 'scheme-mode-hook (lambda () (lispy-mode 1)))
      (add-hook 'cider-repl-mode-hook (lambda () (lispy-mode 1)))
      )
    :config
    (progn
      (push '(cider-repl-mode . ("[`'~@]+" "#" "#\\?@?")) lispy-parens-preceding-syntax-alist)

      (spacemacs|hide-lighter lispy-mode)
      (define-key lispy-mode-map (kbd "M-s") 'lispy-splice)
      (define-key lispy-mode-map (kbd "s-k") 'paredit-splice-sexp-killing-backward)

      (with-eval-after-load 'cider-repl
        (define-key cider-repl-mode-map (kbd "C-s-j") 'cider-repl-newline-and-indent))

      (define-key lispy-mode-map (kbd "s-m") 'lispy-mark-symbol)
      (define-key lispy-mode-map (kbd "s-u") 'lispy-undo)
      (define-key lispy-mode-map (kbd "s-1") 'lispy-describe-inline)
      (define-key lispy-mode-map (kbd "s-2") 'lispy-arglist-inline))))


(defun zhanghe-programming/post-init-web-mode ()
  (with-eval-after-load "web-mode"
    (web-mode-toggle-current-element-highlight)
    (web-mode-dom-errors-show))
  (setq company-backends-web-mode '((company-dabbrev-code
                                     company-keywords
                                     company-etags)
                                    company-files company-dabbrev)))


(defun zhanghe-programming/post-init-company ()
  (progn
    (setq company-dabbrev-code-other-buffers 'all)
    ;; enable dabbrev-expand in company completion https://emacs-china.org/t/topic/6381
    (setq company-dabbrev-char-regexp "[\\.0-9a-z-_'/]")

    (setq company-minimum-prefix-length 1
          company-idle-delay 0.08)

    (when (configuration-layer/package-usedp 'company)
      (spacemacs|add-company-backends :modes shell-script-mode makefile-bsdmake-mode sh-mode lua-mode nxml-mode conf-unix-mode json-mode graphviz-dot-mode js2-mode js-mode))
    ))

(defun zhanghe-programming/post-init-lsp-mode ()
  (progn

    (setq lsp-ui-doc-enable nil)
    (defun lsp--auto-configure ()
      "Autoconfigure `lsp-ui', `company-lsp' if they are installed."
      (with-no-warnings
        (when (functionp 'lsp-ui-mode)
          (lsp-ui-mode))
        (cond
         ((eq :none lsp-prefer-flymake))
         ((and (not (version< emacs-version "26.1")) lsp-prefer-flymake)
          (lsp--flymake-setup))
         ((and (functionp 'lsp-ui-mode) (featurep 'flycheck))
          (require 'lsp-ui-flycheck)
          (lsp-ui-flycheck-enable t)
          (flycheck-mode -1)))
        (when (functionp 'company-lsp)
          (company-mode 1)

          ;; make sure that company-capf is disabled since it is not indented to be
          ;; used in combination with lsp-mode (see #884)
          (setq-local company-backends (remove 'company-capf company-backends))
          (when (functionp 'yas-minor-mode)
            (yas-minor-mode t)))))
    (add-hook 'lsp-after-open-hook 'zhanghe-refresh-imenu-index)
    (defun hidden-lsp-ui-sideline ()
      (interactive)
      (if (< (window-width) 180)
          (progn
            (setq lsp-ui-sideline-show-code-actions nil)
            (setq lsp-ui-sideline-show-diagnostics nil)
            (setq lsp-ui-sideline-show-hover nil)
            (setq lsp-ui-sideline-show-symbol nil))
        (progn
          (setq lsp-ui-sideline-show-code-actions nil)
          ;; (setq lsp-ui-sideline-show-diagnostics t)
          (setq lsp-ui-sideline-show-hover t)
          ;; (setq lsp-ui-sideline-show-symbol t)
          )))
    (advice-add 'lsp-ui-sideline--run :after 'hidden-lsp-ui-sideline)
    (setq lsp-auto-configure t)
    (setq lsp-prefer-flymake nil)))


;; (defun zhanghe-programming/init-elpy ()
    ;; (use-package elpy
    ;; :init
    ;; :config
    ;; (elpy-enable)))

