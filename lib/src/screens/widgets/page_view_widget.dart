import 'package:file_view_pager/src/extensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:photo_view/photo_view_gallery.dart';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PageViewWidget extends StatefulWidget {
  final List<String> listAttachment;
  final int initPosition;
  final Function(int position) onPageChanged;

  const PageViewWidget(
      {Key? key,
      required this.listAttachment,
      required this.initPosition,
      required this.onPageChanged})
      : super(key: key);

  @override
  _PageViewWidgetState createState() => _PageViewWidgetState();
}

class _PageViewWidgetState extends State<PageViewWidget> {
  late PageController _pageController;
  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useWideViewPort: false,
        domStorageEnabled: true,
        useHybridComposition: true,
        scrollBarStyle: AndroidScrollBarStyle.SCROLLBARS_INSIDE_OVERLAY,
        scrollbarFadingEnabled: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initPosition);
  }

  @override
  Widget build(BuildContext context) {
    return PhotoViewGallery(
      pageOptions: listPage(),
      pageController: _pageController,
      onPageChanged: widget.onPageChanged,
    );
  }

  Widget getWebViewInApp(String url) {
    return InAppWebView(
      initialUrlRequest: URLRequest(
          url: Uri.parse(url)),
      initialOptions: options,
      onWebViewCreated: (controller) {
        webViewController = controller;
      },
      androidOnPermissionRequest: (controller, origin, resources) async {
        return PermissionRequestResponse(
            resources: resources,
            action: PermissionRequestResponseAction.GRANT);
      },
      onConsoleMessage: (controller, consoleMessage) {
        debugPrint(consoleMessage.toString());
      },
      gestureRecognizers: {}..add(Factory<VerticalDragGestureRecognizer>(
          () => VerticalDragGestureRecognizer())),
      onLoadStop: (controller, urlLoad) async {
        String title = (await controller.getTitle()) ?? "";
        if (title.isEmpty) {
          controller.loadUrl(
              urlRequest: URLRequest(
                  url: Uri.parse(url)));
        } else {
          // hide open web button
          controller.evaluateJavascript(
              source: "javascript:(function() { "
                  "document.querySelector('[class=\"ndfHFb-c4YZDc-Wrql6b\"]').remove();})()");

          // hide zoom button
          controller.evaluateJavascript(
              source: "javascript:(function() { "
                  "document.querySelector('[class=\"ndfHFb-c4YZDc-q77wGc\"]').remove();})()");
        }
      },
    );
  }

  List<PhotoViewGalleryPageOptions> listPage() {
    return widget.listAttachment.map((e) {
      if (e.isImage) {
        return PhotoViewGalleryPageOptions(
          imageProvider: NetworkImage(e),
          minScale: PhotoViewComputedScale.contained,
          initialScale: PhotoViewComputedScale.contained * 0.9,
        );
      } else {
        return PhotoViewGalleryPageOptions.customChild(
            child: getWebViewInApp(
                "https://docs.google.com/gview?embedded=true&url=" + e),
            minScale: PhotoViewComputedScale.contained,
            initialScale: PhotoViewComputedScale.contained);
      }
    }).toList();
  }
}
