import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class CustomImagePicker extends StatefulWidget {
  final Widget child;
  final bool fieldEnable;
  final bool multiImageReq;
  final Function(XFile)? onSingleFile;
  final Function(List<XFile>)? onMultiFile;
  final Function(File)? onDocumentFile;

  const CustomImagePicker({
    super.key,
    required this.child,
    this.fieldEnable = true,
    this.multiImageReq = false,
    this.onSingleFile,
    this.onMultiFile,
    this.onDocumentFile,
  });

  @override
  State<CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  final ImagePicker _imagePicker = ImagePicker();

  /* ---------------- CAMERA PERMISSION ---------------- */

  // Future<bool> _requestCameraPermission() async {
  //   final status = await Permission.camera.status;

  //   if (status.isGranted) return true;

  //   if (status.isDenied) {
  //     final result = await Permission.camera.request();
  //     return result.isGranted;
  //   }

  //   if (status.isPermanentlyDenied || status.isRestricted) {
  //     _showPermissionDialog(
  //       'Camera permission is disabled. Please enable it from Settings.',
  //     );
  //     return false;
  //   }

  //   return false;
  // }

  /* ---------------- GALLERY PERMISSION ---------------- */

  // Future<bool> _requestGalleryPermission() async {
  //   if (Platform.isAndroid) {
  //     if (await Permission.photos.isGranted ||
  //         await Permission.storage.isGranted) {
  //       return true;
  //     }

  //     final photos = await Permission.photos.request();
  //     if (photos.isGranted) return true;

  //     final storage = await Permission.storage.request();
  //     return storage.isGranted;
  //   } else {
  //     final status = await Permission.photos.request();
  //     return status.isGranted;
  //   }
  // }

  /* ---------------- CAMERA ---------------- */

  Future<void> _openCamera() async {
    if (!widget.fieldEnable) return;

    try {
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.rear,
        imageQuality: 80,
      );

      if (image != null) {
        widget.onSingleFile?.call(image);
      }
    } catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  /* ---------------- GALLERY ---------------- */

  Future<void> _openGallery() async {
    if (!widget.fieldEnable) return;

    try {
      if (widget.multiImageReq) {
        final images = await _imagePicker.pickMultiImage(imageQuality: 80);

        if (images.isNotEmpty && widget.onMultiFile != null) {
          widget.onMultiFile!(images);
        }
      } else {
        final image = await _imagePicker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 80,
        );

        if (image != null && widget.onSingleFile != null) {
          widget.onSingleFile!(image);
        }
      }
    } catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  /* ---------------- FILES (iOS + Android) ---------------- */

  Future<void> _openFiles() async {
    if (!widget.fieldEnable) return;

    try {
      final result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'jpeg', 'pdf', 'doc', 'docx'],
        allowMultiple: widget.multiImageReq,
        withData: false,
      );

      if (result == null) return;

      final files = result.files
          .where((f) => f.path != null)
          .map((f) => XFile(f.path!))
          .toList();

      if (files.isEmpty) return;

      if (widget.multiImageReq) {
        widget.onMultiFile?.call(files);
      } else {
        widget.onSingleFile?.call(files.first);
      }
    } catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  /* ---------------- UI HELPERS ---------------- */

  // void _showPermissionDialog(String message) {
  //   showDialog(
  //     context: context,
  //     builder: (_) => AlertDialog(
  //       title: const Text('Permission Required'),
  //       content: Text(message),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context),
  //           child: const Text('Cancel'),
  //         ),
  //         TextButton(
  //           onPressed: () {
  //             Navigator.pop(context);
  //             openAppSettings();
  //           },
  //           child: const Text('Settings'),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  /* ---------------- SOURCE SELECTOR ---------------- */

  void _showSourceSheet() {
    if (!widget.fieldEnable) return;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () {
                Navigator.pop(context);
                _openCamera();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.pop(context);
                _openGallery();
              },
            ),
            ListTile(
              leading: const Icon(Icons.folder),
              title: const Text('Files'),
              onTap: () {
                Navigator.pop(context);
                _openFiles();
              },
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  /* ---------------- BUILD ---------------- */

  @override
  Widget build(BuildContext context) {
    if (!widget.fieldEnable) return widget.child;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _showSourceSheet,
      child: widget.child,
    );
  }
}
