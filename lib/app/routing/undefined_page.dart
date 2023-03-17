import 'package:flutter/material.dart';
import 'package:redcabs_mobile/features/shared/presentation/widgets/shared_error_widget.dart';

class UndefinedPage extends StatelessWidget {
  const UndefinedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.colorScheme.background,
        iconTheme: IconThemeData(color: theme.colorScheme.onBackground),
      ),
      body: const Center(
        child: SharedErrorWidget(message: 'Page not found',),
      ),
    );

  }
}
