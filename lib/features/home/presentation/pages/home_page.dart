import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:redcabs_mobile/app/routing/route_constants.dart';
import 'package:redcabs_mobile/core/utils/theme.dart';
import 'package:redcabs_mobile/core/utils/widget_view.dart';
import 'package:redcabs_mobile/features/shared/presentation/widgets/shared_border_widget.dart';

class HomePage extends StatefulWidget {

  final Widget child;
  const HomePage({required this.child, Key? key}) : super(key: key);

  @override
  HomePageController createState() => HomePageController();
}

////////////////////////////////////////////////////////
/// View is dumb, and purely declarative.
/// Easily references values on the controller and widget
////////////////////////////////////////////////////////

class _HomePageView extends WidgetView<HomePage, HomePageController> {


  const _HomePageView(HomePageController state) : super(state);

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    return Scaffold(
        body: widget.child,
        bottomNavigationBar: Column(
           mainAxisSize: MainAxisSize.min,
           children: [
             const SharedBorderWidget(),
             Theme(
               data: theme.copyWith(splashColor: Colors.transparent, highlightColor: Colors.transparent),
               child: BottomNavigationBar(
                 items:  const <BottomNavigationBarItem>[
                   BottomNavigationBarItem(
                     icon: Icon(FeatherIcons.home),
                     label: 'F. Administration',
                   ),
                   BottomNavigationBarItem(
                     icon: Icon(FeatherIcons.messageCircle),
                     label: 'Chat',
                   ),

                   BottomNavigationBarItem(
                     icon: Icon(FeatherIcons.sliders),
                     label: 'Rentals',
                   ),
                 ],
                 currentIndex: state._calculateSelectedIndex,
                 onTap: state._onItemTapped,
                 backgroundColor: theme.colorScheme.background,
                 iconSize: 20,
                 selectedItemColor: kAppRed,
                 elevation: 0,
                 selectedLabelStyle: const TextStyle(fontSize: 12, height: 1.8),
                 unselectedLabelStyle: const TextStyle(fontSize: 12, height: 1.8),

               ),
             )
           ],
        ),


    );

  }

}

////////////////////////////////////////////////////////
/// Controller holds state, and all business logic
////////////////////////////////////////////////////////

class HomePageController extends State<HomePage> {


  ///these are KEYS which are assigned to every Tab,
  ///the problem of navigation is solved by these KEYS

  @override
  Widget build(BuildContext context) => _HomePageView(this);

  @override
  void initState() {
    super.initState();

  }

  int get _calculateSelectedIndex {
    final GoRouter route = GoRouter.of(context);
    final String location = route.location;
    if (location == fAdminPageRoute) {
      return 0;
    }
    if (location.startsWith(chatPageRoute)) {
      return 1;
    }
    if (location.startsWith(rentalsPageRoute)) {
      return 2;
    }
    return 0;
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        context.go(fAdminPageRoute);
        break;
      case 1:
        context.go(chatPageRoute);
        break;
      case 2:
        context.go(rentalsPageRoute);
        break;
    }
  }

  // void _switchToTab(index){
  //   tabController.index = index;
  // }

  @override
  void dispose() {
    super.dispose();
  }

}