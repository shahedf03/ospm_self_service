import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ocpm_self_service/provider/setting/setting_provider.dart';
import 'package:ocpm_self_service/provider/setting/theme_provider.dart';
import 'package:ocpm_self_service/provider/station_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'package:ocpm_self_service/provider/auth/auth_provider.dart';
import 'package:ocpm_self_service/view/screen/home_screen.dart';

import 'helper/end_points.dart';
import 'helper/translations/localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  box.write("ip_address", "olives.cds.jo");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ), ChangeNotifierProvider<StationProvider>(
          create: (_) => StationProvider(),
        ),
        ChangeNotifierProvider<LanguageProvider>(
          create: (_) => LanguageProvider(),
        ),

      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Consumer<ThemeProvider>(
          builder: (context, theme, _) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,


              theme: ThemeData(
                scaffoldBackgroundColor: theme.isDark
                    ? const Color(0xFF062F1F)
                    : Colors.white,
              ),

              home: const HomeScreen(),

              translations: LocalizationService(),
              locale: LocalizationService().getCurrentLocale(),
              fallbackLocale: const Locale('en', 'US'),

              builder: EasyLoading.init(),
            );
          },
        );
      },
    );
  }
}