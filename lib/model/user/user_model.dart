import 'package:ocpm_self_service/model/model_helper/service_model.dart';
import 'package:ocpm_self_service/model/car/car_model.dart';
import '../../helper/constants/api_definition.dart';
import '../../helper/end_points.dart';

class UserModel extends ServiceModel{
int ?companyID;
int ?id;
String ?name;
String ?mobileNo;
String ?userName;
String ?password;
String ?birthDate;
List<CarModel> cars=[];


UserModel({this.companyID, this.id, this.name, this.mobileNo,
    this.userName, this.password, this.birthDate});

UserModel.fromJson(Map<String, dynamic> json) {
  companyID = intNullableJson(json, "companyID");
  id = intNullableJson(json, "id");
  name = stringNullableJson(json, "name");
  mobileNo = stringNullableJson(json, "mobileNo");
  userName = stringNullableJson(json, "userName");
  password = stringNullableJson(json, "password");
  birthDate=stringNullableJson(json, "birthDate");
  if (json["cars"] != null &&
      json["cars"] is List) {
    cars = (json["cars"] as List)
        .map((e) => CarModel.fromJson(e)).toList();
  } else {
    cars = [];
  }
}


Map<String, dynamic> toJson() => {

    'companyID': companyID,
    'id': id,
    'name': name,
    'mobileNo': mobileNo,
    'userName': userName,
    'password': password,
    'birthDate': birthDate,
    "cars": cars.map((e) => e.toJson()).toList(),

  };

Future<dynamic> addVerificationCode({required UserModel user}) async {
  try {
    var response = await handlePostData(
      obj: user,
      json: UserModel.fromJson,
      rest: addNewVerificationCode,
    );
    return response;
  } catch (e) {
    rethrow;
  }
}


Future<List<UserModel>> getProfile() async {
  try {
    var response = await handleGetData<UserModel>(
      params: "$getProfileDataOp?CompanyID=0&customerID=${box.read("userId")}",
      fromJson: (json) => UserModel.fromJson(json),
    );
    return response;
  } catch (e) {
    rethrow;
  }
}

  Future<dynamic> createProfile({
  required UserModel profileData,
}) async {
  try {
    var response = await handlePostData(
      obj: profileData,
      json: UserModel.fromJson,
    rest: createProfileOP,
    );
    return response;
  } catch (e) {
    rethrow;
  }
}










}