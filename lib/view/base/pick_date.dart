import 'package:flutter/cupertino.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:sizer/sizer.dart';

import '../../helper/constants/constants.dart';

class IOSDatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateChanged;
  final VoidCallback onCancel;
  final VoidCallback onDone;

  const IOSDatePicker({
    super.key,
    required this.selectedDate,
    required this.onDateChanged,
    required this.onCancel,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    DateTime tempDate = selectedDate;
    final int startYear = 1940;
    final int endYear = DateTime.now().year;
    final int totalYears = endYear - startYear + 1;

    return Container(
      height: 30.h,
      color: AppColors.backgroundPrimary(context),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.cardBackground(context),
              border: Border(
                bottom: BorderSide(color: AppColors.border(context)),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: onCancel,
                  child: Text(
                    "cancel".tr,
                    style: TextStyle(
                      color: AppColors.textSecondary(context),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    onDateChanged(tempDate);
                    onDone();
                  },
                  child: Text(
                    "done".tr,
                    style: TextStyle(
                      color: AppColors.buttonPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: CupertinoPicker(
                    backgroundColor: AppColors.primary(context),
                    itemExtent: 32,
                    scrollController: FixedExtentScrollController(
                      initialItem: selectedDate.day - 1,
                    ),
                    onSelectedItemChanged: (index) {
                      tempDate = DateTime(
                        tempDate.year,
                        tempDate.month,
                        index + 1,
                      );
                    },
                    children: List.generate(
                      31,
                          (index) => Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: AppColors.textPrimary(context),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: CupertinoPicker(
                    backgroundColor: AppColors.primary(context),
                    itemExtent: 32,
                    scrollController: FixedExtentScrollController(
                      initialItem: selectedDate.month - 1,
                    ),
                    onSelectedItemChanged: (index) {
                      tempDate = DateTime(
                        tempDate.year,
                        index + 1,
                        tempDate.day,
                      );
                    },
                    children: List.generate(
                      12,
                          (index) => Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: AppColors.textPrimary(context),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: CupertinoPicker(
                    backgroundColor: AppColors.primary(context),
                    itemExtent: 32,
                    scrollController: FixedExtentScrollController(
                      initialItem: selectedDate.year - startYear,
                    ),
                    onSelectedItemChanged: (index) {
                      tempDate = DateTime(
                        startYear + index,
                        tempDate.month,
                        tempDate.day,
                      );
                    },
                    children: List.generate(
                      totalYears,
                          (index) => Center(
                        child: Text(
                          '${startYear + index}',
                          style: TextStyle(
                            color: AppColors.textPrimary(context),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}