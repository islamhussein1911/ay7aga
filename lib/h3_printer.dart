import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:mostaqel1/helpers/permission_helper.dart';
import 'dart:io';

class H3Printer {
  static const platform = MethodChannel('h3_printer');

  /// Core BLD Thermal Printer Function - DO NOT MODIFY
  /// This function sends text directly to your BLD thermal printer
  /// via the "com.bld.settings.print" package as specified
  static Future<bool> printText(String text) async {
    try {
      await platform.invokeMethod("printText", {"text": text});
      return true;
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print('Print error: ${e.message}');
      }
      return false;
    }
  }

  /// Print receipt using BLD Thermal Printer
  /// This maintains your original BLD printer functionality
  static Future<bool> printReceipt({
    required String title,
    required List<String> items,
    required String total,
    String? date,
  }) async {
    final receipt = _formatReceipt(title, items, total, date);
    return await printText(receipt); // Uses BLD printer
  }

  /// Download receipt as PDF (separate from BLD printer)
  /// This is an additional feature that doesn't interfere with thermal printing
  static Future<String?> downloadReceiptAsPdf({
    required String title,
    required List<String> items,
    required String total,
    String? date,
  }) async {
    try {
      // Check permissions using our helper (this won't affect BLD printer functionality)
      final hasPermission =
          await PermissionHelper.requestStoragePermissionIfNeeded();

      if (!hasPermission) {
        return null; // PDF download disabled, but BLD printer still works
      }

      // Create PDF document
      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Title
                pw.Center(
                  child: pw.Text(
                    title,
                    style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.SizedBox(height: 20),

                // Date
                if (date != null)
                  pw.Align(
                    alignment: pw.Alignment.centerRight,
                    child: pw.Text(
                      'التاريخ: $date',
                      style: const pw.TextStyle(fontSize: 12),
                    ),
                  ),

                pw.SizedBox(height: 20),

                // Divider
                pw.Divider(),

                // Items
                ...items.map(
                  (item) => pw.Padding(
                    padding: const pw.EdgeInsets.symmetric(vertical: 2),
                    child: pw.Align(
                      alignment: pw.Alignment.centerRight,
                      child: pw.Text(
                        item,
                        style: const pw.TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ),

                pw.SizedBox(height: 10),
                pw.Divider(),

                // Total
                pw.Align(
                  alignment: pw.Alignment.centerRight,
                  child: pw.Text(
                    'المجموع: $total',
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),

                pw.SizedBox(height: 30),

                // Thank you message
                pw.Center(
                  child: pw.Text(
                    '!شكراً لكم',
                    style: pw.TextStyle(
                      fontSize: 16,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );

      // Get appropriate directory for saving
      Directory? directory;

      if (Platform.isAndroid) {
        try {
          // Try to get the Downloads directory first
          directory = Directory('/storage/emulated/0/Download');

          // If that doesn't work, fall back to app-specific external directory
          if (!await directory.exists()) {
            directory = await getExternalStorageDirectory();
            if (directory != null) {
              // Create a Downloads subfolder in the app directory
              directory = Directory('${directory.path}/Downloads');
            }
          }
        } catch (e) {
          // Final fallback to app documents directory
          directory = await getApplicationDocumentsDirectory();
        }
      } else {
        directory = await getApplicationDocumentsDirectory();
      }

      if (directory == null) {
        return null;
      }

      // Ensure directory exists
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      // Save PDF file
      final fileName = 'receipt_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final file = File('${directory.path}/$fileName');
      await file.writeAsBytes(await pdf.save());

      return file.path;
    } catch (e) {
      if (kDebugMode) {
        print('PDF generation error: $e');
      }
      return null;
    }
  }

  static String _formatReceipt(
    String title,
    List<String> items,
    String total,
    String? date,
  ) {
    final buffer = StringBuffer();
    buffer.writeln('================================');
    buffer.writeln('        $title');
    buffer.writeln('================================');

    if (date != null) {
      buffer.writeln('التاريخ: $date');
      buffer.writeln('--------------------------------');
    }

    for (String item in items) {
      buffer.writeln(item);
    }

    buffer.writeln('--------------------------------');
    buffer.writeln('المجموع: $total');
    buffer.writeln('================================');
    buffer.writeln();
    buffer.writeln('       !شكراً لكم');
    buffer.writeln('================================');

    return buffer.toString();
  }
}
