# Suppress missing class warnings for Stripe push provisioning
-dontwarn com.stripe.android.pushProvisioning.**
-dontwarn com.reactnativestripesdk.**

# Keep Stripe SDK classes from being obfuscated or stripped
-keep class com.stripe.** { *; }
-keep interface com.stripe.** { *; }