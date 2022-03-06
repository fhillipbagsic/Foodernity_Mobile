import 'dart:io';
import 'package:foodernity_mobile/Pages/MakeDonation/CategoryItem.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:image_picker/image_picker.dart';

class MakeDonation extends StatefulWidget {
  const MakeDonation({Key? key}) : super(key: key);

  @override
  State<MakeDonation> createState() => _MakeDonationState();
}

class _MakeDonationState extends State<MakeDonation> {
  final _formKey = GlobalKey<FormState>();
  File? donationImage;
  String noDonationImage = '';
  TextEditingController donationNameController = TextEditingController();
  List<CategoryItem> categoryItems = [];
  List<TextEditingController> controllers = [TextEditingController()];
  TextEditingController initialFoodCategoryController = TextEditingController();
  TextEditingController initialQuantityController = TextEditingController();
  TextEditingController initialExpiryDateController = TextEditingController();
  List<String> selectedFoodCategories = [];

  void addFoodCategory() {
    TextEditingController foodCategoryController = TextEditingController();
    TextEditingController quantityController = TextEditingController();
    TextEditingController expiryDateController = TextEditingController();

    controllers.addAll(
        [foodCategoryController, quantityController, expiryDateController]);
    categoryItems.add(CategoryItem(
      foodCategoryController: foodCategoryController,
      quantityController: quantityController,
      expiryDateController: expiryDateController,
      index: categoryItems.length,
    ));
  }

  void addSelectedFoodCategory(String foodCategory) {
    setState(() {
      selectedFoodCategories.add('abc');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: Colors.grey[100],
        child: Form(
          key: _formKey,
          child: CustomScrollView(slivers: [
            CupertinoSliverNavigationBar(
              largeTitle: const Text('Make a Donation'),
              automaticallyImplyLeading: true,
              trailing: GestureDetector(
                  child: Text(
                    'Done',
                    style: TextStyle(color: Colors.blue, fontSize: 12.sp),
                  ),
                  onTap: () {
                    if (donationImage != null) {
                      if (_formKey.currentState!.validate()) {
                        print('all goods');
                      }
                    } else {
                      setState(() {
                        noDonationImage = 'No Donation Image';
                      });
                    }
                  }),
            ),
            _donationImage(),
            _donationName(donationNameController),
            SliverToBoxAdapter(
              child: CategoryItem(
                foodCategoryController: initialFoodCategoryController,
                quantityController: initialQuantityController,
                expiryDateController: initialExpiryDateController,
                index: -1,
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: categoryItems
                    .map((item) => CategoryItem(
                          foodCategoryController: item.foodCategoryController,
                          quantityController: item.quantityController,
                          expiryDateController: item.expiryDateController,
                          index: item.index,
                        ))
                    .toList(),
              ),
            ),
            //_dropoffLocation(),
            categoryItems.length == 3
                ? const SliverToBoxAdapter(
                    child: SizedBox(),
                  )
                : _addAnotherCategory(),
            SliverToBoxAdapter(
              child: ElevatedButton(
                  onPressed: () {
                    print('hello');
                    for (int i = 0; i < selectedFoodCategories.length; i++) {
                      print(selectedFoodCategories[i]);
                    }
                  },
                  child: Text('get selected food categories')),
            )
          ]),
        ),
      )),
    );
  }

  Widget _donationImage() {
    Future<void> uploadImage() async {
      if (await Permission.photos.request().isGranted) {
        final picker = ImagePicker();

        final XFile? pickedImage =
            await picker.pickImage(source: ImageSource.gallery);

        if (pickedImage != null && pickedImage.path != '') {
          setState(() {
            donationImage = File(pickedImage.path);
            noDonationImage = '';
          });
        }
      } else if (await Permission.photos.isDenied ||
          await Permission.photos.isPermanentlyDenied) {
        openAppSettings();
        setState(() {});
      }
    }

    return SliverToBoxAdapter(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin:
              EdgeInsets.only(left: 5.w, right: 5.w, top: 2.h, bottom: .5.h),
          height: 20.h,
          width: double.infinity,
          child: Card(
            child: donationImage == null
                ? Center(
                    child: ElevatedButton(
                    onPressed: () {
                      uploadImage();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.photo_rounded,
                          color: Colors.blue,
                          size: 14.sp,
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        Text('Upload an image',
                            style:
                                TextStyle(color: Colors.blue, fontSize: 10.sp))
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.white, shadowColor: Colors.transparent),
                  ))
                : GestureDetector(
                    onTap: () => uploadImage(),
                    child: Image.file(
                      donationImage as File,
                      fit: BoxFit.contain,
                    ),
                  ),
          ),
        ),
        noDonationImage == 'No Donation Image'
            ? Container(
                margin: EdgeInsets.only(left: 7.w, bottom: 1.h),
                child: Text(
                  'Please upload an image',
                  style: TextStyle(fontSize: 10.sp, color: Colors.red),
                ),
              )
            : const SizedBox()
      ],
    ));
  }

  Widget _donationName(TextEditingController controller) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(left: 5.w, right: 5.w, top: .5.h, bottom: .5.h),
        child: Card(
          child: Padding(
            padding: EdgeInsets.only(left: 2.5.w, right: 2.5.w),
            child: TextFormField(
              controller: controller,
              validator: donationNameValidator,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: 'What are you donating?',
                labelStyle: TextStyle(fontSize: 12.sp),
              ),
            ),
          ),
        ),
      ),
    );
  }

  final donationNameValidator = MultiValidator([
    RequiredValidator(errorText: 'This field is required'),
    MinLengthValidator(4, errorText: 'Minimum characters is at least 4')
  ]);

  Widget _dropoffLocation() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(left: 6.w, right: 6.w, top: 1.h, bottom: 1.h),
        padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 1.5.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.sp),
            border: Border.all(color: Colors.blue),
            color: Colors.blue[100]),
        child: Row(children: [
          Icon(
            Icons.location_on_rounded,
            color: Colors.blue,
            size: 14.sp,
          ),
          SizedBox(
            width: 1.w,
          ),
          Expanded(
              child: Text(
            'Location for drop off',
            style: TextStyle(fontSize: 12.sp, color: Colors.blue),
          )),
        ]),
      ),
    );
  }

  Widget _addAnotherCategory() {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(left: 6.w, right: 6.w, top: .5.h, bottom: .5.h),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              addFoodCategory();
            });
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                size: 14.sp,
              ),
              SizedBox(
                width: 1.w,
              ),
              Text(
                'Add another food category',
                style: TextStyle(fontSize: 10.sp),
              )
            ],
          ),
        ),
      ),
    );
  }
}
