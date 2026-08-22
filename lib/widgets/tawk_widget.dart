import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Visitor data passed to the Tawk.to chat widget.
class TawkVisitor {
  final String? name;
  final String? email;
  final String? hash;

  const TawkVisitor({this.name, this.email, this.hash});
}

/// Local replacement for the abandoned `flutter_tawk` package.
/// Uses the modern `webview_flutter` 4.x `WebViewController` API.
class Tawk extends StatefulWidget {
  /// Tawk.to direct chat link (from your dashboard).
  final String directChatLink;

  /// Optional visitor name / email shown to support agents.
  final TawkVisitor? visitor;

  /// Called once the chat finishes loading.
  final VoidCallback? onLoad;

  /// Called when the user taps a link inside the chat.
  final void Function(String url)? onLinkTap;

  /// Widget shown while the chat is loading.
  final Widget? placeholder;

  const Tawk({
    super.key,
    required this.directChatLink,
    this.visitor,
    this.onLoad,
    this.onLinkTap,
    this.placeholder,
  });

  @override
  State<Tawk> createState() => _TawkState();
}

class _TawkState extends State<Tawk> {
  late final WebViewController _controller;
  bool _isLoading = true;

  /// Inject visitor attributes into the Tawk.to JS API once the page loads.
  void _setUser(TawkVisitor visitor) {
    final map = <String, dynamic>{};
    if (visitor.name != null) map['name'] = visitor.name;
    if (visitor.email != null) map['email'] = visitor.email;
    if (visitor.hash != null) map['hash'] = visitor.hash;

    if (map.isEmpty) return;

    final json = jsonEncode(map);
    _controller.runJavaScript('''
      var _tawk_attributes = $json;
      if (typeof Tawk_API !== "undefined") {
        Tawk_API.setAttributes(_tawk_attributes, function (error) {});
      }
    ''');
  }

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) {
            if (widget.visitor != null) {
              _setUser(widget.visitor!);
            }
            setState(() => _isLoading = false);
            widget.onLoad?.call();
          },
          onNavigationRequest: (NavigationRequest request) {
            final url = request.url;
            if (!url.contains('tawk.to')) {
              widget.onLinkTap?.call(url);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.directChatLink));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(controller: _controller),
        if (_isLoading)
          widget.placeholder ??
              const Center(child: CircularProgressIndicator()),
      ],
    );
  }
}
