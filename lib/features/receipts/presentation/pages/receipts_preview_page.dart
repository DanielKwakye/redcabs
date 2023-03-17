import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:redcabs_mobile/core/utils/extensions.dart';
import 'package:redcabs_mobile/core/utils/theme.dart';
import 'package:redcabs_mobile/core/utils/widget_view.dart';
import 'package:redcabs_mobile/features/receipts/data/models/receipt_model.dart';
import 'package:redcabs_mobile/features/shared/presentation/widgets/shared_border_widget.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:separated_column/separated_column.dart';
import 'dart:convert' as convert;
import '../../../../core/utils/functions.dart';

class ReceiptsPreviewPage extends StatefulWidget {

  final ReceiptModel receipt;
  const ReceiptsPreviewPage({
    required this.receipt,
    Key? key}) : super(key: key);

  @override
  ReceiptsPreviewPageController createState() => ReceiptsPreviewPageController();
}

////////////////////////////////////////////////////////
/// View is dumb, and purely declarative.
/// Easily references values on the controller and widget
////////////////////////////////////////////////////////

class _ReceiptsPreviewPageView extends WidgetView<ReceiptsPreviewPage, ReceiptsPreviewPageController> {

  const _ReceiptsPreviewPageView(ReceiptsPreviewPageController state) : super(state);

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final size = sizeOfMediaQuery(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.background,
        iconTheme: IconThemeData(color: theme.colorScheme.onBackground),
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: const [
          CloseButton()
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(2),
          child: SharedBorderWidget()
        ),
      ),
        body: SingleChildScrollView(
          child: Column(
             children: [
               SizedBox(
                 height: size.height * 0.4,
                 child: _pageView(context),
               ),
                const SharedBorderWidget(),
               ListTile(
                 title: Text('Specifications', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),),
               ),
                SeparatedColumn(
                   separatorBuilder: (BuildContext context, int index) {
                     return const SharedBorderWidget();
                   },
                   children: [
                     ListTile(
                       title: Text('Status', style: TextStyle(color: theme.colorScheme.onBackground),),
                       subtitle: Text(widget.receipt.currentStatus ?? 'N/A', style: const TextStyle(color: kAppGreen),),
                     ),
                     ListTile(
                       title: Text('Comment', style: TextStyle(color: theme.colorScheme.onBackground),),
                       subtitle: Text(widget.receipt.currentStatusComment ?? 'N/A', style: const TextStyle(color: kAppGreen),),
                     ),
                     ListTile(
                       title: Text('Last updated', style: TextStyle(color: theme.colorScheme.onBackground),),
                       subtitle: Text(widget.receipt.statusUpdatedDate ?? 'N/A', style: const TextStyle(color: kAppGreen),),
                     ),
                     ...state.dataOnReceipt

                   ],
                )
             ],
          ),
        )
    );

  }


  Widget _pageView(BuildContext context) {

    final theme = Theme.of(context);

    return ValueListenableBuilder<bool>(valueListenable: state.enableSwipe, builder: (_, bool enableSwipeValue, __) {
      return PhotoViewGallery.builder(
        scrollPhysics: enableSwipeValue ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
        scaleStateChangedCallback: (scale) {
          debugPrint("photoview: scale state changed: $scale");
          state.enableSwipe.value = scale == PhotoViewScaleState.initial;
          // enableDragToDismiss.value = scale == PhotoViewScaleState.initial;
          // logger.i("enableDragToDismiss: ${enableDragToDismiss.value}");
        },
        builder: (BuildContext context, int index) {

          final receiptItem = widget.receipt;
          final imageUrl = receiptItem.filePath ?? "";
          final key = '$imageUrl-$index';

          return PhotoViewGalleryPageOptions(
            imageProvider: CachedNetworkImageProvider(
                imageUrl,
                cacheKey: imageUrl
            ),
            initialScale: PhotoViewComputedScale.contained,
            heroAttributes: PhotoViewHeroAttributes(tag: key),

          );
        },
        itemCount: [widget.receipt].length,
        loadingBuilder: (context, event) => const Center(
          child: CupertinoActivityIndicator(),
        ),
        backgroundDecoration: BoxDecoration(color: theme.colorScheme.background),
        pageController: state._pageController,
        onPageChanged: state._onPageChanged,
      );
    });
  }

}

////////////////////////////////////////////////////////
/// Controller holds state, and all business logic
////////////////////////////////////////////////////////

class ReceiptsPreviewPageController extends State<ReceiptsPreviewPage> {

  late ValueNotifier<int> currentIndex;
  late ValueNotifier<bool> enableSwipe;
  // late ValueNotifier<bool> enableDragToDismiss;
  late PageController _pageController;

  late List<ListTile> dataOnReceipt = [];


  @override
  Widget build(BuildContext context) => _ReceiptsPreviewPageView(this);

  @override
  void initState() {
    super.initState();
    currentIndex = ValueNotifier(0);
    enableSwipe = ValueNotifier(true);
    // enableDragToDismiss = ValueNotifier(true);
    _pageController = PageController(initialPage: 0);


    onWidgetBindingComplete(onComplete: (){
      if (kDebugMode) {
        print(widget.receipt.dataOnExtReceipts);
      }
      if(widget.receipt.dataOnExtReceipts != null && widget.receipt.dataOnExtReceipts !='') {
        final map = Map<String, String?>.from(
            convert.json.decode(widget.receipt.dataOnExtReceipts ?? ''));
        map.forEach((key, value) {
          dataOnReceipt.add(ListTile(
            title: Text(key.capitalize(), style: TextStyle(color: Theme
                .of(context)
                .colorScheme
                .onBackground),),
            subtitle: Text(value ?? 'N/A', style: const TextStyle(color: kAppGreen),),
          ),);
        });
        setState(() {});
      }
    });
  }

  void _onPageChanged(int index){
    currentIndex.value = index;
  }


  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

}