import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../provider/auth/auth_provider.dart';
import '../../provider/setting/setting_provider.dart';
import '../../provider/setting/theme_provider.dart';
import '../../helper/constants/constants.dart';
import '../base/bottom_navigation_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();
    final langProvider = context.watch<LanguageProvider>();

    return Scaffold(
      bottomNavigationBar: const CustomBottomNav(),
      backgroundColor: AppColors.backgroundPrimary(context),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.menu, color: AppColors.buttonPrimary),
        title: Text(
          "settings".tr,
          style: TextStyle(
            color: AppColors.buttonPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _buildProfileCard(context),

            SizedBox(height: 3.h),

            _buildSelectionCard(
              context: context,
              title: "language".tr,
              icon: Icons.language,
              options: ["english".tr, "arabic".tr],
              selectedIndex:
              langProvider.currentLang == 'English' ? 0 : 1,
              onItemTap: (index) {
                langProvider.toggleLanguage(
                    index == 0 ? 'English' : 'Arabic');
              },
            ),

            SizedBox(height: 1.h),

            _buildSelectionCard(
              context: context,
              title: "mode".tr,
              icon:
              theme.isDark ? Icons.dark_mode : Icons.light_mode,
              options: ["light_mode".tr, "dark_mode".tr],
              selectedIndex: theme.isDark ? 1 : 0,
              onItemTap: (index) {
                context.read<ThemeProvider>().toggleTheme();
              },
            ),

            SizedBox(height: 3.h),

            Text(
              "notifications".tr,
              style: TextStyle(
                color: AppColors.buttonPrimary,
                fontSize: 15.sp,
              ),
            ),

            SizedBox(height: 3.h),

            _buildLogoutButton(context),

            SizedBox(height: 3.h),

            Center(
              child: Text(
                "EMERALD KINETIC V2.4.0-STABLE",
                style: TextStyle(
                  color: AppColors.textHint(context),
                  fontSize: 15.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ================= PROFILE =================

  Widget _buildProfileCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackground(context),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "أحمد منصور",
                  style: TextStyle(
                    color: AppColors.textPrimary(context),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  "ahmed.m@emerald-kinetic.com",
                  style: TextStyle(
                    color: AppColors.textSecondary(context),
                    fontSize: 16.sp,
                  ),
                ),

                SizedBox(height: 2.h),

                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 3.w, vertical: 0.5.h),
                  decoration: BoxDecoration(
                    color: AppColors.buttonPrimary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    "عضو بلاتيني",
                    style: TextStyle(
                      color: AppColors.buttonPrimary,
                      fontSize: 13.sp,
                    ),
                  ),
                )
              ],
            ),
          ),

          SizedBox(width: 5.w),

          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/images/user_avatar.png',
                  width: 18.w,
                  height: 8.h,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: AppColors.buttonPrimary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.edit,
                    size: 16.sp,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  // ================= SELECTION =================

  Widget _buildSelectionCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required List<String> options,
    required int selectedIndex,
    Function(int)? onItemTap,
  }) {
    return Container(
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackground(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border(context)),
      ),
      child: Row(
        children: List.generate(options.length, (index) {
          bool isSelected = index == selectedIndex;

          return Expanded(
            child: GestureDetector(
              onTap: () => onItemTap?.call(index),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 1.5.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.buttonPrimary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    options[index],
                    style: TextStyle(
                      color: isSelected
                          ? Colors.black
                          : AppColors.textSecondary(context),
                      fontWeight: FontWeight.bold,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // ================= LOGOUT =================

  Widget _buildLogoutButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final auth =
        Provider.of<AuthProvider>(context, listen: false);
        auth.logout();
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 2.h),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            "logout".tr,
            style: TextStyle(
              color: Colors.red,
              fontSize: 15.sp,
            ),
          ),
        ),
      ),
    );
  }
}
