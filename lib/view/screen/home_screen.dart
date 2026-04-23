import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ocpm_self_service/view/screen/scan_screen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../helper/constants/constants.dart';
import '../../provider/auth/auth_provider.dart';
import '../../provider/station_provider.dart';
import '../base/auth_dialog.dart';
import '../base/bottom_navigation_bar.dart';
import '../base/price_bottom_sheet.dart';
import 'auth/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StationProvider>().getStationData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary(context),
      bottomNavigationBar: const CustomBottomNav(),
      body: SafeArea(
        child: Consumer<StationProvider>(
          builder: (context, stationProvider, _) {
            if (stationProvider.data == null) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.buttonPrimary,
                ),
              );
            }

            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(5.w, 3.h, 5.w, 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [

                  /// ================= HEADER =================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Container(
                        width: 11.w,
                        height: 11.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.buttonPrimary,
                          ),
                          color: AppColors.primary(context),
                        ),
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.notifications,
                            color: AppColors.buttonPrimary,
                            size: 5.w,
                          ),
                        ),
                      ),

                      Text(
                        "${"Stations".tr}711",
                        style: TextStyle(
                          color: AppColors.textPrimary(context),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Container(
                        width: 11.w,
                        height: 11.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.buttonPrimary,
                          ),
                          color: AppColors.primary(context),
                        ),
                        child: IconButton(
                          onPressed: () {
                            final auth = Provider.of<AuthProvider>(context, listen: false);

                            if (!auth.isLoggedIn()) {
                              AuthDialog.showLoginDialog();
                              return;
                            }

                            Get.to(() => const ProfileScreen());
                          },
                          icon: Icon(
                            Icons.person,
                            color: AppColors.buttonPrimary,
                            size: 5.w,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 2.h),


                  /// ================= PRICE CARD =================
                  Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: AppColors.primary(context),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.border(context),
                      ),
                    ),
                    child: Row(
                      children: [

                        Column(
                          children: [

                            Icon(
                              Icons.bolt,
                              color: AppColors.buttonPrimary,
                              size: 30,
                            ),

                            SizedBox(height: 1.h),

                            GestureDetector(
                              onTap: () {
                                PricesBottomSheet.show(
                                  context,
                                  context.read<StationProvider>(),
                                );
                              },
                              child: Text(
                                "view_all".tr,
                                style: TextStyle(
                                  color: AppColors.buttonPrimary,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(width: 3.w),

                        /// RIGHT SIDE (PRICE INFO)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "current_charging_price".tr,
                                style: TextStyle(
                                  color: AppColors.textHint(context),
                                ),
                              ),

                              SizedBox(height: 1.5.h),

                              Text(
                                "JOD ${stationProvider.currentPrice?.price ?? 0}",
                                style: TextStyle(
                                  color: AppColors.textPrimary(context),
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 2.h),

                  /// ================= START CHARGING =================
                  SizedBox(
                    width: double.infinity,
                    height: 6.5.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),

                      onPressed: () {
                        final auth =
                        Provider.of<AuthProvider>(context,
                            listen: false);

                        if (!auth.isLoggedIn()) {
                          AuthDialog.showLoginDialog();
                          return;
                        }

                        Get.to(() => const ScanScreen());
                      },
                      child: Text(
                        "start_charging".tr,
                        style: TextStyle(
                          color: AppColors.textPrimary(context),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 2.h),

                  /// ================= TITLE =================
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "view_all".tr,
                        style: TextStyle(
                          color: AppColors.buttonPrimary,
                        ),
                      ),
                      Text(
                        "nearby_stations".tr,
                        style: TextStyle(
                          color: AppColors.textPrimary(context),
                          fontSize: 16.sp,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 2.h),

                  /// ================= STATIONS =================
                  ListView.separated(
                    shrinkWrap: true,
                    primary: false,
                    physics:
                    const NeverScrollableScrollPhysics(),
                    itemCount:
                    stationProvider.stations.length,
                    separatorBuilder: (_, __) =>
                        SizedBox(height: 1.5.h),
                    itemBuilder: (context, index) {
                      final station =
                      stationProvider.stations[index];

                      return _buildStationCard(
                        context,
                        title: station.name ?? "",
                        location: "عمان، الأردن",
                        status: "متاح",
                        imagePath:
                        "assets/images/station1.png",
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  /// ================= STATION CARD =================
  Widget _buildStationCard(
      BuildContext context, {
        required String title,
        required String location,
        required String status,
        required String imagePath,
        bool isBusy = false,
      }) {
    return Container(
      height: 20.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border(context)),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              imagePath,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.2),
                  Colors.black.withOpacity(0.8),
                ],
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [

                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 3.w,
                        vertical: 0.5.h,
                      ),
                      decoration: BoxDecoration(
                        color: isBusy
                            ? Colors.orange
                            : AppColors.buttonPrimary,
                        borderRadius:
                        BorderRadius.circular(10),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color:
                          AppColors.textPrimary(context),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.end,
                      children: [

                        Text(
                          title,
                          style: TextStyle(
                            color:
                            AppColors.buttonPrimary,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          location,
                          style: TextStyle(
                            color:
                            AppColors.buttonPrimary,
                            fontSize: 15.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                Row(
                  children: [

                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Text(
                          "google_map".tr,
                          style: TextStyle(
                            color:
                            AppColors.buttonPrimary,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 3.w),

                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          "directions".tr,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
