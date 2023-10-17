import 'package:anonymous_call_recorder/call_state_handler.dart';
import 'package:anonymous_call_recorder/call_state_service.dart';
import 'package:flutter/material.dart';
import 'package:phone_state_background/phone_state_background.dart';

@pragma('vm:entry-point')
Future<void> phoneStateBackgroundCallbackHandler(
  PhoneStateBackgroundEvent event,
  String number,
  int duration,
) async {
    callStateHandler(event, number, duration);
}


void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});
  
  @override
  State<StatefulWidget> createState() {
    return MainAppState();
  }
}

class MainAppState extends State<MainApp> with WidgetsBindingObserver{

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    initAll();
  }

  Future initAll() async {
    final callStateService = CallStateService.getInstance();
    callStateService
      .checkPermission();
    callStateService
      .initBackgroundService(phoneStateBackgroundCallbackHandler);
  }

   @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      await CallStateService
        .getInstance()
        .checkPermission();
    }
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
