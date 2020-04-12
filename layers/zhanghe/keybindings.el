;; 1. global-set-key、define-key、bind-key* 的区别：
;;    global-set-key 函数，定义于 subr.el, 添加内容到 global-map，作用范围是全局。
;;    define-key 函数，内置 C 函数, (define-key-set 'foo-mode-map ...) 添加内容到 foo-mode-map，作用范围是 foo-mode。
;;    global-map 变量，定义于 subr.el
;;    current-global-map 一般等于 global-map（不知道什么情况是例外）
;;    如果全局和当前 mode 都设置了快捷键，当前 mode 优先
;;    所以下面三种写法作用相同
;;    (global-set-key ...)
;;    (define-key (current-global-map) ...)
;;    (define-key global-map ...)
;;
;;    bind-key* 是方便用户使用的宏, 它的优先级又要比各个模式的map的优先级要高





;; ============================== packages remap ==============================
;; =========== better defaults
;; hippie-expand, default kbd "M-s"
(global-set-key (kbd "s-/") 'hippie-expand)
(global-set-key [remap fill-paragraph] #'endless/fill-or-unfill)
(global-set-key (kbd "C-s-h") 'mark-defun)
(global-set-key (kbd "s-l") 'goto-line)
(global-set-key (kbd "C-c i e") 'spacemacs/auto-yasnippet-expand)
(global-set-key (kbd "C-`") 'toggle-input-method)
;; spacemacs chinese layer
(global-set-key (kbd "C-c y") 'youdao-dictionary-search-at-point+)
(spacemacs/declare-prefix "ot" "Toggle")
;; A complementary binding to the apropos-command (C-h a)
(define-key 'help-command "A" 'apropos)
(define-key 'help-command (kbd "C-f") 'find-function)
(define-key 'help-command (kbd "C-k") 'find-function-on-key)
(define-key 'help-command (kbd "C-v") 'find-variable)
(define-key 'help-command (kbd "C-l") 'find-library)
(define-key 'help-command (kbd "C-i") 'info-display-manual)
(bind-key* "C-c /" 'company-files)
(bind-key* "s-r" 'replace-string)
(bind-key* "s-y" 'aya-expand)
;;Must set key to nil to prevent error: Key sequence b m s starts with non-prefix key b m
(spacemacs/set-leader-keys "bm" nil)
(spacemacs/set-leader-keys "bD" 'spacemacs/kill-other-buffers)
(spacemacs/declare-prefix "bm" "Bookmark")
(spacemacs/set-leader-keys "bms" 'bookmark-set)
(spacemacs/set-leader-keys "bmr" 'bookmark-rename)
(spacemacs/set-leader-keys "bmd" 'bookmark-delete)
(spacemacs/set-leader-keys "od" 'occur-dwim)
;; deal with BOM
(spacemacs/set-leader-keys "fl" 'find-file-literally-at-point)
(spacemacs/set-leader-keys "ri" 'ivy-resume)
(spacemacs/set-leader-keys "fh" 'ffap-hexl-mode)
(spacemacs/set-leader-keys "fd" 'projectile-find-file-dwim-other-window)
(spacemacs/set-leader-keys "nl" 'spacemacs/evil-search-clear-highlight)
(spacemacs/set-leader-keys "ob" 'popwin:display-last-buffer)
(spacemacs/set-leader-keys "oy" 'youdao-dictionary-search-at-point+)
(spacemacs/set-leader-keys "bM" 'spacemacs/switch-to-messages-buffer)
(spacemacs/set-leader-keys "sS" 'spacemacs/swiper-region-or-symbol)
;; windows shortcuts
(when (spacemacs/system-is-mswindows)
  (global-set-key (kbd "s-=") 'spacemacs/scale-up-font)
  (spacemacs/set-leader-keys "bf" 'locate-current-file-in-explorer)
  (global-set-key (kbd "s--") 'spacemacs/scale-down-font)
  (global-set-key (kbd "s-0") 'spacemacs/reset-font-size)
  (global-set-key (kbd "s-q") 'save-buffers-kill-terminal)
  (global-set-key (kbd "s-v") 'yank)
  (global-set-key (kbd "s-g") 'evil-avy-goto-char-2)
  (global-set-key (kbd "s-c") 'evil-yank)
  (global-set-key (kbd "s-a") 'mark-whole-buffer)
  (global-set-key (kbd "s-x") 'kill-region)
  (global-set-key (kbd "s-w") 'delete-window)
  (global-set-key (kbd "s-W") 'delete-frame)
  (global-set-key (kbd "s-n") 'make-frame)
  (global-set-key (kbd "s-z") 'undo-tree-undo)
  (global-set-key (kbd "s-Z") 'undo-tree-redo))

;; =========== org
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c b") 'org-iswitchb)
(global-set-key (kbd "<f9>") 'org-capture)
(global-set-key (kbd "C-c t") 'org-capture)
(spacemacs/set-leader-keys "ox" 'org-open-at-point-global)

;; =========== other

;; =========== ui
(bind-key* "C-c k" 'which-key-show-top-level)

;; =========== misc
;; (bind-key* "s-r" 'mc/reverse-regions)
(bind-key* "C-=" 'er/expand-region)
(bind-key* "s-p" 'find-file-in-project)
(spacemacs/set-leader-keys "rh" 'helm-resume)
(spacemacs/set-leader-keys "sj" 'counsel-imenu)
(spacemacs/set-leader-keys "bmj" 'counsel-bookmark)
(spacemacs/set-leader-keys "of" 'reveal-in-osx-finder)
(spacemacs/set-leader-keys-for-major-mode 'emacs-lisp-mode
  "gU" 'xref-find-references)
;; ivy specific keybindings
(if (configuration-layer/layer-usedp 'ivy)
    (progn
      (spacemacs/set-leader-keys "ff" 'counsel-find-file)
      (spacemacs/set-leader-keys "fL" 'counsel-locate)
      (spacemacs/set-leader-keys "hi" 'counsel-info-lookup-symbol)
      (spacemacs/set-leader-keys "pb" 'projectile-switch-to-buffer)))
(spacemacs/set-leader-keys "os" 'counsel-ag-thing-at-point)
(spacemacs/set-leader-keys "pa" 'projectile-find-other-file)
(spacemacs/set-leader-keys "pA" 'projectile-find-other-file-other-window)
(spacemacs/set-leader-keys ":" 'counsel-M-x)
(spacemacs/set-leader-keys "xe" 'set-buffer-file-coding-system)

;; ============================== my defun ==============================
;; =========== better defaults
(global-set-key (kbd "<f8>") 'zhanghe/show-current-buffer-major-mode)
(global-set-key [(shift return)] 'zhanghe/smart-open-line)
(global-set-key (kbd "C-M-\\") 'zhanghe/indent-region-or-buffer)
(global-set-key (kbd "M-r") 'zhanghe/mark-region-and-edit)
;; Utility functions
(defun bb/define-key (keymap &rest bindings)
  (declare (indent 1))
  (while bindings
    (define-key keymap (pop bindings) (pop bindings))))


(define-key evil-normal-state-map (kbd "-") nil)

(bb/define-key evil-normal-state-map
  "+" 'evil-numbers/inc-at-pt
  "-" 'evil-numbers/dec-at-pt
  "\\" 'evil-repeat-find-char-reverse
  (kbd "DEL") 'evil-repeat-find-char-reverse
  "[s" (lambda (n) (interactive "p") (dotimes (c n nil) (insert " ")))
  "]s" (lambda (n) (interactive "p")
         (forward-char) (dotimes (c n nil) (insert " ")) (backward-char (1+ n))))

(bb/define-key ivy-occur-grep-mode-map
  (kbd "C-d") 'evil-scroll-down
  "d" 'ivy-occur-delete-candidate)

(with-eval-after-load 'company
  (progn
    (bb/define-key company-active-map
      (kbd "C-w") 'evil-delete-backward-word)

    (bb/define-key company-active-map
      (kbd "s-w") 'company-show-location)))

(spacemacs/set-leader-keys "fR" 'zhanghe/rename-file-and-buffer)

;; ===========programming
(global-set-key (kbd "<f5>") 'zhanghe/run-current-file)
(spacemacs/set-leader-keys "oc" 'my-auto-update-tags-when-save)
(spacemacs/set-leader-keys "en" 'flycheck-next-error)
(spacemacs/set-leader-keys "ep" 'flycheck-previous-error)
(spacemacs/set-leader-keys "o(" 'ielm)


;; =========== misc
(global-set-key (kbd "<f1>") 'zhanghe/helm-hotspots)
(spacemacs/set-leader-keys "oo" 'zhanghe/helm-hotspots)
(spacemacs/set-leader-keys "ok" 'zhanghe/kill-other-persp-buffers)
(spacemacs/set-leader-keys "or" 'zhanghe/browser-refresh--chrome-applescript)
(spacemacs/set-leader-keys "gL" 'magit-log-buffer-file)
(spacemacs/set-leader-keys "gn" 'smerge-next)
(spacemacs/set-leader-keys "gp" 'smerge-prev)
(spacemacs/set-leader-keys "og" 'my-git-timemachine)

(when (spacemacs/system-is-mac)
  (spacemacs/set-leader-keys "o!" 'zhanghe/iterm-shell-command))

(bind-key* "s-;" 'zhanghe/insert-semicolon-at-the-end-of-this-line)
(bind-key* "C-s-;" 'zhanghe/delete-semicolon-at-the-end-of-this-line)
(bind-key* "s-," 'zhanghe/insert-comma-at-the-end-of-this-line)
(bind-key* "C-s-," 'zhanghe/delete-comma-at-the-end-of-this-line)
(bind-key* "C-c l" 'zhanghe/insert-chrome-current-tab-url)
(bind-key* "M--" 'zhanghe/goto-match-paren)
(spacemacs/set-leader-keys "sj" 'zhanghe/counsel-imenu)
(spacemacs/set-leader-keys "oll" 'zhanghe/load-my-layout)
(spacemacs/set-leader-keys "ols" 'zhanghe/save-my-layout)
;; highlight
(spacemacs/set-leader-keys "hh" 'zhanghe/highlight-dwim)
(spacemacs/set-leader-keys "hc" 'zhanghe/clear-highlight)
