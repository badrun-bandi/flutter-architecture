# flutter_architecture_starter

A Flutter Boilerplate application.

## Flutter Boilerplate 🎉

## 🚀 First steps

*  To install Flutter, follow the [installation guide](https://flutter.dev/docs/get-started/install)
*  Activate the beta channel with flutter for web support.
*  Create a new project with `flutter create flutter_architecture_starter`.
*  run project with flutter run

## 🔧 Some tools

* We are going to use [VSCode](https://code.visualstudio.com/download), but you can also use Android Studio
* [scrcpy](https://github.com/Genymobile/scrcpy) is good
* [codepen](https://codepen.io/pen/editor/flutter) is good
* [dartpad](https://dartpad.dev/) is good
* [fvm](https://github.com/leoafarias/fvm) is good

## 🤓 Basic Concepts
* 🧱 Widgets
* ⚡ Hot reload / ♻️ Hot restart
* 🔬 Devtools

## Clean Structure
* Route - All in route. Consider for dynamic route
* Utils - Common static
* Service - Kind of repository with multiple implementation for Data
* Theme - General Apps themes
* Model - POJO object
* Mapper - Service serial and response deserializer. Mapping Data layer
* Facade - Can call this a ViewModel for business logic
* Screen - All presentational widget. Page / container and reusable widgets
* Repositry - ??

## 🖼️ Basic Layout
* `Rows`
* `Columns`
* `Expanded`
* `Center`
* [Constraints](https://flutter.dev/docs/development/ui/layout/box-constraints) ([examples](https://flutter.dev/docs/development/ui/layout/constraints))

## 📦 Assets
* Fonts ([Poppins](https://fonts.google.com/specimen/Poppins))
* Images

## 📝 State
* `setState` is cool and simple.
* We use provider for DI and state management.

## 🛸 Navigation
* `Navigator`
* Push, pop!

## 👋 Flutter run key commands.
* r Hot reload.
* R Hot restart.
* d Detach (terminate "flutter run" but leave application running).
* c Clear the screen
* q Quit (terminate the application on the device).
