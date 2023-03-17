import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:redcabs_mobile/core/storage/app_storage.dart';
import 'package:redcabs_mobile/core/utils/functions.dart';

class DossierWidget extends StatelessWidget {
  const DossierWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = AppStorage.currentUserSession;
    // if (kDebugMode) {
    //   print(user?.driverInfo);
    //
    // }
    final theme = themeOf(context);

    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 20),
      child: DecoratedBox(decoration: BoxDecoration(
        border: Border.all(color: theme.colorScheme.outline),
        borderRadius: BorderRadius.circular(8),
        // color: theme.colorScheme.surface.withOpacity(0.5)
      ), child: Padding(
        padding: const EdgeInsets.all(30),
        child: IntrinsicHeight(
          child: Row(
             children: [
                Expanded(child: Column(
                   children: [
                      Text('Dossier', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),),
                      Text(user?.dossier??'N/A', style: theme.textTheme.bodyMedium?.copyWith(),)
                   ],
                )),
                Container(
                  width: 1,
                  color: theme.colorScheme.outline,
                ),
                Expanded(child: Column(
                  children: [
                    Text('Partner type', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),),
                    Text(user?.driverInfo?['service_type'] !=  null ? formatServiceToReadable(user?.driverInfo?['service_type']): 'N/A', style: theme.textTheme.bodyMedium?.copyWith(),)
                  ],
                )),
             ],
          ),
        ),
      ),),
    );
  }
}
