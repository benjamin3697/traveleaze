import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AppDeviceUtility{
  static void hidekeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static Future<void> setStatusBarColor(Color color) async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: color, // Set the status bar color// Set the status bar icon brightness
      ),
    );
  }

  static bool isLandscapeOrientation(BuildContext context) {
    final viewInsets= View.of(context).viewInsets;
    return viewInsets.bottom ==0;
  }

  static bool isPortraitOrientation(BuildContext context) {
    final viewInsets = View.of(context).viewInsets;
    return viewInsets.bottom != 0;
  }

  static void fullScreenMode(bool enable) {
    SystemChrome.setEnabledSystemUIMode(enable? SystemUiMode.immersiveSticky : SystemUiMode.edgeToEdge);
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getpixelRatio(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }

  static double getStatusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }


  static double getBottomNavigationBarHeight() {
    return kBottomNavigationBarHeight;
  }

  static double getAppBarHeight() {
    return kToolbarHeight;
  }

  static double getKeyboardHeight(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets;
    return viewInsets.bottom;
  }

  static Future<bool> isKeyboardVisible(BuildContext context) async {
    final viewInsets = MediaQuery.of(context).viewInsets;
    return viewInsets.bottom > 0;
  }
  static Future<bool> isPhysicalDevice() async {
    return Future.value(defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS);
  }

  static void vibrate(Duration duration) {
    HapticFeedback.vibrate();
    Future.delayed(duration, () =>HapticFeedback.vibrate());
  }

  static Future<void> setPreferredOrientations(List<DeviceOrientation> orientations) async {
    await SystemChrome.setPreferredOrientations(orientations);
  }

  static void hideStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    }

    static void showStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    }

    static Future<bool> hasInternetConnection() async {
    try{
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    } catch (e) {
      // Handle other exceptions if necessary
      if (kDebugMode) {}
        if (kDebugMode) {
          print('Error checking internet connection: $e');
        }
    }    
      return false; 
    }

    static bool isIOS() {
      return Platform.isIOS;
    }
    static bool isAndroid() {
      return Platform.isAndroid;
    }
    static bool isWeb() {
      return kIsWeb;
    }
    static bool isDesktop() {
      return Platform.isWindows || Platform.isLinux || Platform.isMacOS;
    }
    static bool isMobile() {
      return Platform.isAndroid || Platform.isIOS;
    }
    static bool isTablet(BuildContext context) {
      final size = MediaQuery.of(context).size;
      return (size.shortestSide >= 600);
    }
    static bool isSmallScreen(BuildContext context) {
      final size = MediaQuery.of(context).size;
      return (size.shortestSide < 600);
    }
    static bool isLargeScreen(BuildContext context) {
      final size = MediaQuery.of(context).size;
      return (size.shortestSide >= 600);
    }
    static bool isVeryLargeScreen(BuildContext context) {
      final size = MediaQuery.of(context).size;
      return (size.shortestSide >= 1200);
    }
    static bool isVerySmallScreen(BuildContext context) {
      final size = MediaQuery.of(context).size;
      return (size.shortestSide < 400);
    }
    static bool isVeryWideScreen(BuildContext context) {
      final size = MediaQuery.of(context).size;
      return (size.width > 1200);
    }
    static bool isVeryNarrowScreen(BuildContext context) {
      final size = MediaQuery.of(context).size;
      return (size.width < 400);
    }
    static bool isSquareScreen(BuildContext context) {
      final size = MediaQuery.of(context).size;
      return (size.width == size.height);
    }
    static bool isPortraitMode(BuildContext context) {
      return MediaQuery.of(context).orientation == Orientation.portrait;
    }
    static bool isLandscapeMode(BuildContext context) {
      return MediaQuery.of(context).orientation == Orientation.landscape;
    }
    static Future<void> launchUrlString(String url) async {
      
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url);
      } else {
        throw 'Could not launch $url';
   }
}
}
