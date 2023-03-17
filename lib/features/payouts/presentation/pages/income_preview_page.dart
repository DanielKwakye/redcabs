import 'package:flutter/material.dart';
import 'package:redcabs_mobile/core/utils/widget_view.dart';

import '../../../../core/utils/enums.dart';
import '../../../../core/utils/functions.dart';
import '../../../../core/utils/theme.dart';
import '../../../shared/presentation/widgets/animated_column_widget.dart';
import '../../../shared/presentation/widgets/avatar_with_initals_widget.dart';
import '../../../shared/presentation/widgets/shared_sliver_app_bar.dart';

class IncomePreviewPage extends StatelessWidget {
  final String title;
  final String total;
  final List<dynamic> list;
  const IncomePreviewPage({Key? key, required this.title, required this.total, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              const SharedSliverAppBar(
                pageTitle: 'Income Breakdown',
                backgroundColor: kAppRed,
                pageTitleColor: kAppWhite,
                centerTitle: false,
                iconThemeColor: kAppWhite,
                pinned: true,
              ),
              // const HomeAppBarWidget(),
            ];
          },
          body: Container(
            color: gray,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 5),
              child: AnimatedColumnWidget(
                animateType: AnimateType.slideUp,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title, style: const TextStyle(fontWeight: FontWeight.w700, color: kAppGreen),),
                      Text(toCurrencyFormat(total), style: const TextStyle(fontWeight: FontWeight.w500, color: kAppRed),),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  ...list.map((e) => Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white),
                    child: ListTile(
                      leading: AvatarWithInitialsWidget(
                        name: e['name'],
                        backgroundColor: getChipCardColor(e['name']),
                        foregroundColor: Colors.white,
                        onlyFirstLetter: true,
                      ),
                      title: Text(
                        e['name'],
                        style: const TextStyle(color: Colors.red),
                      ),
                      subtitle: Text(toCurrencyFormat(e['calculatedIncome'].toString()), style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w500),),
                      onTap: () {},
                    ),
                  ))
                ],
              ),
            ),
          )),
    );
  }
}
