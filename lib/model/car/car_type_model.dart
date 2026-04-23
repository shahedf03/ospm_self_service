import 'package:ocpm_self_service/model/model_helper/service_model.dart';

import '../../helper/constants/api_definition.dart';
import 'chargers_types_model.dart';

class CarTypeModel extends ServiceModel {
  int? companyID;
  int? carID;
  String? carName;
  String? carNo;
  List<ChargersTypesModel> chargersTypes = [];

  CarTypeModel({this.companyID, this.carID, this.carName, this.carNo});

  CarTypeModel.fromJson(Map<String, dynamic> json) {
    companyID = intNullableJson(json, "companyID");
    carID = intNullableJson(json, "carID");
    carName = stringNullableJson(json, "carName");
    carNo = stringNullableJson(json, "carNo");
    if (json["chargersTypes"] != null && json["chargersTypes"] is List) {
      chargersTypes = (json["chargersTypes"] as List)
          .map((e) => ChargersTypesModel.fromJson(e))
          .toList();
    } else {
      chargersTypes = [];
    }
  }


  Future<List<CarTypeModel>> getCarTypes() async {
    try {
      var response = await handleGetData<CarTypeModel>(
        params: "$getCars?companyID=0",
        fromJson: (json) => CarTypeModel.fromJson(json),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}




