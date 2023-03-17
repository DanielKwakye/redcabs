import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:redcabs_mobile/features/shared/presentation/widgets/shared_border_widget.dart';

import '../../../../core/utils/enums.dart';
import '../../../../core/utils/functions.dart';
import '../../../../core/utils/theme.dart';
import '../../../../core/utils/widget_view.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BrowserPage extends StatefulWidget {

  final String url;
  const BrowserPage({
    required this.url,
    Key? key
  }) : super(key: key);

  @override
  BrowserPageController createState() => BrowserPageController();
}

////////////////////////////////////////////////////////
/// View is dumb, and purely declarative.
/// Easily references values on the controller and widget
////////////////////////////////////////////////////////

class _BrowserPageView extends WidgetView<BrowserPage, BrowserPageController> {

  const _BrowserPageView(BrowserPageController state) : super(state);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: theme.colorScheme.onBackground,),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: theme.colorScheme.background,
        title: Text("", style: TextStyle(color: theme.colorScheme.onBackground, fontSize: 14),),
        bottom: const PreferredSize(
            preferredSize:   Size.fromHeight(2),
            child: SharedBorderWidget()
        ),
      ),
      body: Stack(
        children: [

          WebViewWidget(
            key:  UniqueKey(),
            controller: state._webViewController,
          ),

          ValueListenableBuilder<bool>(
              valueListenable: state.loading,
              builder: (ctx, val, ch) {
                return val ? ch!: const SizedBox.shrink();
              },
              child:  const Center(
                child: CircularProgressIndicator(
                  color: kAppBlue,strokeWidth: 2,
                ),
              )
          ),
        ],
      ),
    );
  }


}

////////////////////////////////////////////////////////
/// Controller holds state, and all business logic
////////////////////////////////////////////////////////

class BrowserPageController extends State<BrowserPage> {

  ValueNotifier<bool> loading = ValueNotifier(false);
  final _key = UniqueKey();
  late String token ;
  // here we checked the url state if it loaded or start Load or abort Load
  late WebViewController _webViewController;

  @override
  Widget build(BuildContext context) => _BrowserPageView(this);

  @override
  void initState() {
    super.initState();

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..setUserAgent("random")
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
             loading.value = true;
          },
          onPageFinished: (String url) {
              loading.value = false;
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint(error.description);
            if(error.errorCode == -1009){
              showSnackBar(context, 'The Internet connection appears to be offline.', appearance:  Appearance.error);
              context.pop();
            }
          },

        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }



}