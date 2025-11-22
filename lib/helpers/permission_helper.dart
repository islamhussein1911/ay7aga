import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class PermissionHelper {
  static Future<void> requestAllPermissions(BuildContext context) async {
    if (!Platform.isAndroid) return;

    // Check storage permissions
    final storageStatus = await Permission.storage.status;
    final manageStorageStatus = await Permission.manageExternalStorage.status;

    final needsPermission =
        !storageStatus.isGranted && !manageStorageStatus.isGranted;

    if (!needsPermission) return;

    // Show explanation dialog first
    if (context.mounted) {
      final shouldRequest = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.security, color: Colors.orange),
              SizedBox(width: 8),
              Text('مطلوب أذونات', style: TextStyle(fontSize: 20)),
            ],
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('يحتاج هذا التطبيق إلى الأذونات التالية للعمل بشكل صحيح:'),
              SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.print, size: 20, color: Colors.blue),
                  SizedBox(width: 8),
                  Expanded(child: Text('الوصول للطابعة لطباعة الفواتير')),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.file_download, size: 20, color: Colors.green),
                  SizedBox(width: 8),
                  Expanded(child: Text('الوصول للتخزين لتحميل ملفات PDF')),
                ],
              ),
              SizedBox(height: 12),
              Text(
                'هذه الأذونات لن تؤثر على خصوصيتك أو بياناتك.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('ليس الآن'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('منح الأذونات'),
            ),
          ],
        ),
      );

      if (shouldRequest != true) return;
    }

    // Request storage permission
    var result = await Permission.storage.request();

    // If storage permission denied, try manage external storage
    if (result.isDenied) {
      result = await Permission.manageExternalStorage.request();
    }

    // Show result to user
    if (result.isDenied || result.isPermanentlyDenied) {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.warning, color: Colors.orange),
                SizedBox(width: 8),
                Text('Limited Functionality'),
              ],
            ),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Storage permission was denied. Here\'s what will be affected:',
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.error, size: 20, color: Colors.red),
                    SizedBox(width: 8),
                    Expanded(child: Text('PDF download feature disabled')),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.check, size: 20, color: Colors.green),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'BLD Thermal printer will still work perfectly',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  'You can enable permissions later in Settings > Apps > Permissions',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('مفهوم'),
              ),
              if (result.isPermanentlyDenied)
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    openAppSettings();
                  },
                  child: const Text('فتح الإعدادات'),
                ),
            ],
          ),
        );
      }
    }
  }

  static Future<bool> hasStoragePermission() async {
    if (!Platform.isAndroid) return true;

    // For Android 10+ (API 29+), check different permissions
    if (await Permission.storage.isGranted) return true;
    if (await Permission.manageExternalStorage.isGranted) return true;

    // For Android 10, also check photos permission
    if (await Permission.photos.isGranted) return true;

    return false;
  }

  static Future<bool> requestStoragePermissionIfNeeded() async {
    if (!Platform.isAndroid) return true;

    if (await hasStoragePermission()) return true;

    // For Android 10+, try multiple permission strategies
    var status = await Permission.storage.request();
    if (status.isGranted) return true;

    // Try photos permission for Android 10+
    status = await Permission.photos.request();
    if (status.isGranted) return true;

    // Try manage external storage for Android 11+
    status = await Permission.manageExternalStorage.request();
    return status.isGranted;
  }
}
