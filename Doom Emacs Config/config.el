;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Vivek Raj"
      user-mail-address "vivekraj27082005@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/Org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

(map! :leader
      :desc "Focus Right" "l" #'evil-window-right)

(map! :leader
      :desc "Focus Left" "h" #'evil-window-left)

(map! :leader
      :desc "Focus Up" "j" #'evil-window-up)

(map! :leader
      :desc "Focus Down" "k" #'evil-window-down)

(map! :leader
      :desc "Move Right" "L" #'+evil/window-move-right)

(map! :leader
      :desc "Move Left" "H" #'+evil/window-move-left)

(map! :leader
      :desc "Move Up" "J" #'+evil/window-move-up)

(map! :leader
      :desc "Move Down" "K" #'+evil/window-move-down)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(require 'company)
(setq company-idle-delay 0.2
      company-minimum-prefix-length 2)

(require 'neotree)
(map! :leader
      :desc "neotree"
      "f" #'neotree-toggle)

(defun my-lua-mode-company-init ()
  (setq-local company-backends '((company-lua
                                  company-etags
                                  company-dabbrev-code
                                  company-yasnippet))))
(add-hook 'lua-mode-hook #'my-lua-mode-company-init)

(require 'vterm)
(map! :leader
      :desc "Launching Terminal"
      "v" #'vterm)

(require 'mu4e)
(map! :leader
      :desc "Open Mail Client"
      "M" #'mu4e )
(map! :leader
      (:prefix ("d" . "dired")
       :desc "Open dired" "d" #'dired
       :desc "Dired jump to current" "j" #'dired-jump)
      (:after dired
       (:map dired-mode-map
        :desc "Peep-dired image previews" "d p" #'peep-dired
        :desc "Dired view file" "d v" #'dired-view-file)))
;; If peep-dired is enabled, you will get image previews as you go up/down with 'j' and 'k'
(evil-define-key 'normal peep-dired-mode-map
  (kbd "k") 'peep-dired-next-file
  (kbd "j") 'peep-dired-prev-file)
(add-hook 'peep-dired-hook 'evil-normalize-keymaps)
;; Get file icons in dired
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

(evil-define-key 'normal dired-mode-map
   (kbd "h") 'dired-up-directory
   (kbd "l") 'dired-open-file
   (kbd "<right>") 'dired-open-file
   (kbd "<left>") ' dired-up-directory
   (kbd "D") 'dired-delete-file
   (kbd "c") 'dired-copy-file
   (kbd "x") 'dired-move-to-filename
   (kbd "m") 'dired-mark
   (kbd "t") 'dired-toggle-marks)

(use-package mu4e
  :ensure nil
  ;; :load-path "/usr/share/emacs/site-lisp/mu4e/"
  ;; :defer 20 ; Wait until 20 seconds after startup
  :config

  ;; This is set to 't' to avoid mail syncing issues when using mbsync
  (setq mu4e-change-filenames-when-moving t)

  ;; Refresh mail using isync every 10 minutes
  (setq mu4e-get-mail-command "mbsync -c ~/.config/mu4e/mbsyncrc -a")
  (setq mu4e-root-maildir "~/Mail")

  (setq mu4e-drafts-folder "/[Gmail]/Drafts")
  (setq mu4e-sent-folder   "/[Gmail]/Sent Mail")
  (setq mu4e-refile-folder "/[Gmail]/All Mail")
  (setq mu4e-trash-folder  "/[Gmail]/Trash")

  (setq mu4e-maildir-shortcuts
      '(("/Inbox"             . ?i)
        ("/[Gmail]/Sent Mail" . ?s)
        ("/[Gmail]/Trash"     . ?t)
        ("/[Gmail]/Drafts"    . ?d)
        ("/[Gmail]/All Mail"  . ?a))))

(setq dired-open-extensions '(("gif" . "sxiv")
                              ("jpg" . "sxiv")
                              ("png" . "sxiv")
                              ("mkv" . "mpv")
                              ("mp4" . "mpv")))
(setq doom-font (font-spec :family "Ubuntu Mono" :size 14)
      doom-variable-pitch-font (font-spec :family "Ubuntu Mono" :size 14)
      doom-big-font (font-spec :family "Source Code Pro" :size 24))
