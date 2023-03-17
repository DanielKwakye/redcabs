import 'package:flutter/material.dart';
import 'package:redcabs_mobile/features/shared/presentation/widgets/shared_circular_progress_loader.dart';

class LoadingPlaceholderWidget extends StatelessWidget {

  const LoadingPlaceholderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final media = MediaQuery.of(context);

    return Container(
      width: media.size.width,
      height: media.size.height/2,
      color: theme.colorScheme.background,
      child: Stack(
        children: const [
          Center(
            child: SharedCircularProgressLoader(showIcon: false,),
          ),
          // Align(
          //   alignment: Alignment.bottomCenter,
          //   child: LinearProgressIndicator(color: kAppRed, minHeight: 2),
          // ),
        ],
      ),
    );
  }
}
