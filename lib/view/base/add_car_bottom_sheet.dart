import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../helper/constants/constants.dart';
import '../../helper/end_points.dart';
import '../../helper/helper.dart';
import '../../model/car/car_model.dart';
import '../../model/car/chargers_types_model.dart';
import '../../provider/auth/auth_provider.dart';
import 'custom_generic_searchable_dropdown.dart';
import 'custom_text_field.dart';

class AddCarBottomSheet extends StatelessWidget {
  const AddCarBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, provider, child) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          decoration: BoxDecoration(
            color: AppColors.backgroundPrimary(context),
            borderRadius:
            const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// ===== Car Name =====
              CustomTextField(
                controller: provider.carNameController,
                hint: "car_name".tr,
                icon: Icons.directions_car,
              ),

              SizedBox(height: 2.h),

              /// ===== Car Number =====
              CustomTextField(
                controller: provider.carNoController,
                hint:
                "vehicle_identification_number".tr,
                icon: Icons.numbers,
              ),

              SizedBox(height: 2.h),

              /// ===== Charger Type =====
              Container(
                margin:
                EdgeInsets.only(bottom: 2.h),
                child: SearchableGenericDropdown<
                    ChargersTypesModel>(
                  label: "connector_type".tr,
                  items: provider.chargersTypes,
                  selectedItem:
                  provider.selectedChargersTypeName,
                  itemLabel: (sub) =>
                  sub.name ?? '',
                  onChanged: (sub) {
                    provider.selectItem(
                      obj: sub,
                      type:
                      "ChargersTypeName",
                    );
                  },
                ),
              ),

              SizedBox(height: 2.h),

              /// ===== ADD BUTTON =====
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style:
                  ElevatedButton.styleFrom(
                    backgroundColor:
                    AppColors.buttonPrimary,
                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(
                          12),
                    ),
                  ),
                  onPressed: () {
                    try {
                      provider.validateAddCar();
                      provider
                          .validateDuplicateCar();

                      provider.addCar(
                        CarModel(
                          carName: provider
                              .carNameController
                              .text,
                          carNo: provider
                              .carNoController
                              .text,
                          ampere: provider
                              .selectedChargersTypeName
                              ?.ampere,
                          chargersTypeID: provider
                              .selectedChargersTypeName
                              ?.id,
                          carID: 0,
                          companyID: 0,
                          customerID:
                          box.read("userId"),
                          chargersTypeName:
                          provider
                              .selectedChargersTypeName
                              ?.name,
                        ),
                      );

                      provider
                          .carNameController
                          .clear();
                      provider
                          .carNoController
                          .clear();

                      Navigator.pop(context);
                    } catch (e) {
                      Helper.showErrorMessage(
                        msg: e.toString(),
                      );
                    }
                  },
                  child: Text(
                    "add".tr,
                    style: TextStyle(
                      color: AppColors
                          .backgroundPrimary(
                          context),
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 1.h),
            ],
          ),
        );
      },
    );
  }
}