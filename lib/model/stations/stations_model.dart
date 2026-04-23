import 'package:ocpm_self_service/model/model_helper/service_model.dart';

class StationsModel extends ServiceModel{
  int?companyID;
  int?id;
  String?name;

  StationsModel({this.companyID, this.id, this.name});

  StationsModel.fromJson(Map<String, dynamic> json) {
    companyID = intNullableJson(json, "companyID");
    id = intNullableJson(json, "id");
    name = stringNullableJson(json, "name");

  }


}