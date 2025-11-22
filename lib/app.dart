import 'package:flutter/material.dart';
import 'package:mostaqel1/screens/test_screen.dart';
import 'package:mostaqel1/helpers/permission_helper.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'طابعة بي إل دي الحرارية',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        fontFamily: 'Arial', // Better Arabic font support
      ),
      home: const PermissionAwareTestScreen(),
    );
  }
}

class PermissionAwareTestScreen extends StatefulWidget {
  const PermissionAwareTestScreen({super.key});

  @override
  State<PermissionAwareTestScreen> createState() =>
      _PermissionAwareTestScreenState();
}

class _PermissionAwareTestScreenState extends State<PermissionAwareTestScreen> {
  @override
  void initState() {
    super.initState();
    // Request permissions after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _requestPermissions();
    });
  }

  Future<void> _requestPermissions() async {
    await PermissionHelper.requestAllPermissions(context);
  }

  @override
  Widget build(BuildContext context) {
    return const TestScreen();
  }
}
