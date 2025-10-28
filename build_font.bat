@echo off
chcp 65001 > NUL

echo 出力エラーが起きる場合、手動で npm install を実行してください。

REM --- ユーザーにフォルダ名の入力を求める ---
echo.
SET /P FONT_NAME="処理するフォルダ名 (rounded など) を入力して Enter を押してください: "

REM --- 入力が空の場合はエラーメッセージを表示 ---
IF "%FONT_NAME%"=="" (
    echo.
    echo エラー: フォルダ名が入力されませんでした。処理を中断します。
)

REM --- ビルド処理を実行 ---
IF NOT "%FONT_NAME%"=="" (
    echo.
    echo --- フォント [%FONT_NAME%] のビルドを開始します ---

    echo [1/3] fix_glyphs.js を実行中 (入力: %FONT_NAME%)
    node fix_glyphs.js %FONT_NAME%

    echo [2/3] fix_size.js を実行中 (対象: %FONT_NAME%\fixed)
    node fix_size.js %FONT_NAME%\fixed

    echo [3/3] to_font.js を実行中 (出力: %FONT_NAME%, 入力: %FONT_NAME%\fixed)
    node to_font.js %FONT_NAME% %FONT_NAME%\fixed

    echo.
    echo --- ビルド完了: fonts\%FONT_NAME% にファイルが作成されました ---
)

echo.
echo 処理が終了しました。
pause