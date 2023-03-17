import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/utils/theme.dart';
import 'custom_card_widget.dart';

class ListTileShimmer extends StatelessWidget {

  final int count;
  final double verticalPadding;

  const ListTileShimmer({super.key, this.count: 3, this.verticalPadding = 21});

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: verticalPadding),
      child: CustomCardWidget(
        padding: 0,
        child: Shimmer.fromColors(
          baseColor: ash,
          highlightColor: lightGray,
          child: Column(
            children: <Widget>[
              for(int i = 0; i < count; i++)
                const ListTile(
                    leading: CircleAvatar(backgroundColor: ash,),
                    title: Text("Loading ...", style: TextStyle(color:  ash, fontWeight: FontWeight.bold, fontSize: 18),),
                    subtitle: Text("Loading ... ", style: TextStyle(color: ash, fontSize: 14),)
                ),
            ],
          ),
        ),
      ),
    );

  }
}
