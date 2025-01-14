# `Outlook (new)` blocker and removal script

This script removes and prevents the Outlook (new) app from installing, allowing you to continue using the much better and more performant Mail and Calendar apps.

This installs a custom blank app with the same package id as the original one, thus making the automatic installation of Outlook (new) fail

## Usage

1. Download [OutlookNewBlocker.bat](https://github.com/RoboMWM/OutlookNewBlocker/releases/download/1.0.0/OutlookNewBlocker.bat)
2. Right-click `OutlookNewBlocker.bat` and `Run as administrator`

## How does this work?
=========================
1. Copies the  AppxManifest.xml to the %AppData% folder
2. Enables developer mode (to allow for sideloading apps) via registry
3. Uninstalls the New Outlook (if present)
4. Sideloads the blank AppxManifest.xml from this repo
