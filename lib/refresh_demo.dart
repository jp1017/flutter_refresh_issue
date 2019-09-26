import 'package:flutter/material.dart';
import 'package:flutter_refresh_issue/base/base_pull_refresh.dart';
import 'package:flutter_refresh_issue/colors.dart';
import 'package:flutter_refresh_issue/resp/base.dart';
import 'package:flutter_refresh_issue/resp/receipt.dart';

class HxTab4 extends StatefulWidget {
  @override
  _HxTab4State createState() => _HxTab4State();
}

class _HxTab4State extends BaseListState<ListEntity, HxTab4> {
  @override
  void init() {
    canBack = false;

    loadMore = true;

    super.init();
  }


  String getTitle() {
    return '刷新ISSUE';
  }

  @override
  List setManData() {
    return [MerchantListData(), MerchantListData()];
  }

  @override
  Widget buildRow(BuildContext context, entity, int index) {
    MerchantListData listData = entity;

    return Container(
      color: Colours.white,
      child: Column(
        children: <Widget>[
          Padding(
            padding:
                const EdgeInsets.only(left: 15, top: 12, bottom: 12, right: 6),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        '1',
                      ),
                    ),
                    Text(
                      '2元',
                    ),
                  ],
                )),
                Row(
                  children: <Widget>[
                    Text(
                      '11',
                      style: TextStyle(
                          color: Colours.green_14BA89,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
//                    showAsset(listData.increase() ? 'ic_up' : 'ic_down', width: 28),
                    Icon(
                      Icons.chevron_right,
                      color: Colours.bg_b7,
                    )
                  ],
                ),
              ],
            ),
          ),
          Divider(height: 0, color: Colours.bg_d5),
        ],
      ),
    );
  }

  @override
  getRequestParam() async {
    Map<String, dynamic> map = {
      'user_id': '666',
    };

    return map;
  }

  @override
  String requestPath() {
    return '666';
  }

  @override
  bool keepAlive() {
    return true;
  }
}
