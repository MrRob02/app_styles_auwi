import 'dart:async';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraPermission {
  static void init() async {
    Get.put(CameraPermission());
    if (await Permission.camera.isGranted) {
      _cameraPermission.value = PermissionStatus.granted;
    }
  }

  static final Rx<PermissionStatus?> _cameraPermission =
      Rx(PermissionStatus.denied);
  bool get isGranted => _cameraPermission.value == PermissionStatus.granted;
  bool get isPermanentDenied =>
      _cameraPermission.value == PermissionStatus.permanentlyDenied;
  static Future requestCameraPermission() async {
    if (_cameraPermission.value == PermissionStatus.granted) {
      return;
    } else if (_cameraPermission.value == PermissionStatus.permanentlyDenied) {
      await openAppSettings();
      return;
    }
    _cameraPermission.value = await Permission.camera.request();
  }
}
