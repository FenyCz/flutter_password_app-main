# flutter_password_app

Mobile application which stores password items - service name, user name and password (e.g. Gmail, redjohny@gmail.com, BlondJohny86)

App contains 3 screens:

Main screen - shows password items in db. 

Adding password screen - add new password item to db. All information must be set (service name, user name, password).

Detail screen - shows details of password item. Allows quick copy of every single text line. Password is hidden by default and is displayed after click on eye icon.

The passwords are stored in flutter_secure_storage which works as key-value. For every password is unique ID generated. 
This ID is stored in db and the password is reachable from flutter_secure_storage.
Passwords are not stored as plaintext in db.

DB: SQFlite
Security: flutter_secure_storage

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
