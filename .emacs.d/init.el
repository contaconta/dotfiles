; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-
;  these packages are requied: auto-complete, color-theme, anything
;; ------------------------------------------------------------------------
;; @ load-path

;; load-pathの追加関数
(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

;; load-pathに追加するフォルダ
;; 2つ以上フォルダを指定する場合の引数 => (add-to-load-path "elisp" "xxx" "xxx")
;(add-to-load-path "elisp")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; encode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(set-language-environment "Japanese")
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(prefer-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 基本キーバインド
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define-key global-map (kbd "C-h") 'delete-backward-char) ; 削除
(define-key global-map (kbd "M-?") 'help-for-help)        ; ヘルプ
(define-key global-map (kbd "C-z") 'undo)                 ; undo
(define-key global-map (kbd "C-x /") 'undo)               ; undo
(define-key global-map (kbd "C-c i") 'indent-region)      ; インデント
;(define-key global-map (kbd "C-c C-i") 'hippie-expand)   ; 補完
(define-key global-map (kbd "C-c ;") 'comment-dwim)       ; コメントアウト
(define-key global-map (kbd "C-c :") 'uncomment-region)   ; コメント解除
;(define-key global-map (kbd "C-o") 'toggle-input-method) ; 日本語入力切替
(define-key global-map (kbd "M-C-g") 'grep)               ; grep
(define-key global-map (kbd "C-m") 'newline-and-indent)
(define-key global-map (kbd "C-q") 'suspend-emacs) ; suspend

;; Stop Auto Backup
(setq make-backup-files nil)
(setq auto-save-default nil)

;; モードラインに行番号表示
(line-number-mode t)

;; モードラインに列番号表示
(column-number-mode t)

;; 行番号表示
(global-linum-mode t)
(set-face-attribute 'linum nil
       :foreground "#800"
       :height 0.9)

;; 行番号フォーマット
(setq linum-format "%4d| ")


;; 括弧の範囲内を強調表示
;(show-paren-mode t)
;(setq show-paren-delay 0)
;(setq show-paren-style 'expression)

;; 括弧の範囲色
;(set-face-background 'show-paren-match-face "#111")

;; 対応する括弧を光らせる
(show-paren-mode 1)

;(set-cursor-color "orange")
;(setq blink-cursor-interval 0.2)
;(setq blink-cursor-delay 1.0)
;(blink-cursor-mode 1)

;; 警告音を停止
(setq ring-bell-function 'ignore)

;; 補完で大文字小文字無視
(setq read-file-name-completion-ignore-case t)

;; タブをスペースで扱う
(setq-default indent-tabs-mode nil)

;; タブ幅
(custom-set-variables '(tab-width 4))

;; デフォルトの透明度を設定する
;(add-to-list 'default-frame-alist '(alpha . 80))

;; カレントウィンドウの透明度を変更する
;(set-frame-parameter nil 'alpha 80)

;; バッファ自動再読み込み
(global-auto-revert-mode 1)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; window-resizer
;;  http://d.hatena.ne.jp/mooz/20100119/p1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun window-resizer ()
  "Control window size and position."
  (interactive)
  (let ((window-obj (selected-window))
        (current-width (window-width))
        (current-height (window-height))
        (dx (if (= (nth 0 (window-edges)) 0) 1
              -1))
        (dy (if (= (nth 1 (window-edges)) 0) 1
              -1))
        c)
    (catch 'end-flag
      (while t
        (message "size[%dx%d]"
                 (window-width) (window-height))
        (setq c (read-char))
        (cond ((= c ?l)
               (enlarge-window-horizontally dx))
              ((= c ?h)
               (shrink-window-horizontally dx))
              ((= c ?j)
               (enlarge-window dy))
              ((= c ?k)
               (shrink-window dy))
              ;; otherwise
              (t
               (message "Quit")
               (throw 'end-flag t)))))))

;;
;; window-resizer は C-q C-r (resize) で
;(global-set-key "\C-x\C-r" 'window-resizer)

; (global-set-key "\C-xl" 'windmove-right)
; (global-set-key "\C-xh" 'windmove-left)
; (global-set-key "\C-xj" 'windmove-down)
; (global-set-key "\C-xk" 'windmove-up)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 画面を3分割する
;;  http://d.hatena.ne.jp/ground256/20110126/1296035198
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun split-window-vertically-n (num_wins)
  (interactive "p")
  (if (= num_wins 2)
      (split-window-vertically)
    (progn
      (split-window-vertically
       (- (window-height) (/ (window-height) num_wins)))
      (split-window-vertically-n (- num_wins 1)))))
(defun split-window-horizontally-n (num_wins)
  (interactive "p")
  (if (= num_wins 2)
      (split-window-horizontally)
    (progn
      (split-window-horizontally
       (- (window-width) (/ (window-width) num_wins)))
      (split-window-horizontally-n (- num_wins 1)))))
;; 
(global-set-key "\C-x@" '(lambda ()
                           (interactive)
                           (split-window-vertically-n 3)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; el-get
;;  https://github.com/dimitri/el-get
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil t)
  (url-retrieve
   "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
   (lambda (s)
     (goto-char (point-max))
     (eval-print-last-sexp))))

;; レシピ置き場
(add-to-list 'el-get-recipe-path
             (concat (file-name-directory load-file-name) "/el-get/recipes"))

(el-get 'sync)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; anything
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(el-get 'sync '(anything))

;; anythingの設定
(require 'anything-startup)
(global-set-key (kbd "C-x b") 'anything-for-files)
(global-set-key (kbd "M-y") 'anything-show-kill-ring)
(global-set-key (kbd "C-x C-f") 'anything-find-files)
(global-set-key (kbd "C-x M-x") 'anything-M-x)

(setq recentf-max-menu-items 10)        ;; 表示するファイルの数
(setq recentf-max-saved-items 30)       ;; 保存するファイルの数
(setq kill-ring-max 100)                ;; kill-ring で保存される最大値

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; auto-complete
;;  http://cx4a.org/software/auto-complete/manual.ja.html
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(el-get 'sync '(auto-complete))
(add-hook 'auto-complete-mode-hook
          (lambda ()
            ;(define-key ac-completing-map (kbd "C-n") 'ac-next)
            ;(define-key ac-completing-map (kbd "C-p") 'ac-previous)
            (define-key ac-menu-map (kbd "C-n") 'ac-next)
            (define-key ac-menu-map (kbd "C-p") 'ac-previous)
            (define-key ac-mode-map (kbd "M-/") 'auto-complete)))

;; auto-complete config
(require 'auto-complete-config)
;(ac-config-default)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp/auto-complete/ac-dict")
;(setq ac-auto-start nil)
(ac-set-trigger-key "TAB")
; (global-set-key "\M-/" 'ac-start)
(global-auto-complete-mode t)
(setq ac-use-menu-map t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; popup
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(el-get 'sync '(popup))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; color-theme
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(el-get 'sync '(color-theme))
(color-theme-initialize)
(color-theme-charcoal-black)

; for emacs24 or higher
(when (>= emacs-major-version 24)
  (el-get 'sync '(color-theme-solarized))
  (color-theme-solarized-dark))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; emacs-nav
;;  http://code.google.com/p/emacs-nav/
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(add-to-list 'load-path "~/.emacs.d/lisp/emacs-nav/")
;(require 'nav)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; powerline.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(el-get 'sync '(powerline-1.2))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; cc-mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq c-default-style "linux"
      c-basic-offset 4
      tab-width 4)

;; (add-to-list 'load-path "~/.emacs.d/lisp/emacs-clang-complete-async") 
;; (require 'auto-complete-clang-async)

;; (defun ac-cc-mode-setup ()
;;     (setq ac-clang-complete-executable "~/.emacs.d/clang-complete")
;;       (setq ac-sources '(ac-source-clang-async))
;;         (ac-clang-launch-completion-process)
;;         )

;; (defun my-ac-config ()
;;     (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
;;       (add-hook 'auto-complete-mode-hook 'ac-common-setup))

;; (my-ac-config)                          
