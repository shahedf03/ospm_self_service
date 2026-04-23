import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../helper/constants/constants.dart';
import '../base/bottom_navigation_bar.dart';

class ChargingStatusScreen extends StatelessWidget {
  const ChargingStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary(context),
      bottomNavigationBar: const CustomBottomNav(),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 4.w),
                child: Column(
                  children: [
                    SizedBox(height: 2.h),
                    _buildProgress(context),
                    SizedBox(height: 2.h),
                    _buildSpeedChip(context),
                    SizedBox(height: 2.h),
                    _buildInfoCards(context),
                    SizedBox(height: 2.h),
                    _buildSessionDetails(context),
                    SizedBox(height: 2.h),
                    _buildStopButton(context),
                    SizedBox(height: 2.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= HEADER =================
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      child: Row(
        children: [
          Icon(Icons.more_vert, color: AppColors.textPrimary(context)),
          const Spacer(),
          Text(
            "حالة الشحن المباشرة",
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

  // ================= PROGRESS =================
  Widget _buildProgress(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 22.h,
              width: 40.w,
              child: CircularProgressIndicator(
                value: 0.75,
                strokeWidth: 10,
                backgroundColor: AppColors.divider.withOpacity(0.2),
                valueColor: const AlwaysStoppedAnimation(
                  AppColors.buttonPrimary,
                ),
              ),
            ),
            Column(
              children: [
                Text(
                  "75%",
                  style: TextStyle(
                    color: AppColors.textPrimary(context),
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "جارِ الشحن ⚡",
                  style: TextStyle(
                    color: AppColors.buttonPrimary,
                  ),
                )
              ],
            )
          ],
        ),
      ],
    );
  }

  // ================= SPEED CHIP =================
  Widget _buildSpeedChip(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.buttonPrimary),
      ),
      child: Text(
        "شحن سريع بقدرة 150 كيلوواط",
        style: TextStyle(color: AppColors.buttonPrimary),
      ),
    );
  }

  // ================= INFO =================
  Widget _buildInfoCards(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _infoCard(
            context,
            title: "الوقت المتبقي",
            value: "45 دقيقة",
            icon: Icons.timer,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _infoCard(
            context,
            title: "التكلفة الحالية",
            value: "12.50",
            icon: Icons.attach_money,
          ),
        ),
      ],
    );
  }

  Widget _infoCard(
      BuildContext context, {
        required String title,
        required String value,
        required IconData icon,
      }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.buttonPrimary),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(color: AppColors.textSecondary(context)),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              color: AppColors.textPrimary(context),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  // ================= SESSION =================
  Widget _buildSessionDetails(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "تفاصيل الجلسة",
                style: TextStyle(color: AppColors.textPrimary(context)),
              ),
              const Spacer(),
              Chip(
                label: Text(
                  "نشط الآن",
                  style: TextStyle(color: Colors.black),
                ),
                backgroundColor: AppColors.buttonPrimary,
              )
            ],
          ),
          const SizedBox(height: 10),
          _row(context, "رقم المحطة:", "EV-99021#"),
          _row(context, "الجهد الكهربائي:", "400 فولت"),
          _row(context, "التيار:", "32 أمبير"),
        ],
      ),
    );
  }

  Widget _row(BuildContext context, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Text(title,
              style: TextStyle(color: AppColors.textSecondary(context))),
          const Spacer(),
          Text(value,
              style: TextStyle(color: AppColors.textPrimary(context))),
        ],
      ),
    );
  }

  // ================= STOP =================
  Widget _buildStopButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.red),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Text(
          "إيقاف الشحن ⛔",
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}