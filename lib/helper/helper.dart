import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'constants/layout_theme.dart';

class Helper {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      messageWarning(String title, BuildContext context) {
    GlobalKey<ScaffoldMessengerState>();
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: warningColor,
        behavior: SnackBarBehavior.floating,
        content: Text(title, style: TextStyle(fontSize: 12.0.sp))));
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> messageError(
      String title, BuildContext context) {
    GlobalKey<ScaffoldMessengerState>();
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: errorColor,
        behavior: SnackBarBehavior.floating,
        content: Text(title, style: TextStyle(fontSize: 12.0.sp))));
  }
  static void showErrorMessage({required String msg}) {
    if (Get.overlayContext != null) {
      Get.showSnackbar(
        GetSnackBar(
          icon: const Icon(Icons.error, color: Colors.white),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.red,
          snackPosition: SnackPosition.BOTTOM,
          borderRadius: 10,
          margin: EdgeInsets.all(3.w),
          padding: EdgeInsets.all(4.w),
          snackStyle: SnackStyle.FLOATING,
          isDismissible: true,
          messageText: Container(
            height: 5.h,
            alignment: Alignment.center,
            child: Text(
              msg.tr,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    } else {
      print("Get.overlayContext is null!");
    }
  }
  static void showSuccessMessage({required String msg}) {
    if (Get.overlayContext != null) {
      Get.showSnackbar(
        GetSnackBar(
          icon: const Icon(Icons.error, color: Colors.white),
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
          borderRadius: 10,
          margin: EdgeInsets.all(3.w),
          padding: EdgeInsets.all(4.w),
          snackStyle: SnackStyle.FLOATING,
          isDismissible: true,
          messageText: Container(
            height: 5.h,
            alignment: Alignment.center,
            child: Text(
              msg.tr,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    } else {
      print("Get.overlayContext is null!");
    }
  }


  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      messageSuccess(String title, BuildContext context) {
    GlobalKey<ScaffoldMessengerState>();
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: successColor,
        behavior: SnackBarBehavior.floating,
        content: Text(title, style: TextStyle(fontSize: 12.0.sp))));
  }



  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      messageErrorButton(
          {required String title,
          required String title2,
          required String secondTitle,
          required String thirdTitle,
          required void Function()? onTap1,
          required void Function()? onTap2,
          required bool hasSecT,
          required bool hasThiT,
          required BuildContext context}) {
    GlobalKey<ScaffoldMessengerState>();
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: errorColor,
        behavior: SnackBarBehavior.floating,
        content: Container(
          color: errorColor,
          child: hasSecT && hasThiT
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(title2, style: TextStyle(fontSize: 12.0.sp)),
                    const SizedBox(height: 15),
                    const Row(
                      children: [
                        Expanded(child: Divider(color: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                            child: GestureDetector(
                          onTap: onTap1,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Center(
                                child: Text(secondTitle,
                                    style: TextStyle(fontSize: 12.0.sp))),
                          ),
                        )),
                        const SizedBox(width: 10),
                        Expanded(
                            child: GestureDetector(
                          onTap: onTap2,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Center(
                                child: Text(thirdTitle,
                                    style: TextStyle(fontSize: 12.0.sp))),
                          ),
                        ))
                      ],
                    )
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                        child:
                            Text(title, style: TextStyle(fontSize: 12.0.sp))),
                    Visibility(
                      visible: hasSecT,
                      child: Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                                height: 30, width: 1, color: Colors.white),
                          ),
                          GestureDetector(
                            onTap: onTap1,
                            child: Container(
                              color: Colors.transparent,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(secondTitle,
                                  style: TextStyle(fontSize: 12.0.sp)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: hasThiT,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                                height: 30, width: 1, color: Colors.white),
                          ),
                          GestureDetector(
                            onTap: onTap2,
                            child: Container(
                              color: Colors.transparent,
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(thirdTitle,
                                  style: TextStyle(fontSize: 12.0.sp)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        )));
  }

  static Future<void> arrayViewDialog(BuildContext context, String? title,
      List<dynamic> list, void Function(String desc)? onSelectItem) async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 10),
            titlePadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    width: double.infinity,
                    height: 10,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0)),
                       )),
                Container(
                  color: const Color.fromARGB(255, 193, 220, 240),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Center(
                    child: Text(
                      title ?? "",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 18.sp),
                    ),
                  ),
                ),
              ],
            ),
            content: SizedBox(
                height: 40.h,
                child: SingleChildScrollView(
                    child: Column(children: [
                  ...List.generate(list.length, (index) {
                    return GestureDetector(
                      onTap: () => onSelectItem!(list[index]),
                      child: Container(
                          width: double.infinity,
                          color: index % 2 == 0
                              ? Colors.white
                              : const Color.fromARGB(255, 241, 249, 255),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Center(
                              child: Text(list[index] ?? "",
                                  textAlign: TextAlign.end))),
                    );
                  })
                ])))));
  }

  static Future<void> showPickerImage(
      {required context,
      required void Function()? onGallery,
      required void Function()? onCamera}) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
              child: Wrap(children: <Widget>[
            ListTile(
                leading: Icon(Icons.photo_library, color: PRIMARY_COLOR),
                title: Text('photo_library'.tr),
                onTap: onGallery),
            ListTile(
                leading: Icon(Icons.photo_camera, color: PRIMARY_COLOR),
                title: Text('camera'.tr),
                onTap: onCamera)
          ]));
        });
  }


}
