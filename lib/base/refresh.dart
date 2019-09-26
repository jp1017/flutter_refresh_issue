/// 上下拉刷新

import 'package:flutter/material.dart';
import 'package:flutter_refresh_issue/colors.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// 下拉刷新
Widget buildHeader() {
    return ClassicHeader(
        releaseText: '释放后刷新',
        refreshingText: '加载中',
        completeText: '加载完成',
        failedText: '加载失败',
        idleText: '下拉刷新',
        refreshingIcon: const SizedBox(
            width: 25.0,
            height: 25.0,
            child: const CircularProgressIndicator(
                strokeWidth: 2.0,
                valueColor: AlwaysStoppedAnimation(Colours.primary))));
  }

/// 上拉刷新
  Widget buildFooter() {
    return ClassicFooter(
      loadingText: '加载中',
      loadingIcon: SizedBox(
        width: 25.0,
        height: 25.0,
        child: const CircularProgressIndicator(
            strokeWidth: 2.0,
            valueColor: AlwaysStoppedAnimation(Colours.primary)),
      ),
      noDataText: '没有更多啦',
      idleText: '下拉刷新',
    );
  }

/// 空数据、网络异常占图
Widget getDataBody(bool isFirst,bool loadErr, bool msgError) {
    if (isFirst) {
      if (loadErr) {
        return getEmptyStatus(true);
      } else if (msgError){
        return getEmptyStatus(false);
      } else {
        return CircularProgressIndicator(
          strokeWidth: 3.0,
          valueColor: new AlwaysStoppedAnimation<Color>(Colours.primary),
        );
      }
    } else {
      return getEmptyStatus(false);
    }
  }

   Widget getEmptyStatus(bool net){
    return Column(
      children: <Widget>[
        Icon(Icons.hourglass_empty),
        Text(net? '没有可用的网络' : "暂无数据")
      ],
    );
  }