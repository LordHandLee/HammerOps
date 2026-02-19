# HammerOps Build & Deploy Guide

This is a practical, step‑by‑step guide to build and deploy the HammerOps app and server for iOS, Android, macOS, Windows, and Web.

---

## 1) Prerequisites (One‑Time Setup)

Install these tools:
- Flutter SDK (stable) and add `flutter` to your PATH.
- Xcode (for iOS/macOS builds).
- CocoaPods (`pod`) for iOS/macOS dependencies.
- Android Studio + Android SDK (for Android builds).
- Windows build tools (for Windows builds).
- Git.
- (Optional) Docker for server builds.

Verify Flutter:
```
flutter doctor -v
```

---

## 2) Configure Environment Variables

### Client (Flutter)
The app uses `HAMMEROPS_API_BASE` at build time:
- Example: `https://hammerops.onrender.com`
- You’ll pass it via `--dart-define`.

### Server (Render / production)
Set these environment variables on your server:
- `DATABASE_URL`
- `JWT_SECRET`
- `SMTP_HOST`, `SMTP_PORT`, `SMTP_USER`, `SMTP_PASS`, `SMTP_FROM` (if SMTP)
- `VERIFY_BASE_URL` (your API/web domain)
- `INVITE_BASE_URL` (same as your web domain for invite links)
- If using Mailgun API: `MAILGUN_API_KEY`, `MAILGUN_DOMAIN`, `MAILGUN_FROM`

---

## 3) Build the Server (API + Web)

The server serves both API and web build:

### Build Flutter web assets
From repo root:
```
flutter build web --release --dart-define=HAMMEROPS_API_BASE=https://your-api-domain
```

Then copy into the server folder:
```
rm -rf server/web_build
cp -R build/web server/web_build
```

### Build server binary locally (optional)
```
cd server
dart pub get
dart run build_runner build --delete-conflicting-outputs
dart compile exe bin/server.dart -o bin/server
```

### Docker (recommended for Render)
Render can use the `server/Dockerfile`.
Make sure `server/web_build` exists before building.

---

## 4) Deploy Server on Render (Recommended)

1) Push repo to GitHub.
2) In Render:
   - Create a new **Web Service**.
   - Point it at your repo.
   - Use **Docker**.
3) Set your environment variables from section 2.
4) Deploy.

---

## 5) iOS Build & Deploy

### First‑time CocoaPods
```
flutter clean
flutter pub get
cd ios
LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 pod install
```

### Build from CLI
```
flutter build ios --release --dart-define=HAMMEROPS_API_BASE=https://your-api-domain
```

### Open Xcode (for signing + distribution)
Open:
```
ios/Runner.xcworkspace
```

In Xcode:
1) Select the `Runner` target.
2) Set your Team and Bundle ID.
3) Archive: Product → Archive.
4) Distribute via TestFlight/App Store.

---

## 6) Android Build & Deploy

### Debug build
```
flutter run --dart-define=HAMMEROPS_API_BASE=https://your-api-domain
```

### Release build (AAB for Play Store)
Set up signing (keystore + `key.properties`), then:
```
flutter build appbundle --release --dart-define=HAMMEROPS_API_BASE=https://your-api-domain
```

The output:
```
build/app/outputs/bundle/release/app-release.aab
```

Upload to Google Play Console.

---

## 7) macOS Build & Deploy

```
flutter build macos --release --dart-define=HAMMEROPS_API_BASE=https://your-api-domain
```

Open macOS Runner in Xcode:
```
macos/Runner.xcworkspace
```

Set signing team and bundle ID.

To distribute:
- Notarize and package `.app` (or create a `.dmg`).
- Or distribute via your preferred channel.

---

## 8) Windows Build & Deploy

```
flutter build windows --release --dart-define=HAMMEROPS_API_BASE=https://your-api-domain
```

Output:
```
build/windows/x64/runner/Release/
```

Package into an installer (e.g., MSIX or Inno Setup).

---

## 9) Web Build (Standalone Hosting)

If you want to host the Flutter web app separately:
```
flutter build web --release --dart-define=HAMMEROPS_API_BASE=https://your-api-domain
```

Deploy `build/web` to a static host (Netlify, Vercel, S3, etc.).

---

## 10) Common Troubleshooting

### “Unable to find module dependency: Flutter”
- Ensure `pod install` ran successfully.
- Use `ios/Runner.xcworkspace` (not `.xcodeproj`).
- Make sure `ios/Flutter/Debug.xcconfig` and `Release.xcconfig` include Pods configs.

### CocoaPods UTF‑8 errors
```
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
```

### Web build shows blank page
- Confirm assets exist in `server/web_build`.
- Hard refresh browser.
- Ensure API base is correct.

---

If you want, I can add platform‑specific build scripts to automate these steps.*** End Patch"}}
