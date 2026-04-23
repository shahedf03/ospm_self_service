import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../../helper/constants/constants.dart';
import '../../../provider/auth/auth_provider.dart';
import '../../base/add_car_bottom_sheet.dart';
import '../../base/custom_text_field.dart';
import '../../base/pick_date.dart';
import '../home_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      final provider = context.read<AuthProvider>();
      await provider.getChargersTypes();
      await provider.getUserProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: AppColors.backgroundPrimary(context),
          body: SafeArea(
            child: SingleChildScrollView(
              keyboardDismissBehavior:
              ScrollViewKeyboardDismissBehavior.onDrag,
              child: Padding(
                padding: EdgeInsets.all(4.w),
                child: Column(
                  children: [
                    // ===== HEADER =====
                    Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: AppColors.buttonPrimary,
                          ),
                          onPressed: () {
                            Get.off(const HomeScreen());
                          },
                        ),
                        Text(
                          "profile".tr,
                          style: TextStyle(
                            color: AppColors.textPrimary(context),
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 48),
                      ],
                    ),

                    SizedBox(height: 2.h),

                    // ===== FIELDS =====
                    CustomTextField(
                      controller: provider.userNameController,
                      hint: "username".tr,
                      icon: Icons.person,
                    ),

                    SizedBox(height: 1.h),

                    CustomTextField(
                      enabled: false,
                      controller: provider.mobileNo,
                      hint: "phone_number".tr,
                      icon: Icons.phone,
                    ),

                    SizedBox(height: 1.h),

                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          builder: (_) {
                            return IOSDatePicker(
                              selectedDate: DateTime.now(),
                              onDateChanged: (date) {
                                provider.birthDateController.text =
                                date
                                    .toIso8601String()
                                    .split("T")[0];
                              },
                              onCancel: () =>
                                  Navigator.pop(context),
                              onDone: () =>
                                  Navigator.pop(context),
                            );
                          },
                        );
                      },
                      child: AbsorbPointer(
                        child: CustomTextField(
                          controller:
                          provider.birthDateController,
                          hint: "birth_date".tr,
                          icon: Icons.date_range,
                        ),
                      ),
                    ),

                    SizedBox(height: 2.h),

                    // ===== CARS LIST =====
                    ListView.builder(
                      shrinkWrap: true,
                      physics:
                      const NeverScrollableScrollPhysics(),
                      itemCount: provider.cars.length,
                      itemBuilder: (context, i) {
                        final car = provider.cars[i];

                        return Container(
                          margin:
                          EdgeInsets.only(bottom: 2.h),
                          decoration: BoxDecoration(
                            color:
                            AppColors.primary(context),
                            borderRadius:
                            BorderRadius.circular(16),
                            border: Border.all(
                              color: AppColors.border(
                                  context),
                            ),
                          ),
                          child: Padding(
                            padding:
                            EdgeInsets.all(3.w),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons
                                          .directions_car,
                                      color: AppColors
                                          .buttonPrimary,
                                    ),
                                    SizedBox(width: 2.w),
                                    Expanded(
                                      child: Text(
                                        car.carName ?? '',
                                        style: TextStyle(
                                          fontSize:
                                          16.sp,
                                          fontWeight:
                                          FontWeight
                                              .bold,
                                          color: AppColors
                                              .textPrimary(
                                              context),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 2.h),

                                _buildInfoRow(
                                  context,
                                  icon: Icons.confirmation_number,
                                  title:
                                  "vehicle_identification_number".tr,
                                  value: car.carNo ?? '',
                                ),

                                SizedBox(height: 1.h),

                                _buildInfoRow(
                                  context,
                                  icon: Icons.electrical_services,
                                  title:
                                  "charger".tr,
                                  value: car.chargersTypeName ?? '',
                                ),

                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    SizedBox(height: 2.h),

                    // ===== ADD BUTTON =====
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style:
                        ElevatedButton.styleFrom(
                          backgroundColor:
                          AppColors.buttonPrimary,
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor:
                            Colors.transparent,
                            builder: (_) =>
                            const AddCarBottomSheet(),
                          );
                        },
                        child: Text(
                          "add".tr,
                          style: TextStyle(
                            color: AppColors.primary(
                                context),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 1.h),

                    // ===== SAVE BUTTON =====
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style:
                        ElevatedButton.styleFrom(
                          backgroundColor:
                          AppColors.buttonPrimary,
                        ),
                        onPressed:
                        provider.isLoading
                            ? null
                            : () {
                          context
                              .read<
                              AuthProvider>()
                              .createProfile();
                        },
                        child: provider.isLoading
                            ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                            : Text(
                          "save".tr,
                          style: TextStyle(
                            color: AppColors
                                .primary(
                                context),
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String value,
      }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 3.w,
        vertical: 1.5.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary2(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: AppColors.buttonPrimary,
          ),

          SizedBox(width: 2.w),
          Expanded(
            child: Text(
              "$title: $value",
              style: TextStyle(
                color: AppColors.textPrimary(
                    context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}