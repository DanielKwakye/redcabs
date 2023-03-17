import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:go_router/go_router.dart';
import 'package:redcabs_mobile/core/utils/functions.dart';
import 'package:redcabs_mobile/core/utils/theme.dart';
import 'package:redcabs_mobile/core/utils/widget_view.dart';
import 'package:redcabs_mobile/features/f_admin/data/models/home_feature.dart';
import 'package:redcabs_mobile/features/home/presentation/widgets/dossier_widget.dart';

import '../../../../app/routing/route_constants.dart';
import '../../../home/presentation/widgets/home_app_bar_widget.dart';

class FAdminHomePage extends StatefulWidget {

  const FAdminHomePage({Key? key}) : super(key: key);

  @override
  FAdminHomePageController createState() => FAdminHomePageController();
}

////////////////////////////////////////////////////////
/// View is dumb, and purely declarative.
/// Easily references values on the controller and widget
////////////////////////////////////////////////////////

class _FAdminHomePageView extends WidgetView<FAdminHomePage, FAdminHomePageController> {

  const _FAdminHomePageView(FAdminHomePageController state) : super(state);

  @override
  Widget build(BuildContext context) {


    final theme = themeOf(context);

    return Scaffold(
        body: CustomScrollView(
            slivers: [
              const HomeAppBarWidget(),
              const SliverToBoxAdapter(
                child: DossierWidget(),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                  child: LayoutGrid(
                    // set some flexible track sizes based on the crossAxisCount
                    columnSizes: [1.fr, 1.fr],
                    // set all the row sizes to auto (self-sizing height)
                    rowSizes: const [auto, auto],
                    rowGap: 20,
                    // equivalent to mainAxisSpacing
                    columnGap: 10,
                    // equivalent to crossAxisSpacing
                    // note: there's no childAspectRatio
                    children: [
                      // render all the cards with *automatic child placement*
                      ...state.features.map((feature) {

                        return GestureDetector(
                          onTap: () {
                            if(feature.pageRoute == null ) {
                              return;
                            }

                            context.push(feature.pageRoute!);
                          },
                          child: Container(
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                              border: Border.all(color: theme.colorScheme.outline),
                              borderRadius: BorderRadius.circular(8),
                              color: feature.backgroundColor
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: theme.brightness == Brightness.dark ? theme.colorScheme.onBackground : theme.colorScheme.outline,
                                    foregroundColor: theme.colorScheme.onBackground,
                                    child:  Icon(feature.icon, size: 20, color: feature.backgroundColor,),
                                  ),
                                  const SizedBox(height: 40,),
                                  Text(feature.title, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700, color: kAppWhite),)
                                ],
                              ),
                            ),
                          ),
                        );

                      })

                    ],
                  ),
                ),
              )
            ],
        )
    );

  }

}

////////////////////////////////////////////////////////
/// Controller holds state, and all business logic
////////////////////////////////////////////////////////

class FAdminHomePageController extends State<FAdminHomePage> {

  final List<HomeFeature> features = [
      HomeFeature(title: 'Weekly payment',
        icon: FeatherIcons.folder,
        backgroundColor: const Color(0xffe15b5f),
        pageRoute: weeklyPayoutPageRoute
      ),
      HomeFeature(title: 'Tax financial statement',
          icon: FeatherIcons.book,
          backgroundColor: const Color(0xff343434),
          pageRoute: taxFinancialStatementPageRoute
      ),
      HomeFeature(title: 'Receipts upload',
          icon: FeatherIcons.cast,
          backgroundColor: const Color(0xff484848),
          pageRoute: receiptsPageRoute
      ),
      HomeFeature(
          title: 'Invoices and payments',
          icon: FeatherIcons.server,
          backgroundColor: const Color(0xfff0746e),
          pageRoute: invoicesPageRoute
      ),
  ];

  @override
  Widget build(BuildContext context) => _FAdminHomePageView(this);

  @override
  void initState() {
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
  }

}