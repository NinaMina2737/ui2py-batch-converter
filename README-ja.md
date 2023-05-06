# ui2py-batch-converter

[English](README.md)

`ui2py-batch-converter`は、Qt Designerで生成された1つまたは複数の`.ui`ファイルを、PySide2で使用できるPythonファイルに変換するバッチスクリプトです。

## 環境

- Windows 10
- Python 3.10.8
- PySide2 5.15.2

## インストール

[最新リリース](https://github.com/NinaMina2737/ui2py-batch-converter/releases/latest)をダウンロードし、アーカイブを展開します。

## 必要条件

- PySide2：バッチスクリプトは、`.ui`ファイルをPythonに変換するために`pyside2-uic`というコマンドラインツールに依存しています。PySide2がインストールされ、コマンドラインからアクセスできることを確認してください。

## 使用法

```batch
ui2py.bat [ui_files]
```

バッチスクリプトは、コマンドラインから1つ以上の`.ui`ファイルを引数として渡すか、引数なしで呼び出すことができます。後者の場合、`.ui`ファイルを選択するようにユーザーに促します。

変換されたPythonファイルは、対応する`.ui`ファイルと同じディレクトリに、同じベース名と`.py`拡張子で保存されます。

## ライセンス

このプロジェクトはMITライセンスの下で公開されています。詳細については、[LICENSE](LICENSE)ファイルを参照してください。
