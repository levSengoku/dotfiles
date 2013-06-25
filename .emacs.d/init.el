;;; Utility
;;  文字コードを指定
( set-language-environment "Japanese" )
( prefer-coding-system 'utf-8 )

;; load-pathを追加する関数を定義
( defun add-to-load-path( &rest paths )
  ( let( path )
    ( dolist( paths paths paths )
      ( let(( default-directory
              ( expand-file-name( concat user-emacs-directory path ))))
        ( add-to-list 'load-path default-directory )
        ( if( fboundp 'normal-top-level-add-subdirs-to-load-path )
          ( normal-top-level-add-subdirs-to-load-path ))))))

;; 引数のディレクトリとそのサブディレクトリをload-pathに追加
( add-to-load-path "elisp" "conf" "public_repos" )

;; ELPAの設定
( when( require 'package nil t )
  ;; パッケージリポジトリにMarmaladeと開発者運営のELPAを追加
  ( add-to-list 'package-archives
                '( "marmalade" . "http://marmalade-repo.org/packages/" ))
  ( add-to-list 'package-archives
                '( "ELPA" . "http://tromey.com/elpa/" ))
  ;; インストールしたパッケージにロードパスを通して読み込む
  ( package-initialize ) )

;; anything
;; ( auto-instal-bathc "anything" )
( when( require 'anything nil t )
  ( setq
    ;; 候補を表示する迄の時間
    anything-idle-delay 0.3
    ;; タイプして再描写する迄の時間
    anything-input-idel-delay 0.2
    ;; 候補の最大表示数
    anything-candidate-number-limit 100
    ;; 候補が多い時に体感速度を速くする
    anything-quick-update t
    ;; 候補選択ショートカットをアルファベットに
    anything-enable-shortcuts 'alphabet)

    ( when( require 'anything-config nil t)
      ;; root権限でアクションを実行する時のコマンド
      ( setq anything-su-or-sudo "sudo"))

    ( require 'anything-match-plugin nil t)

    ( when( and( executable-find "cmigemo")
               ( require 'mibemo nil t))
          ( require 'anything-migemo nil t))

    ( when( require 'anything-complete nil t )
      ;; lispシンボルの補完候補の再検索時間
      ( anything-lisp-complete-symbol-set-timer 150 ))

    ( require 'anything-show-completion nil t )

    ( when( require 'auto-install nil t )
      ( require 'anything-auto-install nil t ))

    ( when( require 'descbinds-anything nil t )
      ;; describe-bindingsをAnythingに置き換える
      ( descbinds-anything-install)))
  
;; バックアップとオートセーブファイルの作成ディレクトリを変更
( add-to-list 'backup-directory-alist
              ( cons "." "~/.emacs.d/backups/"))
( setq auto-save-file-name-transforms
       `(( ".*" ,( expand-file-name "~/.emacs.d/backups/") t )))

;; Elisp関数、変数の情報をエコーエリアに表示
( add-hook 'emacs-lisp-mode-hook
           '( lambda ()
                ( when( require 'eldoc nil t )
                     ( setq eldoc-idle-delay 0.2 )
                     ( setq eldoc-echo-area-use-moltiline-p t )
                     ( turn-on-eldoc-mode ))))

;; auto-installを有効にする
( when ( require 'auto-install nil t )
  ;; installDirを設定する
  ( setq auto-install-directory "~/.emacs.d/elisp/" )
  ;; EmacsWikiに登録されているelispの名前を取得する
  ( auto-install-update-emacswiki-package-name t )
  ;; 必要であればproxyの設定を行う 
  ;;  ( setq url-proxy-services '(( "http" . "localhost:8339" )))
  ( auto-install-compatibility-setup ) )

;; オートセーブの間隔を変更する
;;( setq auto-save-timeout 15 )
;;( setq auto-save-interval 60 )

;; カラーテーマの読み込み
( when( require 'color-theme nil t )
  ( color-theme-initialize ) )

;;タイトルバーにファイルのフルパスを表示
( setq frame-title-format "%f" )

;; ファイルサイズを表示
( size-indication-mode t )

;; カラム番号を表示
( column-number-mode t )

;; 行番号を常に表示
( global-linum-mode t )
( setq linum-format "%03d  ")

;; 現在行のハイライト
( defface my-hl-line-face
  '(((( class color )( background dark ))
     ( :background "NavyBlue" t ))
    ( t ( :bold t )))
    "hl-line's my face" )
;;( setq hl-line-face 'my-hl-line-face )
;;( global-hl-line-mode t )

;; 対応する括弧のハイライト
( setq show-paren-delay 0 )
( show-paren-mode t )
( setq show-paren-style 'expression )
;;( set-face-background 'show-paren-match-face "Yellow" )
;;( set-face-underline-p 'show-paren-match-face "Yellow")

;; インデントにタブ文字を使用しない
( setq-default indent-tabs-mode nil )

;; タブ文字の表示幅
( setq-default tab-width 2 )

;;; SHORT-CUT
;; 改行と同時にインデントする
( global-set-key( kbd "C-m" ) 'newline-and-indent )

;; auto-completeの設定
( when( require 'auto-complete-config nil t )
  ( add-to-list 'ac-dictionary-directories
    "~/.emacs.d/elisp/ac-dict")
  ( define-key ac-mode-map( kbd "M-TAB" ) 'auto-complete )
  ( ac-config-default ))

;; 要color-moccur.el
( when( require 'anything-c-moccur nil t )
  ( setq
    ;; anything-c-moccur用 `anything-idle-delay'
    anything-c-moccur-anything-idle-delay 0.1
    ;; バッファの情報をハイライトする
    anything-c-moccur-highlight-info-line-flag t
    ;; 現在選択中の候補の位置を他のウィンドウに表示する
    anything-c-moccur-enable-auto-look-flag t
    ;; 起動時にポイントの位置の単語を初期パターンにする
    anything-c-moccur-enable-initial-pattern t )
  ;; C-M-oにanything-c-moccur-occur-by-moccurを割り当てる
  ( global-set-key ( kbd "C-M-o") 'anything-cmoccur-occur-by-moccur ))

;; バッファウィンドウの立て幅を調整
( global-set-key( kbd "M-d") 'shrink-window )
( global-set-key( kbd "M-u") 'enlarge-window )
;;( global-set-key( kbd "M-") 'shrink-window-verticaly )
;;( global-set-key( kbd "M-") 'shrink-window-verticaly )

;; redo機能を追加 ( http://www.emacswiki.org/emacs/download/redo+.el )
( when( require 'redo+ nil t )
  ( global-set-key ( kbd "C-'" ) 'redo ))

;; M-yにanything-show-kill-ringを割当
( define-key global-map ( kbd "M-y" ) 'anything-show-kill-ring )