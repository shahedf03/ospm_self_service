import 'dart:ffi';

import 'package:ocpm_self_service/model/model_helper/service_model.dart';

import '../../helper/constants/api_definition.dart';

class ValidateVerificationCodeRequest extends ServiceModel {
  int ?id;
  int ?companyID;
  String ?mobileNo;
  String ?verificationCode;
  String ?sysDateTime;
  bool ?isUsed;
  bool ?isPosted;

  ValidateVerificationCodeRequest({
     this.id,
     this.companyID,
     this.mobileNo,
     this.verificationCode,
     this.sysDateTime,
     this.isUsed,
     this.isPosted,
  });

  ValidateVerificationCodeRequest.fromJson(Map<String, dynamic> json) {
    companyID = intNullableJson(json, "companyID");
    id = intNullableJson(json, "id");
    mobileNo = stringNullableJson(json, "mobileNo");
    verificationCode = stringNullableJson(json, "verificationCode");
    sysDateTime = stringNullableJson(json, "sysDateTime");
    isUsed = boolNullableJson(json, "isUsed");
    isPosted = boolNullableJson(json, "isPosted");

  }

  Map<String, dynamic> toJson() => {
      'id': id,
      'companyID': companyID,
      'mobileNo': mobileNo,
      'verificationCode': verificationCode,
      'sysDateTime': sysDateTime,
      'isUsed': isUsed,
      'isPosted': isPosted,
    };
  Future<dynamic> validateVerification({
    required ValidateVerificationCodeRequest user,
  }) async {
    try {
      var response = await handlePostData(
        obj: user,
        json: ValidateVerificationCodeRequest.fromJson,
        rest: validateVerificationCode,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}