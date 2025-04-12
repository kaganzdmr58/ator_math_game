web-build:
	flutter build web 

clean:
	flutter clean

pub:
	flutter pub get

runner: 
	dart run build_runner build

l10n:
	flutter gen-l10n

add-image:
	flutter pub run build_runner build

run-chrome:
	flutter run -d chrome --web-port 443 --web-tls-cert-path backoffice-flutter-cert.pem --web-tls-cert-key-path backoffice-flutter-key.pem --web-renderer html -t lib/main.dart --web-port 7000

run-local:
	flutter run -d chrome --web-port 7000 --dart-define=flavor=dev --web-renderer html
version:
	dart scripts/update_version.dart patch

build:
	flutter build apk --release

build-aab:
	dart scripts/update_version.dart patch
	flutter build appbundle --release --verbose
