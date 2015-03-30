(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(indent-tabs-mode nil)
 '(inhibit-startup-buffer-menu t)
 '(inhibit-startup-screen t)
 '(initial-scratch-message "")
 '(menu-bar-mode nil)
 '(mouse-wheel-mode nil)
 '(require-final-newline t)
 '(scheme-program-name "racket")
 '(sentence-end-double-space nil)
 '(tab-width 4)
 '(tool-bar-mode t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(hl-line ((t (:background "Dark Blue")))))  ;;"#0073CF"


;; autopair
(add-to-list 'load-path ".emacs.d/autopair-0.4")
(require 'autopair)
(autopair-global-mode)

;; interactively do
(require 'ido)
(ido-mode t)

;; auto-complete
(add-to-list 'load-path ".emacs.d/auto-complete-1.3.1")
(require 'auto-complete)
(add-to-list 'ac-dictionary-directories "~/emacs.d/ac-dict")
(require 'auto-complete-config)
(ac-config-default)
(global-auto-complete-mode t)
(setq ac-delay 0.5)

;; remove line wrap character
(set-display-table-slot standard-display-table 'wrap ?\ )

;; show line/column numbers
(setq line-number-mode t)
(setq column-number-mode t)

;; pretty-greek
(defun pretty-greek ()
  (let ((greek '("alpha" "beta" "gamma" "delta" "epsilon" "zeta" "eta" "theta" "iota" "kappa" "lambda" "mu" "nu" "xi" "omicron" "pi" "rho" "sigma_final" "sigma" "tau" "upsilon" "phi" "chi" "psi" "omega")))
    (loop for word in greek
          for code = 97 then (+ 1 code)
          do  (let ((greek-char (make-char 'greek-iso8859-7 code)))
                (font-lock-add-keywords nil
                                        `((,(concatenate 'string "\\(^\\|[^a-zA-Z0-9]\\)\\(" word "\\)[a-zA-Z]")
                                           (0 (progn (decompose-region (match-beginning 2) (match-end 2))
                                                     nil)))))
                (font-lock-add-keywords nil
                                        `((,(concatenate 'string "\\(^\\|[^a-zA-Z0-9]\\)\\(" word "\\)[^a-zA-Z]")
                                           (0 (progn (compose-region (match-beginning 2) (match-end 2)
                                                                     ,greek-char)
                                                     nil)))))))))


(add-hook 'prog-mode-hook 'pretty-greek) ; emacs24 specific

(put 'narrow-to-region 'disabled nil)
(global-hl-line-mode 1)

;; comment current line
;; Original idea from
;; http://www.opensubscriber.com/message/emacs-devel@gnu.org/10971693.html
(defun comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
        If no region is selected and current line is not blank and we are not at the end of the line,
        then comment current line.
        Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))
(global-set-key "\M-;" 'comment-dwim-line)

;; ;; delete selection mode (replace selected stuff when typing)
;; (delete-selection-mode 1)

(defun comment-keywords ()
  (font-lock-add-keywords nil
                          '(("\\(\\(FIXME\\|TODO\\|BUG\\|\\?\\?\\|NOTE\\)\\:\\)" 1 font-lock-warning-face t))))
;; (FIXME|TODO|BUG|??)
;; "\\(FIXME\\|TODO\\|BUG\\|\\?\\?\\)\\:"

;; FIXME: fixme
;; TODO: todo
;; BUG: bug
;; ??: ??
;; foo: foo

(add-hook 'prog-mode-hook 'comment-keywords)


;; color theme
(add-to-list 'load-path ".emacs.d/color-theme-6.6.0")
(require 'color-theme)
(color-theme-initialize)

;; color-theme-empty-void.el
(defun color-theme-empty-void ()
  "The Empty Void color theme, by mtvoid (based on sunburst)"
  (interactive)
  (color-theme-install
   '(color-theme-empty-void
     ( (background-color . "black") ; commented out because I like transparency
      (background-mode . dark)
      (border-color . "gray20")
      (cursor-color . "yellow")
      (foreground-color . "white smoke")
      (mouse-color . "sienna1"))
     (default ((t nil)))
     (bold ((t (:bold t))))
     (bold-italic ((t (:bold t :slant italic))))
     (diary ((t (:foreground "tomato"))))
     (font-lock-builtin-face ((t (:foreground "#dd7b3b"))))
     (font-lock-comment-face ((t (:foreground "#999"))))
     (font-lock-comment-delimiter-face ((t (:foreground "#e44"))))
     (font-lock-constant-face ((t (:foreground "#99cf50"))))
     (font-lock-doc-face ((t (:foreground "#9b859d"))))
     (font-lock-function-name-face ((t (:foreground "#e9c062" :bold t))))
     (font-lock-keyword-face ((t (:foreground "#cf6a4c" :bold t))))
     (font-lock-preprocessor-face ((t (:foreground "#aeaeae"))))
     (font-lock-string-face ((t (:foreground "#65b042"))))
     (font-lock-type-face ((t (:foreground "#c5af75"))))
     (font-lock-variable-name-face ((t (:foreground "#3387cc"))))
     (font-lock-warning-face ((t (:bold t :background "#420e09" :foreground "#eeeeee"))))
     (fringe ((t (:background "gray4"))))
     (erc-current-nick-face ((t (:foreground "#aeaeae"))))
     (erc-default-face ((t (:foreground "#ddd"))))
     (erc-keyword-face ((t (:foreground "#cf6a4c"))))
     (erc-notice-face ((t (:foreground "#666"))))
     (erc-timestamp-face ((t (:foreground "#65b042"))))
     (erc-underline-face ((t (:foreground "c5af75"))))
     (highlight-current-line-face ((t (:background "gray10"))))
     (minibuffer-prompt ((t (:foreground "orange red"))))
     (nxml-attribute-local-name-face ((t (:foreground "#3387cc"))))
     (nxml-attribute-colon-face ((t (:foreground "#e28964"))))
     (nxml-attribute-prefix-face ((t (:foreground "#cf6a4c"))))
     (nxml-attribute-value-face ((t (:foreground "#65b042"))))
     (nxml-attribute-value-delimiter-face ((t (:foreground "#99cf50"))))
     (nxml-namespace-attribute-prefix-face ((t (:foreground "#9b859d"))))
     (nxml-comment-content-face ((t (:foreground "#666"))))
     (nxml-comment-delimiter-face ((t (:foreground "#333"))))
     (nxml-element-local-name-face ((t (:foreground "#e9c062"))))
     (nxml-markup-declaration-delimiter-face ((t (:foreground "#aeaeae"))))
     (nxml-namespace-attribute-xmlns-face ((t (:foreground "#8b98ab"))))
     (nxml-prolog-keyword-face ((t (:foreground "#c5af75"))))
     (nxml-prolog-literal-content-face ((t (:foreground "#dad085"))))
     (nxml-tag-delimiter-face ((t (:foreground "#cda869"))))
     (nxml-tag-slash-face ((t (:foreground "#cda869"))))
     (nxml-text-face ((t (:foreground "#ddd"))))
     (gui-element ((t (:background "#0e2231" :foreground "black"))))
     (highlight ((t (:background "gray10"))))
     (highline-face ((t (:background "#4a410d"))))
     (italic ((t (:slant italic))))
     (left-margin ((t (nil))))
     (mmm-default-submode-face ((t (:background "#111"))))
     (mode-line ((t (:background "gray5" :foreground "gray" :box '(:width 1 :style nil)))))
     (mode-line-buffer-id ((t (:background "gray5" :foreground "gray"))))
     (mode-line-highlight ((t (:box '(:width 1 :style nil)))))
     (mode-line-inactive ((t (:background "gray5" :foreground "gray40"))))
     (primary-selection ((t (:background "#222"))))
     (region ((t (:background "midnight blue" :foreground "#878700"))))
     (text-cursor ((t (:background "yellow" :foreground "black"))))
     (tool-bar ((t (:background "gray75" :foreground "black" :box (:line-width 1 :style released-button)))))
     (tooltip ((t (:background "gray5" :foreground "white"))))
     (underline ((nil (:underline t)))))))

(color-theme-empty-void)



;; highlight matching parens
(require 'paren)
(defun lispy-parens ()
  "Setup parens display for lisp modes"
  (setq show-paren-delay 0)
  (setq show-paren-style 'parenthesis)
  (make-variable-buffer-local 'show-paren-mode)
  (show-paren-mode 1)
  (set-face-attribute 'show-paren-match-face nil :foreground "orange")
  (set-face-attribute 'show-paren-match-face nil :background "black")
  (set-face-attribute 'show-paren-match-face nil :weight 'bold))

(add-hook 'emacs-lisp-mode-hook 'lispy-parens)
(add-hook 'scheme-mode-hook 'lispy-parens)
(add-hook 'prog-mode-hook 'lispy-parens)


;; Missing things from scheme IDE
(defun scheme-send-buffer ()
  (interactive)
  (let ((oldbuf (current-buffer)))
    (run-scheme scheme-program-name)
    (switch-to-buffer oldbuf)
    (scheme-send-region (point-min) (point-max))))

(defun scheme-send-buffer-and-go ()
  (interactive)
  (let ((oldbuf (current-buffer)))
    (if (= (length (window-list)) 1)
        (split-window-right))
    (other-window 1)
    (run-scheme scheme-program-name)
    (other-window -1))
  (scheme-send-region (point-min) (point-max)))

(eval-after-load 'scheme
  '(define-key scheme-mode-map (kbd "C-c C-s") 'scheme-send-buffer))


;; php-mode
(add-to-list 'load-path ".emacs.d/php-mode-1.13")
(require 'php-mode)

;; web-mode
(add-to-list 'load-path ".emacs.d/web-mode")
(require 'web-mode)

;; markdown-mode
;;(add-to-list 'load-path ".emacs.d/markdown-mode-2.0")
;;(require 'markdown-mode)
;;(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; lua-mode
(add-to-list 'load-path ".emacs.d/lua-mode-28155ba")
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

;; linum-mode
;;(add-hook 'prog-mode-hook (lambda () (linum-mode 1)))
;;(unless window-system
;;  (add-hook 'linum-before-numbering-hook
;;            (lambda ()
;;             (setq-local linum-format-fmt
;;                          (let ((w (length (number-to-string
;;                                            (count-lines (point-min) (point-max))))))
;;                            (concat "%" (number-to-string w) "d"))))))

(defun linum-format-func (line)
  (concat
   (propertize (format linum-format-fmt line) 'face 'linum)
   (propertize " " 'face 'linum)))

(unless window-system
  (setq linum-format 'linum-format-func))

;; delete trailing whitespace on save
(add-hook 'prog-mode-hook (lambda () (add-to-list 'write-file-functions 'delete-trailing-whitespace)))


;; jinja2-mode
(add-to-list 'load-path ".emacs.d/jinja2-mode")
(require 'jinja2-mode)

;;(global-linum-mode)

(setq user-mail-address "jtwright@mit.edu")
(put 'upcase-region 'disabled nil)

;;screw autosaving
;; (setq make-backup-files nil)
