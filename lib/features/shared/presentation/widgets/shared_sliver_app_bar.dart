import 'package:flutter/material.dart';
import 'package:redcabs_mobile/features/shared/presentation/widgets/shared_border_widget.dart';

class SharedSliverAppBar extends StatelessWidget{

  final String? pageTitle;
  final Color? pageTitleColor;
  final Color? iconThemeColor;

  final bool pinned;
  final List<Widget>? actions ;
  final Color? backgroundColor;
  final Widget? threadCreationIndicatorWidget;
  final bool showBorder;
  final bool showStatelessBorder;
  final Widget? leading;
  final bool centerTitle;

  const SharedSliverAppBar({Key? key,
    this.backgroundColor,
    this.pinned = false,
    this.showBorder = true,
    this.showStatelessBorder = false,
    this.threadCreationIndicatorWidget,
    this.pageTitle,
    this.pageTitleColor,
    this.iconThemeColor,
    this.leading,
    this.centerTitle = true,
    this.actions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverAppBar(
      iconTheme: IconThemeData(color: iconThemeColor ??  theme.colorScheme.onBackground,),
      pinned: pinned,
      leading: leading,
      elevation: 0.0,
      floating: !pinned ? true : false,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor ?? theme.colorScheme.background,
      title: Text(pageTitle ?? "", style: TextStyle(color: pageTitleColor ?? theme.colorScheme.onBackground,fontWeight: FontWeight.w600, fontSize: 15),),
      expandedHeight: kToolbarHeight,
      actions: actions,
      bottom: const PreferredSize(preferredSize: Size.fromHeight(2), child: SharedBorderWidget())
    );

  }



}
