import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:redcabs_mobile/core/utils/theme.dart';
import 'package:redcabs_mobile/core/utils/widget_view.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class SelectDateRangePage extends StatefulWidget {

  final bool enforceWeekSelection;
  final void Function(PickerDateRange?)? onDatePicked;
  const SelectDateRangePage({
    this.onDatePicked,
    this.enforceWeekSelection = false,
    Key? key}) : super(key: key);

  @override
  SelectDateRangePageController createState() => SelectDateRangePageController();
}

////////////////////////////////////////////////////////
/// View is dumb, and purely declarative.
/// Easily references values on the controller and widget
////////////////////////////////////////////////////////

class _SelectDateRangePageView extends WidgetView<SelectDateRangePage, SelectDateRangePageController> {

  const _SelectDateRangePageView(SelectDateRangePageController state) : super(state);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          actions: [
            TextButton(onPressed: state.onDoneTapped, child: const Text('Done', style: TextStyle(color: kAppBlue),))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SfDateRangePicker(
            controller: state._controller,
            view: DateRangePickerView.month,
            selectionMode: DateRangePickerSelectionMode.range,
            onSelectionChanged: state.selectionChanged,
            monthViewSettings: const DateRangePickerMonthViewSettings(
              enableSwipeSelection: false,
              firstDayOfWeek: DateTime.monday,
            ),
          ),
        )
    );

  }

}

////////////////////////////////////////////////////////
/// Controller holds state, and all business logic
////////////////////////////////////////////////////////

class SelectDateRangePageController extends State<SelectDateRangePage> {

  final DateRangePickerController _controller = DateRangePickerController();
  DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

  @override
  Widget build(BuildContext context) => _SelectDateRangePageView(this);

  @override
  void initState() {
    super.initState();
  }


  void selectionChanged(DateRangePickerSelectionChangedArgs args) {

    if (kDebugMode) {
      print("args value: ${args.value}");
    }

    if(widget.enforceWeekSelection) {
      PickerDateRange ranges = args.value;
      final startDate = ranges.startDate;

      if(startDate == null) return;

      final startOfWeek = getDate(startDate.subtract(Duration(days: startDate.weekday - 1)));
      final endOfWeek = getDate(startDate.add(Duration(days: DateTime.daysPerWeek - startDate.weekday)));

      if (kDebugMode) {
        print("firstDayOfWeek: ${startOfWeek.toIso8601String()}, endDayOfWeek => ${endOfWeek.toIso8601String()}");
      }
      _controller.selectedRange = PickerDateRange(startOfWeek, endOfWeek);
    }


  }

  void onDoneTapped() {
    widget.onDatePicked?.call(_controller.selectedRange);
    context.pop();
  }


  @override
  void dispose() {
    super.dispose();
  }

}