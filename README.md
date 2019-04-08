This is an example of how to build a __Windows MSI__ installer for a node.js server application using WiX.

## Introduction

The msi installer will install:

1.  Every file in the Program Files\Manufacturer\Product folder
2.  node.exe in Files\Manufacturer\Product
3.  nssm.exe in Files\Manufacturer\Product
4.  Register the service as a Windows Service
5.  A shortcut in the start menu to the url of the web application

Every component installed is properly rolled back on uninstall.

## Why packaging node.exe?

1.  node.exe is an small file and an standalone file
2.  we don't want to mess with other applications

## Prerequisites

You need to have [WiX Toolset 3.11](http://wixtoolset.org/releases/) and [node.js](https://nodejs.org/en/download/) installed.

The paths are hardcoded all over the example but if something fails you get a very good message.

## Usage

1.  Open `installer/installer.wxs` in a text editor.
2.  In line 5 and 6 enter GUIDs. You can use an [online generator](https://www.guidgen.com/).
3.  Open a new powershell as administrator.
4.  Enable execution of powershell scripts by entering: `Set-ExecutionPolicy RemoteSigned`
5.  Navigate into the installer directory.
6.  Run `.\build.ps1` on powershell.

## Customization

You can edit the files inside `installer/resources` to apply your company design.
The icon under `public/favicon.ico` is used for the shortcut in the Windows Start menu and for the entry under Windows Add/Remove Software. 
Enter your company name and product name in the according fields in `installer/en-us.wxl`.

## Exclude files

If you want to exclude files from WiX so it will not be installed have a look at `installer/exclude_files.xslt` and add your files.