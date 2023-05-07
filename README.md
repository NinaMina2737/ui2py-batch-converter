# ui2py-batch-converter

[Japanese](README-ja.md)

`ui2py-batch-converter` is a batch script that converts one or more `.ui` files generated with Qt Designer into Python files that can be used with PySide2.

## Environment

- Windows 10
- Python 3.10.8
- PySide2 5.15.2

## Installation

Download the [latest release](https://github.com/NinaMina2737/ui2py-batch-converter/releases/latest) and extract the archive.

## Prerequisites

- PySide2: The batch script relies on the `pyside2-uic` command-line tool to convert `.ui` files to Python. Make sure PySide2 is installed and accessible from the command line.

## Usage

```batch
ui2py.bat [ui_files]
```

The batch script can be invoked from the command line, passing one or more `.ui` files as arguments, or without arguments, in which case it will prompt the user to select the `.ui` files.

The converted Python files will be saved in the same directory as the corresponding `.ui` files, with the same base name and the `.py` extension.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
