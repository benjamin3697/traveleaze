// lib/app_bindings.dart

import 'package:get/get.dart';
import 'package:traveleaze/features/authentication/controllers/auth_repository.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Initialize AuthRepository as soon as the app starts
    Get.put(AuthRepository());
  }
}
