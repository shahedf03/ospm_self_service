import 'package:get_storage/get_storage.dart';

GetStorage box = GetStorage();

// End points
String imagePath = 'assets/images/';
String iconPath = 'assets/icons/';

String baseUrl() {
  // if (box.read('ip_address').toString().startsWith("#")) {
    return "https://${box.read('ip_address')}/Olives_OCPM_API/api";
  // } else {
  //   return "http://${box.read('ip_address')}/Olives_OCPM_API/api";
  // }
}

//
// String baseParamUrl(
//     {salesmanNo = true,
//     companyNo = true,
//     identifier = true,
//     verNum = false,
//     contentVer = true,
//     sysId = true}) {
//   try {
//     String params = "";
//     if (salesmanNo) {
//       params = "$params&salesmanno=${box.read('salesman_no') ?? "0"}";
//     }
//
//     if (companyNo) {
//       params = "$params&CompNo=${box.read('company_no') ?? ""}";
//     }
//
//     if (identifier) {
//       params = "$params&IMEI_ID=${box.read('IMEI') ?? ""}";
//     }
//
//     if (verNum) {
//       params = "$params&verNum=1";
//     }
//
//     if (contentVer) {
//       params = "$params&contentVer=2";
//     }
//
//     if (sysId) {
//       params = "$params&Sys_ID=3003_2022101313341746";
//     }
//     return params;
//   } catch (e) {
//     rethrow;
//   }
// }
