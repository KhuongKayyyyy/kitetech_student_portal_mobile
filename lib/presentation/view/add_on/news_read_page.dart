import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsReadPage extends StatefulWidget {
  const NewsReadPage({super.key});

  @override
  State<NewsReadPage> createState() => _NewsReadPageState();
}

class _NewsReadPageState extends State<NewsReadPage> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading progress
            setState(() {
              EasyLoading.showProgress(progress / 100, status: "Đang tải ...");
            });
          },
          onPageStarted: (String url) {
            // Show loading indicator when page starts loading
            setState(() {});
          },
          onPageFinished: (String url) {
            // Hide loading indicator when page finishes loading
            setState(() {
              EasyLoading.dismiss();
            });
          },
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://flutter.dev'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(children: [
      WebViewWidget(controller: controller),
      Positioned(
        top: 20,
        left: 20,
        child: InkWell(
          onTap: () {
            context.pop();
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: Colors.black.withOpacity(0.3)),
            child: const Icon(CupertinoIcons.chevron_back),
          ),
        ),
      ),
    ])));
  }
}
