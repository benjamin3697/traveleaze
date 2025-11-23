import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_storage/get_storage.dart';
import 'package:traveleaze/app_bindings.dart';
import 'package:traveleaze/auth_wrapper.dart';
import 'package:traveleaze/features/settings/controllers/settings_controller.dart'; // 1. Import SettingsController
import 'package:traveleaze/theme/theme.dart'; // 2. Import your theme file (create this next)
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // Put the settings controller so it's available globally
    final settingsController = Get.put(SettingsController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      // --- THEME CONFIGURATION ---
      theme: TAppTheme.lightTheme, // 3. Set the light theme
      darkTheme: TAppTheme.darkTheme, // 4. Set the dark theme
      themeMode: settingsController.themeMode.value, // 5. Use controller's value

      initialBinding: AppBindings(),
      home: const AppWrapper(),
    );
  }
}
