import 'package:flutter/material.dart';

import '../../../../core/utils/enums.dart';

class SharedErrorWidget extends StatelessWidget {

  final VoidCallback? onRefreshTapped;
  final String? message;
  final SharedErrorType errorType;
  const SharedErrorWidget({
    this.onRefreshTapped,
    this.message,
    this.errorType = SharedErrorType.error,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final media = MediaQuery.of(context);

    return Container(
      width: media.size.width,
      height: media.size.height,
      color: theme.colorScheme.background,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.info_outline, color: theme.colorScheme.onBackground, size: 35,),
            const SizedBox(height: 10,),
            Text(message ?? (errorType == SharedErrorType.empty ? 'This place looks empty' : 'Please check your connection and tap on the refresh button below to reload'),
              textAlign: TextAlign.center,
              style: TextStyle(color: theme.colorScheme.onBackground),),
           if(onRefreshTapped != null) ... {
             const SizedBox(height: 10,),
             TextButton.icon(onPressed: () {
               onRefreshTapped?.call();
             }, icon: Icon(Icons.refresh, color: theme.colorScheme.onBackground,), label: Text('Refresh', style: TextStyle(color: theme.colorScheme.onBackground),))
           }
          ],
        ),
      ),
    );
  }

}
