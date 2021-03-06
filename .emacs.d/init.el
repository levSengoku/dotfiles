;;;===================================================================
;;; utility
;;;===================================================================

;;  文字コードを指定
( set-language-environment "JAPANESE" )
( prefer-coding-system 'utf-8 )

;;;===================================================================
;;; load-path
;;;===================================================================

;; load-pathを追加する関数を定義
( defun add-to-load-path ( &rest paths )
  ( let ( path )
    ( dolist ( path paths paths )
      ( let (( default-directory
              ( expand-file-name ( concat user-emacs-directory path ))))
        ( add-to-list 'load-path default-directory )
        ( if ( fboundp 'normal-top-level-add-subdirs-to-load-path )
          ( normal-top-level-add-subdirs-to-load-path ))))))

;; 引数のディレクトリとそのサブディレクトリをload-pathに追加
( add-to-load-path "elisp" "conf" "public_repos" )

;;;===================================================================
;;; ELPA
;;;===================================================================

;; ELPAの設定
( when( require 'package nil t )
  ;; パッケージリポジトリにMARMALADEと開発者運営のELPAを追加
  ( add-to-list 'package-archives
                '( "marmalade" . "http://marmalade-repo.org/packages/" ))
  ( add-to-list 'package-archives
                '( "ELPA" . "http://tromey.com/elpa/" ))
  ;; インストールしたパッケージにロードパスを通して読み込む
  ( package-initialize ))

;;;==================================================================
;;; anything
;;;==================================================================

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
               ( require 'migemo nil t))
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

;;;================================================================
;;; auto-install
;;;================================================================

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
;;( setq atuo-save-timeout 15 )
;;( setq auto-save-interval 60 )

;;;================================================================
;;; auto-byte-compile
;;;================================================================

( require 'auto-async-byte-compile )

;; 自動バイトコンパイルを無効にするファイル名の正規表現
( setq auto-async-byte-compile-exclude-files-regexp "/junk/" )
( add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode )

;;;================================================================
;;; display
;;;================================================================

;; カラーテーマの読み込み
( when( require 'color-theme nil t )
  ( color-theme-initialize ) )

;; ファイルサイズを表示
( size-indication-mode t )

;; 桁番号を表示
( line-number-mode t )

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

;; wgrepの設定
( require 'wgrep nil t )

;;;================================================================
;;; undo
;;;================================================================

;; undo-treeの設定
( when( require 'undo-tree nil t )
  ( global-undo-tree-mode) )

;; point-undoの設定
( when( require 'point-undo nil t )
  ( define-key global-map ( kbd "M-[") 'point-undo )
  ( define-key global-map ( kbd "M-]") 'point-redo ))

;;;================================================================
;;; tabbar
;;;================================================================

;; tabbar http://www.emacswiki.org/emacs/download/tabbar.el
( require 'tabbar )
( tabbar-mode 1 )

;; タブ上でマウスホイール操作無効
( tabbar-mwheel-mode -1 )

;; グループ化しない
( setq tabbar-buffer-groups-function nil )

;; 左に表示されるボタンを無効化
( dolist ( btn '( tabbar-buffer-home-button
                  tabbar-scroll-left-button
                  tabbar-scroll-right-button ))
  ( set btn ( cons( cons "" nil)
                  ( cons "" nil ))))

;; タブの長さ
( setq tabbar-separator '(1.5))

;; 外観変更
( set-face-attribute
  'tabbar-unselected nil
  :background "black"
  :foreground "grey72"
  :box nil )
( set-face-attribute
  'tabbar-selected nil
  :background "black"
  :foreground "yellow"
  :box nil )
( set-face-attribute
  'tabbar-button nil
  :box nil )
( set-face-attribute
  'tabbar-separator nil
  :height 1.5 )

;; タブに表示させるバッファの設定
( defvar my-tabbar-displayed-buffers
  '( "*scratch*" "*Messages*" " *Backtrace*" "$Colors*" "*Faces*" "*vc-")
     "*Regexps matches buffer names always included tabs." )
( defun my-tabbar-buffer-list ()
   "Return the list of buffers to show in tabs.
    Exclude buffers whose name starts with a space of an asterisk.
    The current buffer and buffers matches `my-tabbar-displayed-buffers'
    are always included."
   ( let* ( ( hides( list ?\ ?\* ))
            ( re( regexp-opt my-tabbar-displayed-buffers ))
            ( cur-buf( current-buffer ))
            ( tabs( delq nil
                         ( mapcar( lambda( buf )
                                   ( let( ( name( buffer-name buf )))
                                     ( when( or( string-match re name )
                                               ( not ( memq( aref name 0 ) hides)))
                                       buf)))
                                 ( buffer-list )))))

     ;; Always include the current buffer.
     ( if( memq cur-buf tabs )
         tabs
       ( cons cur-buf tabs))))

;; Chromeライクなタブ切り替えのキーバインド
( global-set-key ( kbd "<M-s-right>" ) 'tabbar-forward-tab )
( global-set-key ( kbd "<M-s-left>" ) 'tabbar-backward-tab )

;;;==================================================================
;;; howm
;;;==================================================================

;; howmメモ保存の場所
( setq howm-directory( concat user-emacs-directory "howm" ))

;; howm-menuの言語を日本語に
;; ( setq howm-menu-lang 'ja )

;; howmメモを１日１ファイルにする
; ( setq howm-file-name-format "%Y/%m/%Y-%m-%d.howm" )

;; howm-modeを読み込む
( when( require 'howm-mode nil t )
  ;; C-c,,で起動
  ( define-key global-map ( kbd "C-c ,," ) 'howm-menu ))

;; howmを保存と同時に閉じる
( defun howm-save-guffer-and-kill ()
  ( interactive )
  ( when( and( buffer-file-name )
             ( string-match " \\.howm" ( buffer-file-name )))
    ( save-buffer)
    ( kill-buffer nil )))

;; C-c C-cでメモの保存と同時にバッファを閉じる
( define-key howm-mode-map ( kbd "C-c C-c" ) 'howm-save-buffer-and-kill )

;;;==================================================================
;;; cua-mode
;;;==================================================================

;; cua-modeの設定 矩形編集モードのみ利用する
( cua-mode t )
( setq cua-enable-cua-keys nil )
( global-set-key ( kbd "C-@") 'cua-set-rectangle-mark )

;;;==================================================================
;;; mode
;;;==================================================================

;; cssm_modeの基本設定
( defun css-mode-hooks ()
  "css-mode hooks"
  ;; インデントをCスタイルにする
  ( setq cssm-indent-function #'cssm-c-style-indenter)
  ;; インデント幅を２にする
  ( setq cssm-indent-level 2 )
  ;; インデントにタブ文字を使わない
  ( setq-default indent-tabs-mode nil )
  ;; 閉じ括弧の前に改行を挿入する
  ( setq cssm-newline-before-closing-bracket t))

( add-hook 'css-mode-hook 'css-mode-hooks )

;; js-modeの基本設定
( defun js-indent-hook ()
  ;; インデント幅を２にする
  ( setq js-indent-level 2
         js-expr-indent-offset 2
         indent-tabs-mode nil )
  ;; switch分のcaseラベルをインデントする
  ( defun my-js-indent-line ()
    ( interactive )
    ( let* ( ( parse-status( save-excursion( syntax-ppss( point-at-bol ))))
             ( offset( - ( current-column ) ( current-indentation )))
             ( indentation( js--proper-indentation parse-status )))
           ( back-to-indentation )
           ( if( looking-at "case\\s-")
               ( indent-line-to ( + indentation 2 ))
             ( js-indent-line ))
           ( when( > offset 0 ) ( forward-char offset ))))
      ;; caseラベルのインデント処理をセットする
      ( set( make-local-variable 'indent-line-funcion) 'my-js-indent-line )
      ;; ここ迄caseラベルを調整する設定
      )
    ;; js-modeの起動時にhookを追加
    ( add-hook 'js-mode-hook 'js-indent-hook )
    ( add-to-list 'auto-mode-alist '( "\\.js$" . js2-mode ))
    ( add-hook 'js2-mode-hook 'js-indent-hook )

;; php-modeの基本設定
( when( require 'php-mode nil t )
  ( add-to-list 'auto-mode-alist '( "\\.ctp\\'" . php-mode ))
  ( setq php-search-url "http://jp.php.net/")
  ( setq php-manual-url "http://jp.net/manual/"))

;; php-modeのインデント設定
( defun php-indent-hook ()
  ( setq indent-tabs-mode nil )
  ( setq c-basic-offset 4 )
  ( c-set-offset 'case-label '+ )
  ( c-set-offset 'arglist-intro '+ )
  ( c-set-offset 'arglist-close  0))

;; php-modeの補完を強化する(install-elisp-from-emacswiki)
( defun php-completion-hook ()
  ( when( require 'php-completion nil t )
    ( php-completion-mode t )
    ( define-key php-mode-map ( kbd "C-o" ) 'phpcmp-complete )
    ( when( require 'auto-complete nil t )
    ( make-variable-frame-local 'ac-sources )
    ( add-to-list 'ac-sources 'ac-source-php-completion )
    ( auto-complete-mode t ))))
( add-hook 'php-mode-hook 'php-completion-hook )

;;;===============================================================
;;; flymake
;;;===============================================================

;; HTML用Flymakeの設定
;;(defun flymake-html-init ()
;;    ( let* (( temp-file ( flymake-init-create-temp-buffer-copy
;;                       'flymake-create-temp-inplace ))
;;             ( local-file  ( file-relative-name
;;                         temp-file
;;                         ( file-name-directory buffer-file-name ))))
;;          ( list "tidy" ( list local-file ))))

;;( add-to-list 'flymake-allowed-file-name-masks
;;                          '( "\\.html$\\|\\.ctp" flymake-html-init ))

;; Tidy error pattern
;;( add-to-list 'flymake-err-line-patterns
;;'("line \\([0-9]+\\) column \\([0-9]+\\) - \\(Warning\\/Error\\): \\(.*\\)"
;;  nil 1 2 4 ))

;;;; JS用Flymakeの初期化関数の定義
;; defun flymake-jsl-init ()
;; ( list "jsl" ( list "-process" ( flymake-init-create-temp-buffer-copy
;;                                  'flymake-create-temp-inplace ))))
;;; JS編集でFlymakeを起動する
;; add-to-list 'flymake-allowed-file-name-masks
;;             '( "\\.js\\'" flymake-jsl-init ))
;; add-to-list 'flymake-err-line-patterns
;;( "^\\(.+\\)(\\([0-9]+\\)): \\(.*warning\\|SyntaxError\\): \\(.*\\)"
;;  1 2 nil 4 ))

;;;==================================================================
;;; gtags
;;;==================================================================

;; gtags-modeのキーバインドを有効化する
( setq gtags-suggested-key-mapping t )
( require 'gtags nil t )

;; ctags.elの設定
( require 'ctags nil t )
( setq tags-revert-without-query t )

;; ctagsを呼び出すコマンドライン。
( setq ctags-command "ctags -e -R" )
( setq ctags-command "ctags -R --fields=\"+afikklmnsSzt\" ")
( global-set-key ( kbd "<f5>" ) 'ctags-create-or-update-tags-table )

;; AnythingからTAGSを利用しやすくするコマンド作成
( when ( and ( require 'anything-exuberant-ctags nil t )
             ( require 'anything-gtags nil t ))
  ;; anything-for-tags用のソースを定義
  ( setq anything-for-tags
         ( list anything-c-source-gtags-select
                anything-c-source-etags-select
                anything-c-source-exuberant-ctags-select
                ))
  ;; anything-for-tagsコマンドを作成
  ( defun anything-for-tags ()
    "Preconfigured `anything' for anything-for-tags."
    ( inter active )
    ( anything anything-fot-tags
               ( thing-at-point 'symbol )
               nil nil nil "*anything for tags*"))
  ;; M-tにanything-for-tagsを割当
  ( define-key global-map ( kbd "M-t" ) 'anything-for-tags ))

;;;===============================================================
;;; short-cut
;;;===============================================================

;; 改行と同時にインデントする
( global-set-key ( kbd "C-m" ) 'newline-and-indent )

;; auto-completeの設定
( when ( require 'auto-complete-config nil t )
  ( add-to-list 'ac-dictionary-directories
    "~/.emacs.d/elisp/ac-dict")
  ( define-key ac-mode-map ( kbd "M-TAB" ) 'auto-complete )
  ( ac-config-default ))

;; C-kで行全体を削除
( defun kill-whole-line ()
  ( interactive )
  ( beginning-of-line )
  ( kill-line 1 ))
( global-set-key ( kbd "C-k" ) 'kill-whole-line )

;;;==================================================================
;;; moccur
;;;==================================================================

;; color-moccurの設定
( when ( require 'color-moccur nil t )
  ;; M-oにoccur-by-moccurを割当
  ( define-key global-map ( kbd "M-o" ) 'occur-by-moccur )
  ;; スペース区切りでAND検索
  ( setq moccur-split-word t )
  ;; ディレクトリ検索のとき除外するファイル
  ( add-to-list 'dmoccur-exclusion-mask "\\.DS_Store" )
  ( add-to-list 'dmoccur-exclusion-mask "^#.+#$")
  ;; Migemoを利用できる環境であれば使用する
  ( when ( and( executable-find "cmigemo")
              ( Require 'migemo nil t ))
    ( setq moccur-use-migemo t )))

;; 要Color-moccur.el
( when ( require 'anything-c-moccur nil t )
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

;; 要color-moccur.el
( require 'moccur-edit nil t )

;; moccur-edit-finish-editと同時にファイルを保存する
( defadvice moccur-edit-change-file
  ( after save-after-moccur-edit-buffer activate )
  ( save-buffer ) )

;;;==================================================================
;;; window
;;;==================================================================

;; バッファウィンドウの立て幅を調整
( global-set-key ( kbd "M-d") 'shrink-window )
( global-set-key ( kbd "M-u") 'enlarge-window )
;;( global-set-key ( kbd "M-") 'shrink-window-verticaly )
;;( global-set-key ( kbd "M-") 'shrink-window-verticaly )

;; redo機能を追加 ( http://www.emacswiki.org/emacs/download/redo+.el )
( when( require 'redo+ nil t )
  ( global-set-key ( kbd "C-'" ) 'redo ))

;; M-YにANYTHING-SHOW-KILL-ringを割当
( define-key global-map ( kbd "M-y" ) 'anything-show-kill-ring )

;; M-x dtwをdelete-trailing-whitespaceのエイリアスに
( defalias 'dtw 'delete-trailing-whitespace )

;;;==================================================================
;;; emoji
;;;==================================================================

( require 'emoji nil t )

;;;==================================================================
;;; diff
;;;==================================================================

;; ediffコントロールパネルを別フレームにしない
( setq ediff-window-setup-function 'ediff-setup-windows-plain )

;;;==================================================================
;;; psvn
;;;==================================================================

( when ( executable-find "svn" )
  ( setq svn-status-verbose nil )
  ( autoload 'svn-status "psvn" "Run `svn status'." t ))

;;;==================================================================
;;; egg
;;;==================================================================

( when ( executable-find "git" )
  ( require 'egg nil t ))

;;;==================================================================
;;; multi-term
;;;==================================================================

( when ( require 'multi-term nil t  )
  ( setq multi-term-program "/usr/bin/zsh" ))

;;;==================================================================
;;; tramp
;;;==================================================================

( add-to-list 'backup-directory-alist
              ( cons tramp-file-name-regexp nil ))

;;;==================================================================
;;; WoMan
;;;==================================================================

;; キャッシュを作成
( setq woman-chache-filename "~/.emacs.d/.wmncach.el" )

;; manパスを設定
( setq woman-manpath '( "/usr/share/man"
                        "/usr/local/share/man"
                        "/usr/local/share/man/ja" ))

;; anything-for-document用のソースを定義
( setq anything-for-document-sources
       ( list anything-c-source-man-pages
              anything-c-source-info-cl
              anything-c-source-info-pages
              anything-c-source-info-elisp
              anything-c-source-apropos-emacs-commands
              anything-c-source-apropos-emacs-functions
              anything-c-source-apropos-emacs-variables ))

;; anything-for-documentコマンドを作成
( defun anything-for-document ()
  "Preconfigured `anything' for anything-for-document."
  ( interactinve )
  ( anything anything-for-document-sources
             ( thing-at-point 'symbol ) nil nil nil
             "*anything for document*" ))

;; C+dにanything-for-ducumentを割当
( define-key global-map ( kbd "C-d" ) 'anything-for-document )

;; 
