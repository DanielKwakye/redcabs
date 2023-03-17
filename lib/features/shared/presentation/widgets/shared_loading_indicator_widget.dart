import 'package:flutter/material.dart';
import 'package:redcabs_mobile/core/utils/extensions.dart';
import 'package:redcabs_mobile/features/shared/presentation/widgets/shared_circular_progress_loader.dart';
import '../../../../core/utils/functions.dart';

/// loading indicator with some sort of animation
class SharedLoadingIndicatorWidget extends StatefulWidget {
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool loading;
  final Widget child;
  final String? message;
  final double opacity;
  final Color? assetColor;
  final int animationDuration;

  const SharedLoadingIndicatorWidget({
    Key? key,
    required this.child,
    this.backgroundColor,
    this.foregroundColor,
    this.loading = false,
    this.message,
    this.opacity = 0.5,
    this.assetColor,
    this.animationDuration = 300

  }) : super(key: key);

  @override
  State<SharedLoadingIndicatorWidget> createState() => _SharedLoadingIndicatorWidgetState();
}

class _SharedLoadingIndicatorWidgetState extends State<SharedLoadingIndicatorWidget>
    with TickerProviderStateMixin {
  var _overlayVisible = false;
  late final AnimationController _controller = AnimationController(
      vsync: this, duration: Duration(milliseconds: widget.animationDuration));
  late Animation<double> _animation;


  @override
  void initState() {
    super.initState();
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    onWidgetBindingComplete(onComplete: (){
      if(mounted) {
        _animation.addStatusListener((status) {
          status == AnimationStatus.forward
              ? setState(() => _overlayVisible = true)
              : null;
          status == AnimationStatus.dismissed
              ? setState(() => _overlayVisible = false)
              : null;
        });
        if (widget.loading) _controller.forward();
      }
    });
  }

  @override
  void didUpdateWidget(SharedLoadingIndicatorWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!oldWidget.loading && widget.loading) {
      _controller.forward();
    }

    if (oldWidget.loading && !widget.loading) {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    super.dispose();
    if(mounted) {
      _controller.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        /// underlying UI
        Positioned.fill(child: widget.child),

        /// loading indicator semi-opaque background
        if (_overlayVisible) ...{
          FadeTransition(
            opacity: _animation,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Opacity(
                    opacity: widget.opacity,
                    child: ModalBarrier(
                      dismissible: false,
                      color: widget.backgroundColor ?? theme.colorScheme.primary,
                    ),
                  ),
                ),

                /// loading indicator
                Positioned.fill(child: Center(child: _indicator(theme),)),
              ],
            ),
          ),
        },
      ],
    );
  }

  Widget _indicator(ThemeData theme) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SharedCircularProgressLoader(),
          if (!widget.message.isNullOrEmpty()) ...{
            Text(widget.message!, style: TextStyle(color: theme.colorScheme.onBackground),)

          }
        ],
      );
}
