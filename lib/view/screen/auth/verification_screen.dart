import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../helper/constants/constants.dart';
import '../../../provider/auth/auth_provider.dart';
import 'login_screen.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Provider.of<AuthProvider>(context, listen: false),
      child: Consumer<AuthProvider>(
        builder: (context, authProvider, child) => Scaffold(
          backgroundColor: AppColors.backgroundPrimary(context),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: AppColors.buttonPrimary,
                          ),
                            onPressed: () {
                              final auth = context.read<AuthProvider>();
                              auth.clearOtp();
                              Get.off(const LoginScreen());
                            },
                        ),

                        Text(
                          "enter_security_code".tr,
                          style: TextStyle(
                            color: AppColors.textPrimary(context),
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                         SizedBox(width: 4.w),
                      ],
                    ),

                    SizedBox(height: 10.h),

                    Text(
                      'we_have_sent_a_4digit_code_to_your_phone_number_Please_enter_it_below'
                          .tr,
                      style: TextStyle(
                        color: AppColors.textSecondary(context),
                      ),
                    ),

                    SizedBox(height: 4.h),

                    // ================= OTP =================
                    GestureDetector(
                      onTap: () => FocusScope.of(context)
                          .requestFocus(authProvider.otpFocus),
                      child: Row(
                        children: List.generate(
                          4,
                              (index) => Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 1.w),
                              child: _buildBox(
                                  context, index, authProvider),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Opacity(
                      opacity: 0,
                      child: TextField(
                        controller: authProvider.otpController,
                        focusNode: authProvider.otpFocus,
                        keyboardType: TextInputType.number,
                        maxLength: 4,
                        onChanged: (value) {
                          authProvider.otp = value;
                          authProvider.updateOtp(value);
                        },
                      ),
                    ),

                    SizedBox(height: 2.h),

                    Text(
                      "resend_code".tr,
                      style: TextStyle(color: AppColors.buttonPrimary),
                    ),

                    SizedBox(height: 2.h),

                    SizedBox(
                      width: double.infinity,
                      height: 8.h,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.buttonPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          authProvider.verifyOtp();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.arrow_back,
                                color: Colors.black),
                            SizedBox(width: 1.w),
                            Text(
                              'send_verification_code'.tr,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ================= OTP BOX =================
  Widget _buildBox(
      BuildContext context,
      int index,
      AuthProvider authProvider,
      ) {
    bool isFilled = index < authProvider.otp.length;

    return Container(
      height: 8.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.cardBackground(context),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.border(context)),
      ),
      child: Text(
        isFilled ? authProvider.otp[index] : "•",
        style: TextStyle(
          color: isFilled
              ? AppColors.buttonPrimary
              : AppColors.textHint(context),
          fontSize: 24.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}