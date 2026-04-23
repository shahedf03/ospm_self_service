import 'package:ocpm_self_service/model/model_helper/service_model.dart';

class PriceListModel extends ServiceModel{
  int ?id;
  double? price;
  String?fromDateTime;
  String?toDateTime;
  bool ?isCurrent;

  PriceListModel({this.id, this.price, this.fromDateTime, this.toDateTime,
      this.isCurrent});

  PriceListModel.fromJson(Map<String, dynamic> json) {
    id = intNullableJson(json, "id");
    price = doubleNullableJson(json, "price");
    fromDateTime = stringNullableJson(json, "fromDateTime");
    toDateTime = stringNullableJson(json, "toDateTime");
    isCurrent = boolNullableJson(json, "isCurrent");

  }


}