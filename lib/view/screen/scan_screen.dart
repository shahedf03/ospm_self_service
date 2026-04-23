import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../helper/constants/constants.dart';
import '../base/bottom_navigation_bar.dart';
import 'ChargingStatusScreen.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary(context),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    children: [
                      SizedBox(height: 2.h),
                      _buildTitle(context),
                      SizedBox(height: 2.h),
                      _buildQRBox(context),
                      SizedBox(height: 2.h),
                      _buildDividerText(context),
                      SizedBox(height: 2.h),
                      _buildTextField(context),
                      SizedBox(height: 3.h),
                      _buildButton(context),
                      SizedBox(height: 2.h),
                      _buildTerms(context),
                    ],
                  ),
                ),
              ),
            ),

            const CustomBottomNav(),
          ],
        ),
      ),
    );
  }

  // ================= HEADER =================
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: AppColors.primary2(context),
            child: Icon(Icons.help_outline,
                color: AppColors.buttonPrimary),
          ),

          const Spacer(),

          Text(
            "start_charging".tr,
            style: TextStyle(
              color: AppColors.textPrimary(context),
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),

          const Spacer(),

          Icon(Icons.arrow_forward,
              color: AppColors.textPrimary(context)),
        ],
      ),
    );
  }

  // ================= TITLE =================
  Widget _buildTitle(BuildContext context) {
    return Column(
      children: [
        Text(
          "scan_the_QR_code".tr,
          style: TextStyle(
            color: AppColors.buttonPrimary,
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: 1.h),

        Text(
          "point_the_camera_at_the_code_on_the_charging_station_to_star_immediately".tr,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.textSecondary(context),
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }

  // ================= QR BOX =================
  Widget _buildQRBox(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppColors.primary(context),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.buttonPrimary,
          width: 1.5,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 30.h,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.buttonPrimary,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
          ),

          Icon(
            Icons.qr_code_2,
            size: 90,
            color: AppColors.textSecondary(context),
          ),

          Positioned(
            bottom: 2.h,
            child: ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary2(context),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              icon: Icon(Icons.flashlight_on,
                  color: AppColors.textPrimary(context)),
              label: Text(
                "turn_on_flashlight".tr,
                style: TextStyle(
                  color: AppColors.textPrimary(context),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // ================= DIVIDER =================
  Widget _buildDividerText(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: AppColors.divider,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            "or_enter_the_code_manuallyً".tr,
            style: TextStyle(
              color: AppColors.textSecondary(context),
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: AppColors.divider,
          ),
        ),
      ],
    );
  }

  // ================= TEXT FIELD =================
  Widget _buildTextField(BuildContext context) {
    return TextField(
      style: TextStyle(
        color: AppColors.textPrimary(context),
      ),
      decoration: InputDecoration(
        hintText: "${"ex".tr}: EV-98234",
        hintStyle: TextStyle(
          color: AppColors.textHint(context),
        ),
        filled: true,
        fillColor: AppColors.primary(context),
        prefixIcon: Icon(
          Icons.ev_station,
          color: AppColors.buttonPrimary,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // ================= BUTTON =================
  Widget _buildButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 6.h,
      child: ElevatedButton(
        onPressed: () {
          Get.off(const ChargingStatusScreen());
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          "confirm_connection_and_start_charging".tr,
          style: TextStyle(
            color: AppColors.backgroundPrimary(context),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // ================= TERMS =================
  Widget _buildTerms(BuildContext context) {
    return Text(
      "by_pressing_Confirm_you_agree_to_the_terms_of_service_and_charges_will_be_applied_based_on_energy_consumption"
          .tr,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColors.textSecondary(context),
        fontSize: 12.sp,
      ),
    );
  }
}