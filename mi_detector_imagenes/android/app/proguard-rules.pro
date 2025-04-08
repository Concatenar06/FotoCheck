# Reglas de ProGuard para FotoCheck App

# Mantener las clases del modelo
-keep class com.fotocheck.app.models.** { *; }

# Reglas para Flutter
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Reglas para Kotlin
-keep class kotlin.** { *; }
-keep class kotlin.Metadata { *; }

# Reglas para las bibliotecas que usamos
-keep class com.squareup.okhttp.** { *; }
-keep interface com.squareup.okhttp.** { *; }

# Mantener anotaciones
-keepattributes *Annotation*
-keepattributes Signature
-keepattributes Exceptions

# Mantener R
-keepclassmembers class **.R$* {
    public static <fields>;
}

# Mantener atributos nativos
-keepattributes SourceFile,LineNumberTable
-keepattributes RuntimeVisibleAnnotations,RuntimeVisibleParameterAnnotations
-keepattributes AnnotationDefault

# Mantener constructores nativos
-keepclasseswithmembers class * {
    native <methods>;
}
