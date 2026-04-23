import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ocpm_self_service/view/screen/home_screen.dart';
import '../../helper/helper.dart';
import '../../model/car/car_model.dart';
import '../../model/car/car_type_model.dart';
import '../../model/car/chargers_types_model.dart';
import '../../model/user/user_model.dart';
import '../../model/user/verification_code_model.dart';
import '../../view/screen/auth/profile_screen.dart';
import '../../view/screen/auth/verification_screen.dart';

class AuthProvider extends ChangeNotifier {
  final GetStorage box = GetStorage();

  // ===========================
  // Controllers
  // ===========================

  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController carNameController = TextEditingController();
  TextEditingController carNoController = TextEditingController();
  TextEditingController ampereController = TextEditingController();
  TextEditingController chargersTypeIDController = TextEditingController();

  // Variables
  // ===========================
  List<CarModel> cars = [];
  List<CarTypeModel> carsTypes = [];
  List<UserModel> user = [];
  List<ChargersTypesModel> chargersTypes = [];
  ChargersTypesModel? selectedChargersTypeName;
  CarTypeModel? selectedCarName;
  //============================

  FocusNode otpFocus = FocusNode();
  String otp = "";
  bool isLoading = false;

  //login_method
  void loginValidation() {
    final phone = mobileNo.text.trim();

    if (phone.isEmpty) {
      throw "enter_mobile_number".tr;
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(phone)) {
      throw "mobile_must_contain_numbers_only".tr;
    }
    if (!phone.startsWith("07")) {
      throw "mobile_number_must_start_with_07".tr;
    }
    if (phone.length !=10) {
      throw "mobile_number_must_be_10_digits".tr;
    }
  }

  bool isLoggedIn() {
    return box.read("userId") != 0;
  }
  void clearOtp() {
    otp = "";
    otpController.clear();
    notifyListeners();
  }

  Future<void> mobileLogin() async {
    try {
      if (isLoading) return;

      isLoading = true;
      loginValidation();
      EasyLoading.show(status: 'loading'.tr);

      await UserModel().addVerificationCode(
        user: UserModel(
          id: 0,
          companyID: 0,
          name: " ",
          mobileNo: mobileNo.text,
          userName: " ",
          password: " ",
          birthDate: "2026-04-06",
        ),
      );

      box.write("mobileNo", mobileNo.text);
      Get.off(() => const VerificationScreen());
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      Helper.showErrorMessage(msg: "Error_loggin: $e");
    }
    finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //=============End==============

  ////Otp method
  void otpValidation() {
    final code = otpController.text.trim();

    if (code.isEmpty) {
      throw "enter_verification_code".tr;
    }

    if (!RegExp(r'^[0-9]+$').hasMatch(code)) {
      throw "otp_must_be_numbers_only".tr;
    }

    if (code.length != 4) {
      throw "otp_must_be_4_digits".tr;
    }
  }

  void updateOtp(String value) {
    otp = value;
    notifyListeners();
  }

  Future<void> verifyOtp() async {
    try {
      otpValidation();
      EasyLoading.show(status: 'loading'.tr);

      ValidateVerificationCodeRequest user =
          await ValidateVerificationCodeRequest().validateVerification(
            user: ValidateVerificationCodeRequest(
              id: 0,
              companyID: 0,
              verificationCode: otpController.text,
              mobileNo: box.read("mobileNo"),
              isUsed: true,
              isPosted: true,
              sysDateTime: DateTime.now().toIso8601String(),
            ),
          );

      box.write("userId", user.id);
      clearOtp();
      EasyLoading.dismiss();
      Get.off(() => ProfileScreen());
    //  box.write("isLoggedIn", true);
    } catch (e) {
      EasyLoading.dismiss();
      Helper.showErrorMessage(msg: "Code_invalid: $e");
    }
  }

  //=============End==============

  ////profile method
  void validateCreateProfile() {
    final birthDate = birthDateController.text.trim();
    final selectedDate = DateTime.tryParse(birthDate);
    if (userNameController.text.trim().isEmpty) {
      throw "enter_username".tr;
    }

    if (mobileNo.text.trim().isEmpty) {
      throw "enter_mobile_number".tr;
    }

    if (birthDateController.text.trim().isEmpty) {
      throw "enter_birthdate".tr;
    }
    if (selectedDate == null) {
      throw "invalid_birthdate".tr;
    }

    if (selectedDate.isAfter(DateTime.now())) {
      throw "birthdate_cannot_be_in_future".tr;
    }
    if (cars.isEmpty) {
      throw "add_at_least_one_car".tr;
    }
  }

  void validateAddCar() {
    if (carNameController.text.trim().isEmpty) {
      throw "car_name_is_required".tr;
    }

    if (carNoController.text.trim().isEmpty) {
      throw "car_number_is_required".tr;
    }

    if (selectedChargersTypeName == null) {
      throw "chargers_type_is_required".tr;
    }
  }

  void validateDuplicateCar() {
    final isDuplicate = cars.any(
      (car) => car.carNo?.trim() == carNoController.text.trim(),
    );

    if (isDuplicate == true) {
      throw "car_already_exists".tr;
    }
  }

  void selectItem({required Object obj, required String type}) {
    switch (type) {
      case "CarName":
        selectedCarName = obj as CarTypeModel;
        break;
      case "ChargersTypeName":
        selectedChargersTypeName = obj as ChargersTypesModel;
        break;
    }
    notifyListeners();
  }

  void addCar(CarModel car) {
    cars.add(car);
    notifyListeners();
  }

  void removeCar(int index) {
    cars.removeAt(index);
    notifyListeners();
  }

  void resetAll() {
    nameController.clear();
    mobileNo.clear();
    userNameController.clear();
    passwordController.clear();
    birthDateController.clear();
    cars.clear();

    notifyListeners();
  }

  void resetCarFields() {
    carNoController.clear();
    notifyListeners();
  }

  Future<void> createProfile() async {
    try {
      if (isLoading) return;

      isLoading = true;
      notifyListeners();
      validateCreateProfile();
      EasyLoading.show(status: 'loading'.tr);

      UserModel profile = UserModel(
        companyID: 0,
        name: userNameController.text,
        mobileNo: mobileNo.text,
        userName: userNameController.text,
        id: box.read("userId"),
        password: "",
        birthDate: birthDateController.text,
      );

      profile.cars = cars;

      var userModel = await UserModel().createProfile(profileData: profile);
      box.write("userId", userModel.id);
    //  box.write("userId", profile.id);
      user = await UserModel().getProfile();
      isLoading = false;
      Get.off(() => const HomeScreen());
      notifyListeners();
      EasyLoading.dismiss();
      Helper.showSuccessMessage(msg: "profile_saved_successfully".tr);

      // resetAll();
    } catch (e) {
      isLoading = false;
      notifyListeners();

      Helper.showErrorMessage(msg: e.toString().tr);
    }
  }

  Future<void> getUserProfile() async {
    try {
      if (box.read("userId") != 0) {
        user = await UserModel().getProfile();

        if (user.isNotEmpty) {
          final profile = user.first;
          cars = profile.cars;
          userNameController.text = profile.userName ?? '';
          mobileNo.text = box.read("mobileNo") ?? '';
          birthDateController.text = profile.birthDate ?? '';
          cars = profile.cars;
        }
      } else {
        resetAll();
        mobileNo.text = box.read("mobileNo") ?? '';
        return;
      }

      notifyListeners();
    } catch (e) {
      EasyLoading.dismiss();
      Helper.showErrorMessage(msg: "error: $e");
    }
  }

  Future<void> getChargersTypes() async {
    try {

      chargersTypes = await ChargersTypesModel().getChargersTypes();

      if (chargersTypes.isNotEmpty) {
        selectedChargersTypeName = chargersTypes.first;
      }

      notifyListeners();
    } catch (e) {
      EasyLoading.dismiss();
      Helper.showErrorMessage(msg: "error: $e");
    }
  }


  void logout() {
    box.write("userId", 0);
    clearOtp();

    Get.snackbar(
      "you_have_been_logged_out".tr,
      "you_have_been_successfully_logged_out".tr,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }
}
