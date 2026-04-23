import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../helper/constants/constants.dart';
import '../screen/charging_analytics_screen.dart';
import '../screen/home_screen.dart';
import '../screen/setting_screen.dart';

class CustomBottomNav extends StatefulWidget {
  final int initialIndex;

  const CustomBottomNav({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav> {
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  void _onTap(int index) {
    setState(() {
      currentIndex = index;
    });

    switch (index) {
      case 0:
        Get.offAll(() => HomeScreen());
        break;

      case 1:
      Get.to(() => AnalyticsScreen());
        break;

      case 2:
      // action button (optional)
        break;

      case 3:
      // Get.to(() => MapScreen());
        break;

      case 4:

        Get.to(() => SettingsScreen());
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors.primary(context),
      currentIndex: currentIndex,
      onTap: _onTap,
      selectedItemColor: AppColors.buttonPrimary,
      unselectedItemColor: AppColors.textHint(context),
      type: BottomNavigationBarType.fixed,
      items:  [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "home".tr,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: "my_activity".tr,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.flash_on),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: "maps".tr,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: "Settings".tr,
        ),
      ],
    );
  }
}