import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:redcabs_mobile/features/notifications/data/data/models/notification_model.dart';

class NotificationItemWidget extends StatelessWidget {

  final NotificationModel notificationModel;

  const NotificationItemWidget({
    required this.notificationModel,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    final date = notificationModel.createdAt != null ? DateFormat('dd-MMM-yyyy').add_jm().format(notificationModel.createdAt!) : 'N/A';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
       children: [
          Container(
              width: 10,
              height: 10,
              margin: const EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: theme.colorScheme.outline
              )
          ),
         const SizedBox(width: 20,),
         Expanded(child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Row(
                 crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Text(notificationModel.messageType ?? '', style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),),),
                    Text(date, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.normal, fontSize: 12),),
                  ],
               ),
               const SizedBox(height: 10,),
               Text(notificationModel.message ?? "", style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.normal, height: 1.5),)
            ],
         ))
       ],
    );
  }
}
