import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/cupertino.dart';

class SharedRefreshIndicator extends StatefulWidget {

  final Widget child;
  final Future<void> Function() onRefresh;
  const SharedRefreshIndicator({
    required this.onRefresh,
    required this.child,
    Key? key}) : super(key: key);

  @override
  State<SharedRefreshIndicator> createState() => _SharedRefreshIndicatorState();
}

class _SharedRefreshIndicatorState extends State<SharedRefreshIndicator> {

  // final RefreshController _refreshController = RefreshController();

  @override
  void dispose() {
    super.dispose();
    // _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomRefreshIndicator(
      onRefresh: widget.onRefresh,
      builder: (BuildContext context, Widget child,
          IndicatorController controller) {
        return AnimatedBuilder(
          animation: controller,
          builder: (BuildContext context, _) {
            return Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                if (!controller.isIdle)
                  Positioned(
                    top: 35.0 * controller.value,
                    child: const SizedBox(
                      height: 30,
                      width: 30,
                      child: CupertinoActivityIndicator(
                        // backgroundColor: kAppLinearGradient.colors.first,
                        // color: kAppLinearGradient.colors[1],
                        // value: !controller.isLoading
                        //     ? controller.value.clamp(0.0, 1.0)
                        //     : null,
                      ),
                    ),
                  ),
                Transform.translate(
                  offset: Offset(0, 100.0 * controller.value),
                  child: child,
                ),
              ],
            );
          },
        );
      },
      child: widget.child,
    );
    // return SmartRefresher(
    //   onRefresh: widget.onRefresh,
    //   controller: _refreshController,
    //   enablePullUp: false,
    //   enablePullDown: true,
    //   child: widget.child,
    //
    // );

  }
}
