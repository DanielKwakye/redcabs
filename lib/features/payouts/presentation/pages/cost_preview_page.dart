import 'package:flutter/material.dart';

import '../../../../core/utils/functions.dart';
import '../../../../core/utils/theme.dart';
import '../../../shared/presentation/widgets/avatar_with_initals_widget.dart';
import '../../../shared/presentation/widgets/shared_sliver_app_bar.dart';


class CostPreviewPage extends StatelessWidget {
  final String title;
  final String total;
  final List<dynamic> items;
  const CostPreviewPage({Key? key, required this.title, required this.total, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              const SharedSliverAppBar(
                pageTitle: 'Cost Breakdown',
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
            child: CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                SliverList(
                    delegate: SliverChildBuilderDelegate((ctx, index) {
                      final cost = items[index];
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only( left: 15, right: 15, top: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(title, style: const TextStyle(fontWeight: FontWeight.w700, color: kAppGreen),),
                                Text(toCurrencyFormat(total), style: const TextStyle(fontWeight: FontWeight.w500, color: kAppRed),),
                              ],
                            ),
                          ),

                          Container(
                            margin: const EdgeInsets.only(
                                bottom: 5, left: 15, right: 15, top: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white),
                            child: ListTile(
                              leading: AvatarWithInitialsWidget(
                                name: cost['fieldNameDisplay'],
                                backgroundColor:
                                getChipCardColor(cost['fieldNameDisplay']),
                                foregroundColor: Colors.white,
                                onlyFirstLetter: true,
                              ),
                              // trailing: Icon(Icons.keyboard_arrow_right),
                              title: Text(
                                cost['fieldNameDisplay'],
                                style: const TextStyle(color: Colors.red),
                              ),
                              subtitle: Text(
                                cost['fieldValue'],
                                style: const TextStyle(
                                    color: Colors.black, fontWeight: FontWeight.w500),
                              ),
                              // onTap: () => state.getPayoutDetail(PayoutSectionType.income),
                            ),
                          ),
                        ],
                      );
                    }, childCount: items.length)),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 100,
                  ),
                )
              ],
            ),
          )),
    );
  }
}

