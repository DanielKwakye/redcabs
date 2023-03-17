import 'dart:async';

import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:redcabs_mobile/core/storage/app_storage.dart';
import 'package:redcabs_mobile/core/utils/enums.dart';
import 'package:redcabs_mobile/core/utils/widget_view.dart';
import 'package:redcabs_mobile/features/shared/presentation/widgets/shared_network_image_widget.dart';
import 'package:redcabs_mobile/features/shared/presentation/widgets/shared_text_field_widget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../app/routing/route_constants.dart';
import '../../../../core/mixins/file_upload_mixin.dart';
import '../../../../core/utils/functions.dart';
import '../../../../core/utils/theme.dart';
import '../../../shared/presentation/pages/select_date_range_page.dart';
import '../../../shared/presentation/widgets/shared_sliver_app_bar.dart';
import '../../data/store/receipt_cubit.dart';
import '../../data/store/receipt_state.dart';

class ReceiptsHomePage extends StatefulWidget {
  const ReceiptsHomePage({Key? key}) : super(key: key);

  @override
  ReceiptsHomePageController createState() => ReceiptsHomePageController();
}

////////////////////////////////////////////////////////
/// View is dumb, and purely declarative.
/// Easily references values on the controller and widget
////////////////////////////////////////////////////////

class _ReceiptsHomePageView
    extends WidgetView<ReceiptsHomePage, ReceiptsHomePageController> {
  const _ReceiptsHomePageView(ReceiptsHomePageController state) : super(state);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: state.onAddFileTapped,
          backgroundColor: kAppRed,
          child: const Icon(
            FeatherIcons.plus,
            color: kAppWhite,
          ),
        ),
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                const SharedSliverAppBar(
                  pageTitle: '',
                  backgroundColor: kAppRed,
                  pageTitleColor: kAppWhite,
                  centerTitle: false,
                  iconThemeColor: kAppWhite,
                  pinned: true,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 20, bottom: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Upload Receipts',
                          style: theme.textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          'This page shows all your uploaded receipts',
                          style: theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SharedTextFieldWidget(
                          label: 'Select Week',
                          placeHolder: '',
                          controller: state.dateController,
                          readOnly: true,
                          onTap: state.changeDateHandler,
                          suffix: const Icon(
                            Icons.keyboard_arrow_down_outlined,
                            size: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ];
            },
            // body: const Padding(
            //   padding: EdgeInsets.only(left: 15, right: 15),
            //   child: Text('Receipts will display here'),
            // ),
            body:
            BlocBuilder<ReceiptCubit, ReceiptState>(
                bloc: state._receiptCubit,
                builder: (ctx, receiptState) {
                  if (receiptState.status == BlocStatus.success) {
                    final images = (state.images ?? []).take(14);
                    if(images.isEmpty) {
                      return  Center(
                        child: Text('No receipt found...',style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w400),),
                      );
                    }

                    final receipts = (receiptState.data ?? []);

                    return StaggeredGrid.count(
                      crossAxisCount: 3,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                      children: [
                        ...receipts.map((receipt) {
                          int crossAxisCellCount = 1;
                          int mainAxisCellCount = 1;
                          // final index = state.images!.indexOf(image);

                          return StaggeredGridTile.count(
                            crossAxisCellCount: crossAxisCellCount,
                            mainAxisCellCount: mainAxisCellCount,
                            child: GestureDetector(
                                onTap: () {
                                  //_onImageTap(context, index);
                                  final index = receipts.indexOf(receipt);
                                  context.push(receiptDetailsPageRoute, extra: receipt);
                                },
                                child: Stack(
                                  children: [

                                    /// This is the actual image
                                    SizedBox(
                                      width: double.infinity,
                                      height: double.infinity,
                                      child: SharedNetworkImageWidget(imageUrl: receipt.filePath ??"",fit: BoxFit.fill,),
                                    ),

                                    /// Date uploaded
                                     Align(
                                      alignment: Alignment.bottomRight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 10),
                                        child: Text(receipt.createdAt ?? "N/A", style: const TextStyle(color: kAppWhite, fontSize: 10, fontWeight: FontWeight.bold), textAlign: TextAlign.end,),
                                      ),
                                    ),

                                    /// Status Icon (approved / rejected)
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 5, right: 5),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Icon(receipt.currentStatus =='approved'?Icons.check_circle:receipt.currentStatus =='pending'?Icons.warning_amber:FeatherIcons.x, size: 20, color: receipt.currentStatus =='approved'?Colors.green:receipt.currentStatus =='pending'?Colors.amber:Colors.redAccent,)
                                          ],
                                        ),
                                      ),
                                    )

                                  ],
                                )
                          ),
                          );
                        })
                      ],
                    );
                  }
                  return Shimmer.fromColors(
                    baseColor: theme.colorScheme.outline,
                    highlightColor: theme.colorScheme.outline.withOpacity(0.5),
                    child: StaggeredGrid.count(
                      crossAxisCount: 3,
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                      children: [
                        ...(state.images ?? []).map((image) {
                          int crossAxisCellCount = 1;
                          int mainAxisCellCount = 1;
                          // final index = state.images!.indexOf(image);

                          return StaggeredGridTile.count(
                            crossAxisCellCount: crossAxisCellCount,
                            mainAxisCellCount: mainAxisCellCount,
                            child: GestureDetector(
                                onTap: () {
                                  //_onImageTap(context, index);
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  color: theme.colorScheme.outline,
                                )),
                          );
                        })
                      ],
                    ),
                  );
       })));
  }
}

////////////////////////////////////////////////////////
/// Controller holds state, and all business logic
////////////////////////////////////////////////////////

class ReceiptsHomePageController extends State<ReceiptsHomePage> with FileUploadMixin{
  late ReceiptCubit _receiptCubit;
  late StreamSubscription<ReceiptState> listener;

  late List? images = List.generate(10, (index) => index);
  final dateController = TextEditingController();
  String startDate = '';
  String displayStartDate = '';
  String endDate = '';
  String displayEndDate = '';

  @override
  Widget build(BuildContext context) => _ReceiptsHomePageView(this);

  @override
  void initState() {
    super.initState();
    // dateController.text = 'Week 08, 2023';

    final user = AppStorage.currentUserSession!;
    startDate = user.startWeek!;
    displayStartDate = DateFormat('dd MMM, yyyy').format(DateTime.parse(user.startWeek!));
    endDate = user.endWeek!;
    displayEndDate = DateFormat('dd MMM, yyyy').format(DateTime.parse(user.endWeek!));
    dateController.text = "$displayStartDate - $displayEndDate";

    _receiptCubit = context.read<ReceiptCubit>();
    listener = _receiptCubit.stream.listen((event) async {
      if (event.status == BlocStatus.error) {
        showSnackBar(context, event.message);
      }
      if (event.status == BlocStatus.success) {
        images = event.data;
      }
    });

    fetchReceipts();

  }

  @override
  void dispose() {
    super.dispose();
    dateController.dispose();
    listener.cancel();
  }

  Future<void> fetchReceipts() async {
      _receiptCubit.fetchReceipts(from: startDate, to: endDate);
  }

  void changeDateHandler() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor:  Colors.transparent,
      builder: (c) =>  GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => context.pop(),
        child: DraggableScrollableSheet(
            initialChildSize: 0.5,
            maxChildSize: 0.9,
            builder: (_ , controller) {
              return  SelectDateRangePage(onDatePicked: onDateChanged, enforceWeekSelection: true,);
            }
        ),
      ),
      // bounce: true
      // useRootNavigator: true,
      // expand: false
    );
  }

  // when another date is selected
  void onDateChanged(PickerDateRange? datePicked) {
    if(datePicked == null) return;

    startDate = DateFormat('yyyy-MM-dd').format(datePicked.startDate!);
    displayStartDate =
        DateFormat('dd MMM, yyyy').format(datePicked.startDate!);
    endDate = DateFormat('yyyy-MM-dd').format(datePicked.endDate!);
    displayEndDate = DateFormat('dd MMM, yyyy').format(datePicked.endDate!);

    dateController.text = "$displayStartDate - $displayEndDate";

    fetchReceipts();
  }

  void onAddFileTapped() {
    displaySelectFileOptions(context, onFilePicked: (file) {
      // first display modal sheet to choose where to select file from

      displayConfirmImageUpload(context, file, () {
        // begin File upload here ....///
        _uploadFile(file);
      });
    }, onlyImage: true);
  }

  Future<void> _uploadFile(file) async {
    _receiptCubit.uploadReceipt( file: file);
  }


}
