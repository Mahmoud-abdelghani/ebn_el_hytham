# Paymob SDK
-keep class com.paymob.** { *; }

-dontwarn com.paymob.**

# Kotlin
-keep class kotlin.** { *; }

# Reflection
-keepattributes Signature
-keepattributes *Annotation*

# Navigation
-keep class androidx.navigation.** { *; }