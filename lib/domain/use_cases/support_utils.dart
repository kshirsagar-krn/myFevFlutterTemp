import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class SupportUtils {
  /// ------------------------------------------------------------
  /// DOWNLOAD FILE IF URL (IMPORTANT FIX)
  /// ------------------------------------------------------------
  static Future<String> downloadFileToLocal(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final dir = await getTemporaryDirectory();
        final fileName = url.split('/').last;
        final filePath = "${dir.path}/$fileName";

        final File file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        return filePath;
      } else {
        throw "Failed to download file";
      }
    } catch (e) {
      throw "Download error: $e";
    }
  }

  /// Dial a phone number
  static Future<void> dialNumber(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);

    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $launchUri';
    }
  }

  /// Send SMS
  static Future<void> sendSms(String phoneNumber, {String? body}) async {
    final Uri launchUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
      queryParameters: body != null ? {'body': body} : null,
    );

    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $launchUri';
    }
  }

  /// Send Email
  static Future<void> sendEmail({
    required List<String> recipients,
    String? subject,
    String? body,
    List<String>? cc,
    List<String>? bcc,
  }) async {
    String uri = 'mailto:${recipients.join(',')}';
    final Map<String, String> params = {};

    if (subject != null && subject.isNotEmpty) params['subject'] = subject;
    if (body != null && body.isNotEmpty) params['body'] = body;
    if (cc != null && cc.isNotEmpty) params['cc'] = cc.join(',');
    if (bcc != null && bcc.isNotEmpty) params['bcc'] = bcc.join(',');

    final Uri launchUri = Uri.parse(uri).replace(queryParameters: params);

    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $launchUri';
    }
  }

  /// Jump to WhatsApp
  static Future<void> jumpToWhatsApp({
    String? phoneNumber,
    required String message,
  }) async {
    try {
      final cleanedPhone =
          phoneNumber?.replaceAll(RegExp(r'[^0-9+]'), '') ?? '';
      final encodedMessage = Uri.encodeComponent(message);
      final whatsappUrl = 'https://wa.me/$cleanedPhone?text=$encodedMessage';

      if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
        await launchUrl(Uri.parse(whatsappUrl));
      } else {
        throw 'Could not launch WhatsApp';
      }
    } catch (e) {
      if (phoneNumber != null && !phoneNumber.startsWith('+')) {
        await jumpToWhatsApp(phoneNumber: '+$phoneNumber', message: message);
      } else {
        throw 'Could not launch WhatsApp: $e';
      }
    }
  }

  /// Share text and files
  static Future<void> shareContent({
    String? text,
    String? subject,
    List<String>? filePaths,
  }) async {
    try {
      if (filePaths != null && filePaths.isNotEmpty) {
        final files = filePaths.map((path) => XFile(path)).toList();
        // ignore: deprecated_member_use
        await Share.shareXFiles(files, text: text, subject: subject);
      } else {
        // ignore: deprecated_member_use
        await Share.share(text ?? '', subject: subject);
      }
    } catch (e) {
      throw 'Error sharing content: $e';
    }
  }

  /// ------------------------------------------------------------
  /// FIXED SHARE FILE (AUTO-DOWNLOAD IF URL)
  /// ------------------------------------------------------------
  static Future<void> shareFile({
    required String filePath,
    String? text,
    String? subject,
  }) async {
    String realPath = filePath;

    if (filePath.startsWith("http")) {
      realPath = await downloadFileToLocal(filePath);
    }

    await shareContent(filePaths: [realPath], text: text, subject: subject);
  }

  /// Share Multiple Files
  static Future<void> shareMultipleFiles({
    required List<String> filePaths,
    String? text,
    String? subject,
  }) async {
    List<String> localPaths = [];

    for (String path in filePaths) {
      if (path.startsWith("http")) {
        localPaths.add(await downloadFileToLocal(path));
      } else {
        localPaths.add(path);
      }
    }

    await shareContent(filePaths: localPaths, text: text, subject: subject);
  }

  /// Share Text
  static Future<void> shareText({required String text, String? subject}) async {
    await shareContent(text: text, subject: subject);
  }

  /// Check WhatsApp Installed
  static Future<bool> isWhatsAppInstalled() async {
    try {
      return await canLaunchUrl(Uri.parse('whatsapp://send?phone=1'));
    } catch (_) {
      return false;
    }
  }

  /// Open WhatsApp Chat
  static Future<void> openWhatsAppChat(String phoneNumber) async {
    final cleanedPhone = phoneNumber.replaceAll(RegExp(r'[^0-9+]'), '');
    final whatsappUrl = 'https://wa.me/$cleanedPhone';

    if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
      await launchUrl(Uri.parse(whatsappUrl));
    } else {
      throw 'Could not launch WhatsApp';
    }
  }

  /// Open File
  static Future<void> openFile(String filePath) async {
    try {
      if (filePath.startsWith("http")) {
        filePath = await downloadFileToLocal(filePath);
      }

      final Uri uri = Uri.parse('file://$filePath');

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        await shareContent(filePaths: [filePath]);
      }
    } catch (e) {
      throw 'Error opening file: $e';
    }
  }

  /// File Utilities
  static bool fileExists(String filePath) => File(filePath).existsSync();

  static String getFileSize(String filePath) {
    final file = File(filePath);
    if (!file.existsSync()) return "File not found";

    final bytes = file.lengthSync();
    const suffixes = ["B", "KB", "MB", "GB", "TB"];
    final i = (math.log(bytes) / math.log(1024)).floor();
    return '${(bytes / math.pow(1024, i)).toStringAsFixed(2)} ${suffixes[i]}';
  }

  static String getFileExtension(String filePath) {
    final parts = filePath.split('.');
    return parts.length > 1 ? parts.last.toLowerCase() : '';
  }

  static String getFileName(String filePath) {
    return filePath.split('/').last.split('\\').last;
  }

  /// MIME Types
  static String getMimeType(String filePath) {
    final extension = getFileExtension(filePath);
    final mimeTypes = {
      'txt': 'text/plain',
      'pdf': 'application/pdf',
      'doc': 'application/msword',
      'docx':
          'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      'jpg': 'image/jpeg',
      'jpeg': 'image/jpeg',
      'png': 'image/png',
    };

    return mimeTypes[extension] ?? 'application/octet-stream';
  }
}
