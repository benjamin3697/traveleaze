plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.traveleaze"
    compileSdk = flutter.compileSdkVersion
    // Determine a usable NDK version if possible.
    // Strategy:
    // 1) If the Flutter-provided ndkVersion exists and appears valid (has source.properties), use it.
    // 2) Otherwise, search common SDK locations for any installed NDK (that contains source.properties) and pick one.
    // 3) If none found, skip setting ndkVersion to avoid hard failure; user should install an NDK via SDK Manager.
    try {
        fun File.hasSourceProps(): Boolean = this.exists() && this.resolve("source.properties").exists()

        val sdkCandidates = listOfNotNull(
            System.getenv("ANDROID_SDK_ROOT"),
            System.getenv("ANDROID_HOME"),
            // Common Windows location
            System.getenv("LOCALAPPDATA")?.let { "$it/Android/sdk" }
        ).map { file(it) }

        // 1) check flutter.ndkVersion first
        var chosenNdk: File? = null
        if (flutter.ndkVersion != null && flutter.ndkVersion.isNotEmpty()) {
            for (sdkRoot in sdkCandidates) {
                val candidate = sdkRoot.resolve("ndk").resolve(flutter.ndkVersion)
                if (candidate.hasSourceProps()) {
                    chosenNdk = candidate
                    break
                }
            }
        }

        // 2) otherwise scan for any installed ndk under sdkRoots
        if (chosenNdk == null) {
            for (sdkRoot in sdkCandidates) {
                val ndkParent = sdkRoot.resolve("ndk")
                if (ndkParent.exists() && ndkParent.isDirectory) {
                    val valid = ndkParent.listFiles()?.filter { it.isDirectory && it.hasSourceProps() }
                    if (!valid.isNullOrEmpty()) {
                        // pick the first (typically there's one or several side-by-side NDKs)
                        chosenNdk = valid.first()
                        break
                    }
                }
            }
        }

        if (chosenNdk != null) {
            // set ndkVersion to the directory name (like "26.3.11579264") so Gradle picks it.
            ndkVersion = chosenNdk.name
            logger.lifecycle("Using installed NDK: ${chosenNdk.absolutePath}")
        } else {
            logger.warn("No valid NDK found in SDK roots. Skipping explicit ndkVersion assignment. Install an NDK via Android SDK Manager if required.")
        }
    } catch (e: Exception) {
        logger.warn("Error while detecting NDK: " + (e.message ?: e.toString()))
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.traveleaze"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
