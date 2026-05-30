import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart'; // Add this import

// Original function stays the same
Future<XFile> urlToXFile(String url) async {
  final dio = Dio();

  // Get file name from URL
  String fileName;
  try {
    final uri = Uri.parse(url);
    fileName = uri.pathSegments.last.split('?').first;
    if (fileName.isEmpty) {
      fileName = 'file_${DateTime.now().millisecondsSinceEpoch}';
    }
  } catch (_) {
    fileName = 'file_${DateTime.now().millisecondsSinceEpoch}';
  }

  // Get temp directory
  final tempDir = await getTemporaryDirectory();
  final savePath = '${tempDir.path}/$fileName';

  // Download
  await dio.download(url, savePath);

  // Return XFile
  return XFile(savePath, name: fileName);
}

// New function that uses isolate
Future<XFile> urlToXFileInIsolate(String url) async {
  // Just wrap the existing function with compute
  return await compute(_urlToXFileCompute, url);
}

// Helper function for compute (must be top-level)
Future<XFile> _urlToXFileCompute(String url) async {
  // Copy the exact same code from urlToXFile
  final dio = Dio();

  // Get file name from URL
  String fileName;
  try {
    final uri = Uri.parse(url);
    fileName = uri.pathSegments.last.split('?').first;
    if (fileName.isEmpty) {
      fileName = 'file_${DateTime.now().millisecondsSinceEpoch}';
    }
  } catch (_) {
    fileName = 'file_${DateTime.now().millisecondsSinceEpoch}';
  }

  // Get temp directory
  final tempDir = await getTemporaryDirectory();
  final savePath = '${tempDir.path}/$fileName';

  // Download
  await dio.download(url, savePath);

  // Return XFile
  return XFile(savePath, name: fileName);
}
