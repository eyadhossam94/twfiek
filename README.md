# Twfiek

Flutter storefront app for the Twfiek shop.

## Current app modules

- Firebase email/password sign-in and account creation
- Remember-me session restoration
- Animated splash screen and shared purple theme
- Home screen with searchable company and category sections
- Category detail landing page
- Profile screen
- Cart and notifications empty states
- Local image assets for the logo, app icon, user, company brands, category artwork and home background

## Run locally

```bash
flutter pub get
flutter run
```

Generate launcher icons from the configured asset:

```bash
dart run flutter_launcher_icons
```

## Firebase setup

The app initializes Firebase using `lib/firebase_options.dart`. In Firebase Console, enable **Email/Password** under Authentication > Sign-in method. Keep the platform configuration files aligned with the Firebase project used by this repository.

## Asset folders

- `assets/logo/`
- `assets/icon/`
- `assets/product/`
- `assets/father product/`

These folders are declared in `pubspec.yaml`.

## Store catalogue integration

The repository currently contains brand logos and category artwork, but no structured product catalogue, stock quantities, or prices. The category page therefore acts as a catalogue landing page until the shop's real product data and pricing are supplied and connected. Cart, orders, and favorites need that catalogue and a persistence backend before they can process real purchases.
