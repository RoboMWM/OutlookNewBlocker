# `Outlook (new)` blocker and removal script

This script removes and prevents the Outlook (new) app from installing, allowing you to continue using the much better and more performant Mail and Calendar apps.

This installs a custom blank app with the same package id as the original one, thus making the automatic installation of Outlook (new) fail

## How does this script work?

1. Copies the `AppxManifest.xml` to the `%AppData%\OutlookNewBlocker`
2. Enables developer mode (to allow for sideloading apps) via registry
3. Uninstalls `Outlook (new)` (if present)
4. Sideloads the blank AppxManifest.xml from this repo

## Why does the script need to be run as administrator?

The script enables developer mode, and uninstalls Outlook (new) from all users system-wide.

It is possible to make a version of this script that only uninstalls `Outlook (new)` for only the current user, but I do not know if this will permit sideloading of the same package id if it's currently installed or staged for installation for other users. The user would also have to manually enable developer mode, if not already enabled.
