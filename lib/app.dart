import 'package:flutter/material.dart';
import 'package:get/get.dart';
// colors are used by individual screens; not required in this file
import 'package:traveleaze/utilities/themes/theme.dart';
import 'package:traveleaze/common/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
  //initialBinding: GeneralBindings(),
  // Show the splash screen on app start which will navigate to SignIn after 2s
  home: const SplashScreen(),
   
);}
}