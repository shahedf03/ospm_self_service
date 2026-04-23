import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:sizer/sizer.dart';

import '../../helper/constants/constants.dart';
import '../../helper/helper.dart';
import '../../provider/station_provider.dart';

class PricesBottomSheet {
  static void show(
      BuildContext context,
      StationProvider provider,
      ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Container(
          height: 100.h,
          padding: EdgeInsets.only(
            top: 4.h,
            left: 4.w,
            right: 4.w,
            bottom: 2.h,
          ),
          decoration: BoxDecoration(
            color: AppColors.primary(context),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(25),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [

              /// ================= HEADER =================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.buttonPrimary,
                      size: 5.w,
                    ),
                  ),

                  Text(
                    "time_based_pricing".tr,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary(context),
                    ),
                  ),

                  SizedBox(width: 10.w),
                ],
              ),

              SizedBox(height: 1.h),

              /// HANDLE
              Center(
                child: Container(
                  width: 10.w,
                  height: 0.5.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),

              SizedBox(height: 2.h),

              /// ================= LIST =================
              Expanded(
                child: ListView.separated(
                  itemCount: provider.prices.length,
                  separatorBuilder: (_, __) =>
                      SizedBox(height: 1.h),
                  itemBuilder: (context, index) {
                    final price = provider.prices[index];
                    final isCurrent = price.isCurrent == true;

                    return Container(
                      padding: EdgeInsets.all(3.w),
                      decoration: BoxDecoration(
                        color: AppColors.primary2(context),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: isCurrent
                              ? AppColors.buttonPrimary
                              : AppColors.border(context),
                        ),
                      ),
                      child: Row(
                        children: [

                          /// ================= ICON =================
                          Column(
                            children: [
                              Icon(
                                Icons.electric_bolt,
                                color: AppColors.buttonPrimary,
                                size: 6.w,
                              ),

                              SizedBox(height: 1.h),

                              if (isCurrent)
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 2.w,
                                    vertical: 0.5.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.buttonPrimary,
                                    borderRadius:
                                    BorderRadius.circular(8),
                                  ),
                                  child: const Text(
                                    "Current",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          SizedBox(width: 3.w),

                          /// ================= INFO =================
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.end,
                              children: [

                                /// PRICE
                                Text(
                            "${price.price} ${"JOD".tr} : ${"price".tr}",
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold,
                                    color:
                                    AppColors.textPrimary(context),
                                  ),
                                ),

                                SizedBox(height: 0.5.h),

                                Text(
                                  "${"time".tr}: ${Helper.formatTimeTo12Hour(price.fromDateTime ?? '')} - ${Helper.formatTimeTo12Hour(price.toDateTime ?? '')}",                                  style: TextStyle(
                                    color: AppColors.textHint(context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}