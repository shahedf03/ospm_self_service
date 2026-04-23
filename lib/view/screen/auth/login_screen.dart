import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../helper/constants/constants.dart';
import '../../../provider/auth/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthProvider>(
      create: (_) => AuthProvider(),
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, child) => Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: AppColors.backgroundPrimary(context),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 2.w,
                right: 2.w,
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 6.h),

                  /// ================= IMAGE================ =
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      "assets/images/car_charging.png",
                      height: 28.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  SizedBox(height: 2.h),

                  /// ================= TITLE =================
                  Text(
                    "Welcome_to_Smart_Charging_Charge_smarter_drive_further".tr,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: AppColors.textPrimary(context),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 1.h),

                  /// ================= SUBTITLE =================
                  Text(
                    "Enter_your_phone_number_to_begin_a_smart_and_fast_charging_experience"
                        .tr,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: AppColors.textSecondary(context),
                      fontSize: 14.sp,
                    ),
                  ),

                  SizedBox(height: 2.h),

                  /// ================= PHONE INPUT =================
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.cardBackground(context),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: AppColors.border(context),
                      ),
                    ),
                    child: TextField(
                      controller: authProvider.mobileNo,
                      keyboardType: TextInputType.phone,
                      style: TextStyle(
                        color: AppColors.textPrimary(context),
                      ),
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        hintText: "phone_number".tr,
                        hintStyle: TextStyle(
                          color: AppColors.textHint(context),
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(16),
                      ),
                    ),
                  ),

                  SizedBox(height: 3.h),

                  /// ================ BUTTON ================
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: authProvider.isLoading
                          ? null
                          : () {
                        authProvider.mobileLogin();
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),

                      child: Text(
                        "send".tr,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 2.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}