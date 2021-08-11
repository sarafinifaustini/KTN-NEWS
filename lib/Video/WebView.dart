import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewContainer extends StatefulWidget {
  final String url;

  WebViewContainer(this.url);

  @override
  createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer>
    with WidgetsBindingObserver {

  WebViewController? _controller;
  final _key = UniqueKey();
  bool isScreenVisible = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          isScreenVisible
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AspectRatio(
                  aspectRatio:1,
                  child: WebView(
                    key: _key,
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: widget.url,
                    onWebViewCreated: (controller) => _controller = controller,
                  ),
                ),
    ])
            : Container(),
    ]));
  }

    @override
    void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {
        isScreenVisible = true;
      });
      _controller?.reload();
    } else {
      setState(() {
        isScreenVisible = false;
      });
    }
  }
}
