import 'package:ocpm_self_service/model/model_helper/service_model.dart';

class CarModel extends ServiceModel {
  int? companyID;
  int? carID;
  int? customerID;
  int? chargersTypeID;
  String? carName;
  String? carNo;
  String? chargersTypeName;
  int? ampere;

  CarModel({
    this.companyID,
    this.carID,
    this.customerID,
    this.chargersTypeID,
    this.carName,
    this.carNo,
    this.chargersTypeName,
    this.ampere,
  });

  CarModel.fromJson(Map<String, dynamic> json) {
    companyID = intNullableJson(json, "companyID");
    carID = intNullableJson(json, "carID");
    customerID = intNullableJson(json, "customerID");
    chargersTypeID = intNullableJson(json, "chargersTypeID");
    carName = stringNullableJson(json, "carName");
    carNo = stringNullableJson(json, "carNo");
    chargersTypeName = stringNullableJson(json, "chargersTypeName");
    ampere = intNullableJson(json, "ampere");
  }

  Map<String, dynamic> toJson() => {
    'companyID': companyID,
    'carID': carID,
    'customerID': customerID,
    'chargersTypeID': chargersTypeID,
    'carName': carName,
    'carNo': carNo,
    'chargersTypeName': chargersTypeName,
    "ampere": ampere,
  };
}
