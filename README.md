# CAFFIORA - Online Coffee Shop

Frontend-only Flutter demo for CAFFIORA. No backend, API, Firebase, or payment gateway.

## Run

```bash
flutter pub get
flutter run
```

## Demo flow

Splash → Onboarding → Sign In → Home → Menu → Product Details → Cart → Checkout → Order Success

Register and Forgot Password are local validation demos only.

## Notes

- Sign in accepts any valid email and a password of 6+ characters.
- Cart and checkout use in-memory Flutter state.
- Contact form shows a local success dialog.
