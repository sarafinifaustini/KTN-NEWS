import 'package:flutter/material.dart';

class LifeCycleManager extends StatefulWidget {
  LifeCycleManager({Key? key, @required this.child}) : super(key: key);

  final Widget? child;

  @override
  _LifeCycleManagerState createState() => _LifeCycleManagerState();
}

class _LifeCycleManagerState extends State<LifeCycleManager> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state)  {
    super.didChangeAppLifecycleState(state);
    if (state==AppLifecycleState.paused){
          // ignore: unnecessary_statements
          (controller) {
            return controller.evaluateJavascript(
          'var video = document.querySelector("video");video.pause();');
          };
          // ignore: unnecessary_statements
          (error) => debugPrint(error.toString());
    }
    if (state==AppLifecycleState.paused){
          // ignore: unnecessary_statements
          (controller) => controller.evaluateJavascript(
          'var video = document.querySelector("video");video.resume();');
          // ignore: unnecessary_statements
          (error) => debugPrint(error.toString());
    }
    print('AppLifecycleState: $state');
  }

  @override
  Widget build(BuildContext context) {
    return widget.child!;
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }
}