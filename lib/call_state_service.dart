import 'package:permission_handler/permission_handler.dart';
import 'package:phone_state_background/phone_state_background.dart';

class CallStateService {
  static CallStateService _instance = CallStateService();

  static CallStateService getInstance(){
    return _instance;
  }

  Future checkPermission() async {
    if(!await PhoneStateBackground.checkPermission()){
      await PhoneStateBackground.requestPermissions();
    }
    await requestPhonePermission();
  }

  Future<bool> requestPhonePermission() async {
    var status = await Permission.phone.request();

    return switch (status) {
      PermissionStatus.denied ||
      PermissionStatus.restricted ||
      PermissionStatus.limited ||
      PermissionStatus.permanentlyDenied =>
        false,
      PermissionStatus.provisional || PermissionStatus.granted => true,
    };
  }

  Future<void> initBackgroundService(
    dynamic Function(PhoneStateBackgroundEvent, String, int) backgroundCallback) async {
    await PhoneStateBackground.initialize(backgroundCallback);
  }
}