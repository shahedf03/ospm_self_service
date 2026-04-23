import 'package:ocpm_self_service/model/stations/price_list_model.dart';
import 'package:ocpm_self_service/model/stations/stations_model.dart';
import '../../helper/constants/api_definition.dart';
import '../model_helper/service_model.dart';

class StationPriceListModel extends ServiceModel{

  List<StationsModel>lstStations=[];
  List<PriceListModel>lstPriceList=[];

  StationPriceListModel();

  StationPriceListModel.fromJson(Map<String, dynamic> json){

    if (json["lstStations"] != null &&
        json["lstStations"] is List) {
      lstStations = (json["lstStations"] as List)
          .map((e) => StationsModel.fromJson(e))
          .toList();
    } else {
      lstStations = [];
    }

    if (json["lstPriceList"] != null &&
        json["lstPriceList"] is List) {
      lstPriceList = (json["lstPriceList"] as List)
          .map((e) => PriceListModel.fromJson(e))
          .toList();
    } else {
      lstPriceList = [];
    }
  }

  Future<List<StationPriceListModel>> getStationPriceList() async {
    try {
      var response = await handleGetData<StationPriceListModel>(
        params: "$getAllDataForConsumerOp?CompanyID=0",
        fromJson: (json) => StationPriceListModel.fromJson(json),
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }





}