import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../helper/constants/constants.dart';
import '../../view/screen/auth/login_screen.dart';

class AuthDialog {
  static void showLoginDialog() {
    Get.dialog(
      Dialog(
        backgroundColor: AppColors.cardBackground(Get.context!),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Title
              Text(
                "تنبيه",
                style: TextStyle(
                  color: AppColors.textPrimary(Get.context!),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right,
              ),

              const SizedBox(height: 10),

              // Message
              Text(
                "يرجى تسجيل الدخول أولاً للمتابعة",
                style: TextStyle(
                  color: AppColors.textSecondary(Get.context!),
                  fontSize: 14,
                ),
                textAlign: TextAlign.right,
              ),

              const SizedBox(height: 20),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Cancel
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      "إلغاء",
                      style: TextStyle(
                        color: AppColors.textHint(Get.context!),
                      ),
                    ),
                  ),

                  // Login Button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    onPressed: () {
                      Get.back();
                      Get.to(() => const LoginScreen());
                    },
                    child: const Text(
                      "تسجيل الدخول",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}