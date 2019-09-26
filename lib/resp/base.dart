class BaseResp {
  String msg;
  String success;
  String isLogin;
  String isAuthEx;
  dynamic data;
  dynamic ex;

  BaseResp();

  BaseResp.fromJson(Map<String, dynamic> map)
      : msg = map['msg'],
        success = map['success'],
        isLogin = map['isLogin'],
        data = map['data'],
        ex = map['ex'],
        isAuthEx = map['isAuthEx'];

  bool isSuccess() {
    return 'true' == success;
  }

  bool login() {
    return 'true' == isLogin;
  }

  dynamic getData() {
    return data;
  }
}

class ListEntity {
  List listData;
  List dataList;
  String dataTotal;

  ListEntity.fromJson(Map<String, dynamic> map)
      : listData = map['data'],
        dataList = map['dataList'],
        dataTotal = map['dataTotal'];

  dynamic getList() {
    if (listData != null) {
      return listData;
    }
    return dataList;
  }
}
