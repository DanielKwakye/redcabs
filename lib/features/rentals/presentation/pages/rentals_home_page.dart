import 'package:flutter/material.dart';
import 'package:redcabs_mobile/core/utils/widget_view.dart';
import 'package:redcabs_mobile/features/rentals/presentation/widgets/all_cars_widget.dart';
import 'package:redcabs_mobile/features/rentals/presentation/widgets/my_rented_cars_widget.dart';

import '../../../../core/utils/sliver_appbar_tabbar_delegate.dart';
import '../../../../core/utils/theme.dart';
import '../../../shared/presentation/widgets/shared_sliver_app_bar.dart';


final List<Map<String, dynamic>> tabItems = [

  <String, dynamic>{
    'index': 0,
    'text': "All cars",
    'type': "all-cars"
  },
  <String, dynamic>{
    'index': 1,
    'text': 'My cars',
    'type': "my-cars"
  },

];

class RentalsHomePage extends StatefulWidget {

  const RentalsHomePage({Key? key}) : super(key: key);

  @override
  RentalsHomePageController createState() => RentalsHomePageController();
}

////////////////////////////////////////////////////////
/// View is dumb, and purely declarative.
/// Easily references values on the controller and widget
////////////////////////////////////////////////////////

class _RentalsHomePageView extends WidgetView<RentalsHomePage, RentalsHomePageController> {

  const _RentalsHomePageView(RentalsHomePageController state) : super(state);

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return  Scaffold(
        body: NestedScrollView(

          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [

              const SharedSliverAppBar(
                pageTitle: 'Car rentals',
                backgroundColor: kAppRed,
                pageTitleColor: kAppWhite,
                iconThemeColor: kAppWhite,
                pinned: true,
                centerTitle: true,
              ),

              /// Profile tab bars
              SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverAppBarTabBarDelegate(
                      tabBar: TabBar(
                        controller: state.tabController,
                        isScrollable: false,
                        indicatorColor: kAppRed,
                        indicatorWeight: 1,
                        unselectedLabelColor: theme.colorScheme.onSurface, // change unselected color with this
                        tabs: [
                          ...tabItems.map((e) => Tab(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(e['text'] as String,
                                  style: const TextStyle(fontWeight: FontWeight.w600),
                                ),
                                // const SizedBox(height: 2,),
                                // Text(e['sub_text'] as String, style: TextStyle(color: theme.colorScheme.onPrimary, fontWeight: FontWeight.normal),),
                              ],
                            ),
                          ))
                        ],
                      )
                  )),

              // const SliverToBoxAdapter(
              //   child: SizedBox(height: 20,),
              // )

            ];
          },

          body: TabBarView(
            controller: state.tabController,
            children: [
              ...tabItems.map((tabItem) {

                final type = tabItem['type'] as String;

                if (type == 'all-cars') {
                  // find companies widget here
                  return const AllCarsWidget();
                } else {
                  // by default display find work
                  return const MyRentedCarsWidget();
                }
              })
            ],
          ),


        )
    );

  }

}

////////////////////////////////////////////////////////
/// Controller holds state, and all business logic
////////////////////////////////////////////////////////

class RentalsHomePageController extends State<RentalsHomePage> with TickerProviderStateMixin {

  late TabController tabController;

  @override
  Widget build(BuildContext context) => _RentalsHomePageView(this);

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabItems.length, vsync: this);
  }


  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

}