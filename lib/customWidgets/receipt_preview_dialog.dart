import 'package:flutter/material.dart';
import 'package:mostaqel1/h3_printer.dart';
import 'package:permission_handler/permission_handler.dart';

class ReceiptPreviewDialog extends StatefulWidget {
  final String title;
  final List<String> items;
  final String total;
  final String? date;

  const ReceiptPreviewDialog({
    super.key,
    required this.title,
    required this.items,
    required this.total,
    this.date,
  });

  @override
  State<ReceiptPreviewDialog> createState() => _ReceiptPreviewDialogState();
}

class _ReceiptPreviewDialogState extends State<ReceiptPreviewDialog> {
  bool _isLoading = false;

  String get _receiptPreview {
    final buffer = StringBuffer();
    buffer.writeln('================================');
    buffer.writeln('        ${widget.title}');
    buffer.writeln('================================');

    if (widget.date != null) {
      buffer.writeln('التاريخ: ${widget.date}');
      buffer.writeln('--------------------------------');
    }

    for (String item in widget.items) {
      buffer.writeln(item);
    }

    buffer.writeln('--------------------------------');
    buffer.writeln('المجموع: ${widget.total}');
    buffer.writeln('================================');
    buffer.writeln();
    buffer.writeln('       !شكراً لكم');
    buffer.writeln('================================');

    return buffer.toString();
  }

  Future<void> _handlePrint() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final success = await H3Printer.printReceipt(
        title: widget.title,
        items: widget.items,
        total: widget.total,
        date: widget.date,
      );

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success
                  ? 'تم إرسال الفاتورة إلى الطابعة بنجاح!'
                  : 'فشل في الطباعة - لم يتم العثور على تطبيق طابعة متوافق',
            ),
            backgroundColor: success ? Colors.green : Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _handleDownloadPdf() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final filePath = await H3Printer.downloadReceiptAsPdf(
        title: widget.title,
        items: widget.items,
        total: widget.total,
        date: widget.date,
      );

      if (mounted) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              filePath != null
                  ? 'تم حفظ الفاتورة كملف PDF: ${filePath.split('/').last}'
                  : 'فشل في حفظ ملف PDF - يرجى السماح بأذونات التخزين في الإعدادات',
            ),
            backgroundColor: filePath != null ? Colors.green : Colors.red,
            duration: const Duration(seconds: 5),
            action: filePath == null
                ? SnackBarAction(
                    label: 'الإعدادات',
                    textColor: Colors.white,
                    onPressed: () async {
                      await Permission.storage.request();
                    },
                  )
                : null,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('معاينة الفاتورة'),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: SizedBox(
                width: double.infinity,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    _receiptPreview,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (_isLoading)
              const CircularProgressIndicator()
            else
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _handleDownloadPdf,
                      icon: const Icon(Icons.download),
                      label: const Text('PDF'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: _handlePrint,
                      icon: const Icon(Icons.print),
                      label: const Text('Print'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel', style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
