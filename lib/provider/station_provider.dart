import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../model/stations/price_list_model.dart';
import '../model/stations/station_price_list_model.dart';
import '../model/stations/stations_model.dart';

class StationProvider extends ChangeNotifier {
  StationPriceListModel? data;
  List<StationPriceListModel> stationPriceListModel = [];

  List<StationsModel> stations = [];
  List<PriceListModel> prices = [];
  PriceListModel? currentPrice;



  Future<void> getStationData() async {
    try {
      EasyLoading.show(status: 'loading'.tr);

      stationPriceListModel =
      await StationPriceListModel().getStationPriceList();

      if (stationPriceListModel.isNotEmpty) {
        data = stationPriceListModel.first;

        stations = data!.lstStations;
        prices = data!.lstPriceList;

        try {
          currentPrice =
              prices.firstWhere((e) => e.isCurrent == true);
        } catch (e) {
          currentPrice = null;
        }
      }

      EasyLoading.dismiss();
      notifyListeners();
    } catch (e) {
      EasyLoading.dismiss();
      EasyLoading.showError('Something went wrong');
      rethrow;
    }
  }
}