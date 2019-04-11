This is an example of how to build a __Windows MSI__ installer for a node.js server application using WiX.

## Introduction

The msi installer will install:

1. All files of the project root folder (except for excluded files).
2. node.exe to run the program.
3. nssm.exe to register a service.
4. A shortcut in the Start menu to the url of the web application

By default it will install to `C:\Program Files (x86)\My Manufacturer\My Application`. Every component installed is rolled back on uninstall.

## Prerequisites

You need to have [WiX Toolset 3.11](http://wixtoolset.org/releases/) and [node.js](https://nodejs.org/en/download/) installed.

The paths are hardcoded but if something fails you get a very good message.

## Usage

1. Open `installer/installer.wxs` in a text editor.
2. In line 5 and 6 enter GUIDs. You can use an [online generator](https://www.guidgen.com/).
3. Open a new powershell as administrator.
4. Enable execution of powershell scripts by entering: `Set-ExecutionPolicy RemoteSigned`
5. Navigate into the installer directory.
6. Run `.\build.ps1` on powershell.

## Customization

You can edit the files inside `installer/resources` to apply your company design.
The icon under `public/favicon.ico` is used for the shortcut in the Windows Start menu and for the entry under Windows Add/Remove Software. 
Enter your company name and product name in the according fields in `installer/en-us.wxl`.

## Exclude files

If you want to exclude files from WiX so it will not be installed have a look at `installer/exclude_files.xslt` and add your files.