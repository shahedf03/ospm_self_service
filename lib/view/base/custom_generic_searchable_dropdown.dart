import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../helper/constants/constants.dart';

class SearchableGenericDropdown<T> extends StatefulWidget {
  final List<T> items;
  final T? selectedItem;
  final String Function(T) itemLabel;
  final void Function(T) onChanged;
  final String label;
  final double maxHeight;
  final bool showRef;

  const SearchableGenericDropdown({
    super.key,
    required this.items,
    required this.itemLabel,
    required this.onChanged,
    required this.label,
    this.selectedItem,
    this.maxHeight = 300,
    this.showRef = false,
  });

  @override
  State<SearchableGenericDropdown<T>> createState() =>
      _SearchableGenericDropdownState<T>();
}

class _SearchableGenericDropdownState<T>
    extends State<SearchableGenericDropdown<T>> {
  T? _selected;

  @override
  void initState() {
    super.initState();
    if (widget.items.isNotEmpty && widget.selectedItem == null) {
      _selected = widget.items[0];
    } else {
      _selected = widget.selectedItem;
    }
  }

  void _openDropdown() async {
    List<T> tempList = List.from(widget.items);

    final result = await showDialog<T>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            void filter(String query) {
              setStateDialog(() {
                if (query.isEmpty) {
                  tempList = List.from(widget.items);
                } else {
                  tempList = widget.items
                      .where(
                        (item) => widget
                        .itemLabel(item)
                        .toLowerCase()
                        .contains(query.toLowerCase()),
                  )
                      .toList();
                }
              });
            }

            return AlertDialog(
              title: Text(widget.label),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      onChanged: filter,
                      decoration: InputDecoration(
                        hintText: "search".tr,
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.buttonPrimary),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.buttonPrimary),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.buttonPrimary, width: 2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.maxFinite,
                      height: widget.maxHeight,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: tempList.length,
                        itemBuilder: (context, index) {
                          final item = tempList[index];
                          return ListTile(
                            title: Text(widget.itemLabel(item)),
                            onTap: () => Navigator.pop(context, item),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    if (result != null) {
      setState(() {
        _selected = result;
      });
      widget.onChanged(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _openDropdown,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(
            color: AppColors.buttonPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 15.sp,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.buttonPrimary),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.buttonPrimary),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.buttonPrimary, width: 2),
          ),
        ),
        child: Text(
          _selected != null
              ? widget.itemLabel(_selected!)
              : (widget.items.isNotEmpty
              ? (() {
            _selected = widget.items[0];
            return widget.itemLabel(widget.items[0]);
          })()
              : 'tap_to_select'.tr),
          style: TextStyle(fontSize: 15.sp, color: AppColors.iconSecondary(context)),
        ),
      ),
    );
  }
}
