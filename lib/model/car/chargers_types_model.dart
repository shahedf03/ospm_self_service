import 'package:ocpm_self_service/model/model_helper/service_model.dart';

import '../../helper/constants/api_definition.dart';

class ChargersTypesModel extends ServiceModel {
  int? id;
  int? ampere;
  String? name;

  ChargersTypesModel({this.id, this.ampere, this.name});

  ChargersTypesModel.fromJson(Map<String, dynamic> json) {
    id = intNullableJson(json, "id");
    ampere = intNullableJson(json, "ampere");
    name = stringNullableJson(json, "name");
  }

Future<List<ChargersTypesModel>> getChargersTypes() async {
  try {
    var response = await handleGetData<ChargersTypesModel>(
      params: getChargersTypesOp,
      fromJson: (json) => ChargersTypesModel.fromJson(json),
    );
    return response;
  } catch (e) {
    rethrow;
  }
}
}
