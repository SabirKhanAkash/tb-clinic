import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<void> handlePermission(Permission permission) async {
    PermissionStatus currentPermissionStatus = await checkPermissionStatus(permission);
    if (!currentPermissionStatus.isGranted) {
      switch (currentPermissionStatus) {
        case PermissionStatus.permanentlyDenied:
          await openSettings();
          break;

        default:
          await requestPermission(permission);
          break;
      }
    }
  }

  static Future<PermissionStatus> checkPermissionStatus(Permission permission) async {
    return await permission.status;
  }

  static Future<bool> isPermanentlyDenied(Permission permission) async {
    return await permission.isPermanentlyDenied;
  }

  static Future<bool> isPermissionGranted(Permission permission) async {
    return await permission.isGranted;
  }

  static Future<bool> isPermissionRestricted(Permission permission) async {
    return await permission.isRestricted;
  }

  static Future<void> openSettings() async {
    await openAppSettings();
  }

  static Future<bool> requestPermission(Permission permission) async {
    var status = await permission.status;

    if (status.isDenied) status = await permission.request();
    return status.isGranted;
  }

  static Future<Map<Permission, PermissionStatus>> requestPermissions(
      List<Permission> permissions) async {
    final Map<Permission, PermissionStatus> statuses = await permissions.request();

    return statuses;
  }
}
