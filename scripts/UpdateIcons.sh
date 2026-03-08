#!/usr/bin/env bash
set -e

clear
flutter pub get
dart run flutter_launcher_icons

echo "Ícones atualizados com sucesso usando assets/images/icon.png"
