// pull_to_refresh.dart

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PullToRefreshWidget extends StatelessWidget {
  final RefreshController refreshController;
  final Function()
      onRefresh; // Updated to make sure the function has no arguments
  final Function()
      onLoading; // Updated to make sure the function has no arguments
  final Widget child;

  PullToRefreshWidget({
    required this.refreshController,
    required this.onRefresh,
    required this.onLoading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      footer: ClassicFooter(),
      controller: refreshController,
      onRefresh: onRefresh, // Updated
      onLoading: onLoading, // Updated
      child: child,
    );
  }
}
