

class MerchantListData {
  String isAdd;
  String merchantId;
  String merchantName;
  String percent;
  String amount;


  MerchantListData();

  MerchantListData.fromJson(Map<String, dynamic> json) {
    isAdd = json['is_add'];
    merchantId = json['merchant_id'];
    merchantName = json['merchant_name'];
    percent = json['percent'];
    amount = json['amount'];
  }

  bool increase(){
    return 'true' == isAdd;
  }
}
