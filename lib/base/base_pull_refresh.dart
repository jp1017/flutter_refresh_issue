import 'package:flutter/material.dart';
import 'package:flutter_refresh_issue/base/base_state.dart';
import 'package:flutter_refresh_issue/base/refresh.dart';
import 'package:flutter_refresh_issue/colors.dart';
import 'package:flutter_refresh_issue/resp/base.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class BaseListState<R extends ListEntity, T extends StatefulWidget>
    extends BaseState<T> {
  List listData = [];
  R allResp;
  var curPage = 1;
  final RefreshController _controller = RefreshController();

  int maxCount = 4;

  Color bgColor;
  bool loadMore; //是否加载更多
  bool refresh; //是否下拉加载
  bool hasDecoration = false;

  bool msgError = false;

  Widget getHeader() {
    return null;
  }

  @override
  void init() {
    _loadingData(false);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  bool isFirst = true;
  bool loadErr = false;

  Widget getBody() {
    return listData.isEmpty
        ? ListView(children: [
            Center(
                child: Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: getDataBody(isFirst, loadErr, msgError)))
          ])
        : buildListViewBuilder(context, listData);
  }

  Widget getListBody() {
    return RefreshConfiguration(
//      hideFooterWhenNotFull: true,
/*      shouldFooterFollowWhenNotFull: (LoadStatus status) {
        if (status == LoadStatus.noMore) {
          return true;
        }
        return false;
      },*/
      headerTriggerDistance: 60,
      headerBuilder: buildHeader,
      footerBuilder: buildFooter,
      child: Container(
        decoration: BoxDecoration(
            color: bgColor ?? Colours.white,
            borderRadius: hasDecoration
                ? BorderRadius.only(
                    topLeft: Radius.circular(15), topRight: Radius.circular(15))
                : null),
//        height: ScreenUtil.getInstance().screenHeight,
        child: SmartRefresher(
            enablePullUp: loadMore ?? true,
            enablePullDown: refresh ?? true,
            controller: _controller,
            onRefresh: pullToRefresh,
            onLoading: loadingMore,
            child: getBody()),
      ),
    );
  }

  Widget getWidgetBody() {
    return null;
  }

  @override
  Widget getWidget(BuildContext context) {
    return getWidgetBody() ?? getListBody();
  }

  _loadingData(bool isLoadMore) async {
/*    Map<String, dynamic> map = await getRequestParam();

    if (map == null) {
      _controller.refreshCompleted();
      _controller.loadNoData();

      setState(() {
        isFirst = false;
        setData(null);
      });
      return;
    }*/

    isFirst = false;
    loadErr = false;
    msgError = false;

    List resp = setManData();

/*    if (data is List) {
      resp = data;
    } else {
      resp = ListEntity.fromJson(data).getList();
    }*/

    if (resp == null) {
        print('list为null');
      return;
    }

    if (isLoadMore) {
      addData(resp);
    } else {
      setData(resp);
    }

    refreshUi();

    if (isLoadMore) {
      if (resp.isEmpty || listData.length >= maxCount) {
        _controller.loadNoData();
      } else {
        _controller.loadComplete();
      }
    } else {
      _controller.refreshCompleted();
    }
  }

  void addData(List t) {
    listData.addAll(t);
  }

  void setData(List t) {
    listData = t;
  }

  List setManData();

  void pullToRefresh() {
/*    //正在加载时，不用刷新,有bug，商户筛选点取消后不刷新
    if (isFirst){
      return;
    }*/
    curPage = 1;
    _controller.resetNoData();
    _loadingData(false);
  }

  void loadingMore() {
    curPage++;
    _loadingData(true);
  }

  Widget buildListViewBuilder(context, List results) {
    return getOtherList(context, results) ??
        ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: results.isEmpty
              ? 0
              : results.length + (getHeader() != null ? 1 : 0),
          itemBuilder: (context, i) {
            if (getHeader() != null) {
              if (i == 0) {
                return getHeader();
              } else {
                return buildRow(context, results[i - 1], i - 1);
              }
            } else {
              return buildRow(context, results[i], i);
            }
          },
        );
  }

  Future<Map<String, dynamic>> getRequestParam();

  String requestPath();

  Widget buildRow(BuildContext context, dynamic entity, int index);

  /// 其他列表格式, 可折叠或 [GridView]
  Widget getOtherList(BuildContext context, List list) {
    return null;
  }
}
