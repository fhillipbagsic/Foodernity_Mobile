import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class CategoryItem extends StatefulWidget {
  final TextEditingController foodCategoryController;
  final TextEditingController quantityController;
  final TextEditingController expiryDateController;
  final int index;

  const CategoryItem({
    Key? key,
    required this.foodCategoryController,
    required this.quantityController,
    required this.expiryDateController,
    required this.index,
  }) : super(key: key);

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  List<Text> foodCategories = [
    const Text(
      'Canned Foods',
    ),
    const Text('Canned Fruits'),
    const Text('Canned Vegetables'),
    const Text(
      'Instant Noodles',
    ),
    const Text('Eggs')
  ];
  String selectedValue = "";

  void getFoodCategories() async {
    final prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5.w, right: 5.w, top: .5.h, bottom: .5.h),
      child: Card(
        child: Padding(
          padding:
              EdgeInsets.only(left: 5.w, right: 5.w, top: .5.h, bottom: .5.h),
          child: Column(
            children: [
              TextFormField(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  _showCategoryDialog(CupertinoPicker(
                      itemExtent: 45,
                      onSelectedItemChanged: (value) {
                        Text text = foodCategories[value];
                        selectedValue = text.data.toString();
                        setState(() {
                          widget.foodCategoryController.text = selectedValue;
                        });
                      },
                      children: foodCategories));
                },
                controller: widget.foodCategoryController,
                validator: requiredValidator,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Food Category',
                    labelStyle: TextStyle(fontSize: 12.sp),
                    hintText: 'In pieces',
                    hintStyle: TextStyle(fontSize: 10.sp),
                    suffixIcon: const Icon(Icons.arrow_drop_down_rounded)),
              ),
              Divider(
                height: 1,
                thickness: .1.h,
                color: Colors.grey[300],
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: widget.quantityController,
                      validator: requiredValidator,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Quantity',
                        labelStyle: TextStyle(fontSize: 12.sp),
                        hintText: 'In pieces',
                        hintStyle: TextStyle(fontSize: 10.sp),
                      ),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  Expanded(
                    child: TextFormField(
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        DateTime date = DateTime(2016, 10, 26);
                        _showDateDialog(
                          CupertinoDatePicker(
                            initialDateTime: date,
                            mode: CupertinoDatePickerMode.date,
                            use24hFormat: true,
                            onDateTimeChanged: (DateTime newDate) {
                              setState(
                                () => widget.expiryDateController.text =
                                    newDate.month.toString() +
                                        '/' +
                                        newDate.day.toString() +
                                        '/' +
                                        newDate.year.toString(),
                              );
                            },
                          ),
                        );
                      },
                      controller: widget.expiryDateController,
                      validator: requiredValidator,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Expiry Date',
                        labelStyle: TextStyle(fontSize: 12.sp),
                        hintStyle: TextStyle(fontSize: 10.sp),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDateDialog(Widget child) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 30.h,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),

        color: CupertinoColors.systemBackground.resolveFrom(context),

        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  void _showCategoryDialog(Widget child) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => Container(
        height: 30.h,
        padding: const EdgeInsets.only(top: 6.0),
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  final requiredValidator = MultiValidator([
    RequiredValidator(errorText: 'All fields are required'),
  ]);
}
