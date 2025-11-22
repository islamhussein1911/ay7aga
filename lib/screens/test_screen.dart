import 'package:flutter/material.dart';
import 'package:mostaqel1/customWidgets/receipt_preview_dialog.dart';
import 'package:mostaqel1/helpers/permission_helper.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  String _statusMessage = '';

  void _showReceiptDialog() {
    showDialog(
      context: context,
      builder: (context) => ReceiptPreviewDialog(
        title: 'نسخة تجريبية',
        date: DateTime.now().toString().substring(0, 16),
        items: const [
          'تجربة 1                    25.00 ليرة',
          'تجربة 2                    32.00 ليرة',
          'ضريبة القيمة المضافة          5.70 ليرة',
        ],
        total: '62.70 ليرة',
      ),
    );
  }

  Future<void> _requestPermissions() async {
    await PermissionHelper.requestAllPermissions(context);
    setState(() {
      _statusMessage = 'تم إكمال طلب الأذونات';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Screenshot 2025-11-21 020115.png',
              width: 120,
              height: 120,
            ),
            const SizedBox(height: 20),
            const Text(
              'تجربة الطباعة',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _showReceiptDialog,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Receipt Preview'),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _requestPermissions,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
                child: const Text('طلب أذونات التخزين'),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                _statusMessage.isEmpty
                    ? 'اضغط على زر لمعاينة وطباعة/تحميل'
                    : _statusMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: _statusMessage.contains('failed')
                      ? Colors.red
                      : Colors.green[700],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
