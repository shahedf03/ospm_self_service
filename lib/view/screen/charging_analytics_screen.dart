import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../base/bottom_navigation_bar.dart';
import '../../helper/constants/constants.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomBottomNav(),
      backgroundColor: AppColors.backgroundPrimary(context),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.share, color: AppColors.textPrimary(context)),
                    Text(
                      "تحليلات الشحن",
                      style: TextStyle(
                        color: AppColors.textPrimary(context),
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios,
                        color: AppColors.textPrimary(context)),
                  ],
                ),

                SizedBox(height: 2.h),

                // Tabs
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TabText("سنوي"),
                    SizedBox(width: 2.w),
                    TabText("شهري"),
                    SizedBox(width: 2.w),
                    TabText("أسبوعي", active: true),
                  ],
                ),

                SizedBox(height: 2.h),

                // Cards
                Row(
                  children: [
                    Expanded(
                      child: InfoCard(
                        title: "إجمالي الاستهلاك",
                        value: "٨٥٠ kWh",
                        percent: "+8%",
                        icon: Icons.flash_on,
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child: InfoCard(
                        title: "جلسات الشحن",
                        value: "٤٢ جلسة",
                        percent: "+12%",
                        icon: Icons.local_gas_station,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 2.h),

                // Chart Placeholder
                Container(
                  height: 18.h,
                  decoration: BoxDecoration(
                    color: AppColors.primary2(context),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "استهلاك الطاقة",
                    style: TextStyle(
                      color: AppColors.textSecondary(context),
                    ),
                  ),
                ),

                SizedBox(height: 2.h),

                // Stations Activity
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "عرض الكل",
                      style: TextStyle(color: AppColors.buttonPrimary),
                    ),
                    Text(
                      "نشاط المحطات",
                      style: TextStyle(
                        color: AppColors.textPrimary(context),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 1.h),

                const StationItem(
                  title: "محطة دبي مول",
                  subtitle: "١٢ جلسة - ٣٣٠ kWh",
                  level: "مرتفع",
                ),
                const StationItem(
                  title: "مجمع الأعمال",
                  subtitle: "٨ جلسات - ١٤٥٠ kWh",
                  level: "متوسط",
                ),
                const StationItem(
                  title: "مواقف المطار",
                  subtitle: "٥ جلسات - ٩٨٠ kWh",
                  level: "منخفض",
                ),

                // Tip Box
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.buttonPrimary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    "نصيحة توفير\nاستهلاكك هذا الأسبوع أقل بنسبة 5% من الأسبوع الماضي. الشحن خارج الذروة وفر لك مال.",
                    style: TextStyle(
                      color: AppColors.backgroundPrimary(context),
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class TabText extends StatelessWidget {
  final String text;
  final bool active;

  const TabText(this.text, {this.active = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: active
            ? AppColors.buttonPrimary
            : AppColors.textSecondary(context),
        fontWeight: active ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}class StationItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String level;

  const StationItem({
    required this.title,
    required this.subtitle,
    required this.level,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3.h),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primary2(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(Icons.location_on, color: AppColors.buttonPrimary),
          SizedBox(width: 13.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: TextStyle(color: AppColors.textPrimary(context)),
                ),
                Text(
                  subtitle,
                  style: TextStyle(color: AppColors.textSecondary(context)),
                ),
              ],
            ),
          ),
          Text(
            level,
            style: TextStyle(color: AppColors.buttonPrimary),
          ),
        ],
      ),
    );
  }
}class InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final String percent;
  final IconData icon;

  const InfoCard({
    required this.title,
    required this.value,
    required this.percent,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary2(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: AppColors.buttonPrimary),
              Text(
                percent,
                style: TextStyle(color: AppColors.buttonPrimary),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          Text(
            title,
            style: TextStyle(color: AppColors.textSecondary(context)),
          ),
          SizedBox(height: 1.h),
          Text(
            value,
            style: TextStyle(
              color: AppColors.textPrimary(context),
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}