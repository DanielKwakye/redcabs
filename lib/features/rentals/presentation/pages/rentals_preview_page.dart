import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redcabs_mobile/core/utils/functions.dart';
import 'package:redcabs_mobile/core/utils/theme.dart';
import 'package:redcabs_mobile/core/utils/widget_view.dart';
import 'package:redcabs_mobile/features/rentals/data/models/car_model.dart';
import 'package:redcabs_mobile/features/shared/presentation/widgets/shared_border_widget.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:separated_column/separated_column.dart';

import '../../../../core/utils/constants.dart';
import '../../data/models/car_specification.dart';

class RentalsPreviewPage extends StatefulWidget {

  final List<CarModel> list;
  final int initialPageIndex;
  const RentalsPreviewPage({
    required this.list,
    this.initialPageIndex = 0,
    Key? key}) : super(key: key);

  @override
  RentalsPreviewPageController createState() => RentalsPreviewPageController();
}

////////////////////////////////////////////////////////
/// View is dumb, and purely declarative.
/// Easily references values on the controller and widget
////////////////////////////////////////////////////////

class _RentalsPreviewPageView extends WidgetView<RentalsPreviewPage, RentalsPreviewPageController> {

  const _RentalsPreviewPageView(RentalsPreviewPageController state) : super(state);

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final size = sizeOfMediaQuery(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppRed,
        iconTheme: IconThemeData(color: theme.colorScheme.onBackground),
        automaticallyImplyLeading: false,
        elevation: 0,
        title: ValueListenableBuilder(valueListenable: state.currentIndex, builder: (_, index, __) {
          return Text(widget.list[index].name ?? '', style: const TextStyle(color: kAppWhite, fontSize: 14),);
        }),
        actions: const [
          CloseButton(color: kAppWhite,)
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(2),
          child: SharedBorderWidget()
        ),
      ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                   children: [
                      SizedBox(
                        height: size.height * 0.25,
                        child: _pageView(context),
                      ),
                      const SharedBorderWidget(),
                     ListTile(
                       title: Text('Specifications', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),),
                     ),
                      ValueListenableBuilder(valueListenable: state.selectedCarSpecification, builder: (_, specs, __) {

                        // if(specs == null || specs.isEmpty) {
                        //   return ListTile(
                        //     leading: Icon(Icons.info_outline, size: 20, color: theme.colorScheme.onBackground,),
                        //     title: Text('Specifications not available', style: TextStyle(color: theme.colorScheme.onBackground),),
                        //   );
                        // }
                        return SeparatedColumn(
                            separatorBuilder: (BuildContext context, int index) {
                              return const SharedBorderWidget();
                            },
                           children: [
                               ListTile(
                                 title: Text('Availability', style: TextStyle(color: theme.colorScheme.onBackground),),
                                 trailing:                         Container(
                                   decoration: BoxDecoration(
                                       color: widget.list[state.currentIndex.value].status == "available"?kAppGreen:kAppBlack,
                                       borderRadius: BorderRadius.circular(20)
                                   ),
                                   width: 70,
                                   height: 20,
                                   child:  Align(
                                       alignment: Alignment.center,
                                       child: Text(widget.list[state.currentIndex.value].status == "available" ? "Available" : "In-use",style: const TextStyle(
                                           color: kAppWhite,
                                           fontSize: 12,
                                           fontWeight: FontWeight.w500

                                       ),)),
                                 ),

                                 // Chip(label:  Text(widget.list[state.currentIndex.value].status == "available" ? "Available" : "Not Available",style: theme.textTheme.bodySmall
                                 //     ?.copyWith(fontSize: 9,color: Colors.white)),)

                                   // Text(widget.list[state.currentIndex.value].status ?? '', style: const TextStyle(color: kAppBlue, fontWeight: FontWeight.bold),),
                               ),
                              ...(specs ?? []).map((sp) {
                                return ListTile(
                                  title: Text(sp.title, style: TextStyle(color: theme.colorScheme.onBackground),),
                                  trailing: Text(sp.value, style: const TextStyle(color: kAppBlue, fontWeight: FontWeight.bold),),
                                );
                              })
                           ],
                        );

                      })
                   ],
                ),
              ),
            ),
            const SharedBorderWidget(),
            const Padding(
              padding: EdgeInsets.only(left: 15, top: 10, bottom: 15,),
              child: Text('Browse other cars', style: TextStyle(color: kAppRed, fontWeight: FontWeight.bold),),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ...widget.list.map((car) =>
                        ValueListenableBuilder(
                          valueListenable: state.currentIndex,
                          builder: (BuildContext context, int value, Widget? child) {
                            return  Container(
                              width: 80,
                              height: 80,
                              padding: const EdgeInsets.all(0),
                              margin: const EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(color:  value == widget.list.indexOf(car) ? kAppBlue : theme.colorScheme.outline),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: GestureDetector(
                                onTap: () => state._changeImage(widget.list.indexOf(car)),
                                child: CachedNetworkImage(
                                  imageUrl: car.mainImage ?? '',
                                  progressIndicatorBuilder: (context, url, downloadProgress) {
                                    return const Center(
                                        child: SizedBox(width: 20, height: 20, child: CupertinoActivityIndicator(),)
                                    );
                                  },
                                  errorWidget: (context, url, error) => Image.asset(kImageNotFound),
                                  cacheKey: car.mainImage ?? '',
                                ),
                              ),
                            );
                          },
                        )
                    )
                  ],
                ),
              ),
            ),
          ],
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

          final receiptItem = widget.list[index];
          final imageUrl = receiptItem.mainImage ?? "";
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
        itemCount: widget.list.length,
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

class RentalsPreviewPageController extends State<RentalsPreviewPage> {

  late ValueNotifier<int> currentIndex;
  late ValueNotifier<bool> enableSwipe;
  // late ValueNotifier<bool> enableDragToDismiss;
  late PageController _pageController;
  final ValueNotifier<List<CarSpecification>?> selectedCarSpecification = ValueNotifier(null);


  @override
  Widget build(BuildContext context) => _RentalsPreviewPageView(this);

  @override
  void initState() {
    super.initState();
    currentIndex = ValueNotifier(widget.initialPageIndex);
    enableSwipe = ValueNotifier(true);
    // enableDragToDismiss = ValueNotifier(true);
    _pageController = PageController(initialPage: widget.initialPageIndex);

    evaluateSpecifications();

  }

  void evaluateSpecifications() {
    final selectedCar = widget.list[currentIndex.value];
    selectedCarSpecification.value = List<CarSpecification>.from(json.decode(selectedCar.specifications ?? "").map((x) => CarSpecification(title: x['title'], value: x['value'])));
  }

  void _onPageChanged(int index){
    currentIndex.value = index;
    evaluateSpecifications();
  }

  void _changeImage(int index){
    _pageController.animateToPage(index, duration: const Duration(milliseconds: 375), curve: Curves.easeInOut);
  }


  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

}