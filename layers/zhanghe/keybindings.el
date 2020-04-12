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


;; A complementary binding to the apropos-command (C-h a)
(define-key 'help-command "A" 'apropos)
(define-key 'help-command (kbd "C-f") 'find-function)
(define-key 'help-command (kbd "C-k") 'find-function-on-key)
(define-key 'help-command (kbd "C-v") 'find-variable)
(define-key 'help-command (kbd "C-l") 'find-library)
(define-key 'help-command (kbd "C-i") 'info-display-manual)


;; ============================== packages remap
;; better defaults
;; hippie-expand, default kbd "M-s"
(global-set-key (kbd "s-/") 'hippie-expand)
(global-set-key [remap fill-paragraph] #'endless/fill-or-unfill)
(global-set-key (kbd "C-s-h") 'mark-defun)
(global-set-key (kbd "s-l") 'goto-line)
(global-set-key (kbd "C-c i e") 'spacemacs/auto-yasnippet-expand)
(global-set-key (kbd "C-`") 'toggle-input-method)

;; org
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "C-c b") 'org-iswitchb)
(global-set-key (kbd "<f9>") 'org-capture)
(global-set-key (kbd "C-c t") 'org-capture)

;; other
(global-set-key (kbd "C-c y") 'youdao-dictionary-search-at-point+)

;; misc
(bind-key* "s-r" 'mc/reverse-regions)



;; ============================== my defun
;; better defaults
(global-set-key (kbd "<f8>") 'zhanghe/show-current-buffer-major-mode)
(global-set-key [(shift return)] 'zhanghe/smart-open-line)
(global-set-key (kbd "C-M-\\") 'zhanghe/indent-region-or-buffer)
(global-set-key (kbd "M-r") 'zhanghe/mark-region-and-edit)

;; programming
(global-set-key (kbd "<f5>") 'zhanghe/run-current-file)







;; "http://endlessparentheses.com/transposing-keybinds-in-emacs.html?source=rss"
;; (global-set-key "\C-t" #'transpose-lines)
;; (define-key ctl-x-map "\C-t" #'transpose-chars)

(when (spacemacs/system-is-mac)
 (spacemacs/set-leader-keys "o!" 'zilongshanren/iterm-shell-command))

(spacemacs|add-toggle toggle-shadowsocks-proxy-mode
  :status shadowsocks-proxy-mode
  :on (global-shadowsocks-proxy-mode)
  :off (global-shadowsocks-proxy-mode -1)
  :documentation "Toggle shadowsocks proxy mode."
  :evil-leader "ots")

(global-set-key (kbd "s-s") 'save-buffer)
;; (bind-key* "s-k" 'scroll-other-window-down)
;; (bind-key* "s-j"  'scroll-other-window)
(bind-key* "C-c /" 'company-files)
;; (bind-key* "s-r" 'zilongshanren/browser-refresh--chrome-applescript)
(bind-key* "s-;" 'zilongshanren/insert-semicolon-at-the-end-of-this-line)
(bind-key* "C-s-;" 'zilongshanren/delete-semicolon-at-the-end-of-this-line)
(bind-key* "s-," 'zilongshanren/insert-comma-at-the-end-of-this-line)
;; (bind-key* "C-s-," 'zilongshanren/delete-comma-at-the-end-of-this-line)
(bind-key* "C-c l" 'zilongshanren/insert-chrome-current-tab-url)
(bind-key* "C-=" 'er/expand-region)
(bind-key* "M--" 'zilongshanren/goto-match-paren)
(bind-key* "C-c k" 'which-key-show-top-level)
(bind-key* "s-y" 'aya-expand)
(bind-key* "C-." 'zilongshanren/insert-space-after-point)
(bind-key* "M-i" 'string-inflection-java-style-cycle)
(bind-key* "M-u" 'dakra-upcase-dwim)
(bind-key* "M-l" 'dakra-downcase-dwim)
(bind-key* "M-c" 'dakra-capitalize-dwim)
;; (bind-key* "C-l" 'recenter)


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

(spacemacs/declare-prefix "ot" "Toggle")


(global-set-key (kbd "<f1>") 'zilongshanren/helm-hotspots)
(spacemacs/set-leader-keys "oo" 'zilongshanren/helm-hotspots)

(spacemacs/set-leader-keys "oc" 'my-auto-update-tags-when-save)
;; (spacemacs/set-leader-keys "op" 'zilongshanren/org-save-and-export)
(spacemacs/set-leader-keys "fR" 'zilongshanren/rename-file-and-buffer)

;;Must set key to nil to prevent error: Key sequence b m s starts with non-prefix key b m
(spacemacs/set-leader-keys "bm" nil)
(spacemacs/set-leader-keys "bD" 'spacemacs/kill-other-buffers)
(spacemacs/declare-prefix "bm" "Bookmark")
(spacemacs/set-leader-keys "bms" 'bookmark-set)
(spacemacs/set-leader-keys "bmr" 'bookmark-rename)
(spacemacs/set-leader-keys "bmd" 'bookmark-delete)
(spacemacs/set-leader-keys "bmj" 'counsel-bookmark)

(spacemacs/set-leader-keys "od" 'occur-dwim)
(spacemacs/set-leader-keys "ok" 'zilongshanren-kill-other-persp-buffers)
(spacemacs/set-leader-keys "ox" 'org-open-at-point-global)
(spacemacs/set-leader-keys "or" 'zilongshanren/browser-refresh--chrome-applescript)

(spacemacs/set-leader-keys "rh" 'helm-resume)
(spacemacs/set-leader-keys "sj" 'counsel-imenu)

(spacemacs/set-leader-keys-for-major-mode 'emacs-lisp-mode
  "gU" 'xref-find-references)
;; ivy specific keybindings
(if (configuration-layer/layer-usedp 'ivy)
    (progn
      (spacemacs/set-leader-keys "ff" 'counsel-find-file)
      (spacemacs/set-leader-keys "fL" 'counsel-locate)
      (spacemacs/set-leader-keys "hi" 'counsel-info-lookup-symbol)
      (spacemacs/set-leader-keys "pb" 'projectile-switch-to-buffer)))

(spacemacs/set-leader-keys "en" 'flycheck-next-error)
(spacemacs/set-leader-keys "ep" 'flycheck-previous-error)
(spacemacs/set-leader-keys "o(" 'ielm)

(spacemacs/set-leader-keys "gL" 'magit-log-buffer-file)
(spacemacs/set-leader-keys "gn" 'smerge-next)
(spacemacs/set-leader-keys "gp" 'smerge-prev)
(spacemacs/set-leader-keys "og" 'my-git-timemachine)

(spacemacs/set-leader-keys "sj" 'zilongshanren/counsel-imenu)
;; deal with BOM
(spacemacs/set-leader-keys "fl" 'find-file-literally-at-point)
(spacemacs/set-leader-keys "ri" 'ivy-resume)
(spacemacs/set-leader-keys "fh" 'ffap-hexl-mode)
(spacemacs/set-leader-keys "fd" 'projectile-find-file-dwim-other-window)
(spacemacs/set-leader-keys "nl" 'spacemacs/evil-search-clear-highlight)
(spacemacs/set-leader-keys "oll" 'zilongshanren/load-my-layout)
(spacemacs/set-leader-keys "ols" 'zilongshanren/save-my-layout)
(spacemacs/set-leader-keys "ob" 'popwin:display-last-buffer)
(spacemacs/set-leader-keys "oy" 'youdao-dictionary-search-at-point+)
(spacemacs/set-leader-keys "bM" 'spacemacs/switch-to-messages-buffer)
(spacemacs/set-leader-keys "sS" 'spacemacs/swiper-region-or-symbol)

(bind-key* "s-p" 'find-file-in-project)
(spacemacs/set-leader-keys "os" 'counsel-ag-thing-at-point)

(spacemacs/set-leader-keys "pa" 'projectile-find-other-file)
(spacemacs/set-leader-keys "pA" 'projectile-find-other-file-other-window)
(spacemacs/set-leader-keys ":" 'counsel-M-x)
(spacemacs/set-leader-keys "xe" 'set-buffer-file-coding-system)

;; highlight
(spacemacs/set-leader-keys "hh" 'zilongshanren/highlight-dwim)
(spacemacs/set-leader-keys "hc" 'zilongshanren/clearn-highlight)

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
