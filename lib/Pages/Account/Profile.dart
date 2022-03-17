import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodernity_mobile/Classes/Account.dart';
import 'package:foodernity_mobile/Services/Account.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  bool readOnly = true;
  bool madeChanges = false;
  bool changeImage = false;

  late Future<Account> futureProfile;
  late String profilePicture;
  late File newProfilePicture;
  late bool newHidden;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // futureNotifications = getNotifications();
    futureProfile = getAccount();
  }

  Future<Account> getAccount() async {
    Response response;
    response = await AccountService().getAccount();
    Account account = Account.fromJSON(response.data['value']);
    profilePicture = account.profilePicture;
    fullNameController.text = account.fullName;
    emailAddressController.text = account.emailAddress;
    newHidden = account.hidden;
    return account;
  }

  void saveAccount() async {
    Response response;
    String profilePicturePath =
        changeImage ? newProfilePicture.path : profilePicture;
    response = await AccountService().saveAccount(profilePicturePath,
        fullNameController.text, passwordController.text, newHidden);

    if (response.data['status'] == 'ok') {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 1),
          content: Text(
            'Profile updated',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: futureProfile,
          builder: ((context, AsyncSnapshot snapshot) {
            Widget donationsSliverList;
            if (snapshot.hasData) {
              donationsSliverList = SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _profilePicture(profilePicture),
                        readOnly
                            ? SizedBox(
                                height: 1.5.h,
                              )
                            : _uploadProfilePicture(),
                        _hidden(newHidden),
                        const SizedBox(
                          height: 10,
                        ),
                        _field('Full Name', fullNameController),
                        SizedBox(
                          height: 2.h,
                        ),
                        _field('Email Address', emailAddressController),
                        SizedBox(
                          height: 3.h,
                        ),
                        _field('Password', passwordController),
                        SizedBox(
                          height: 3.h,
                        ),
                        _confirmPasswordField(confirmPasswordController)
                      ],
                    ),
                  ),
                ),
              );
            } else {
              donationsSliverList = SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(top: 5.h),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }
            return Container(
              color: Colors.grey[100],
              child: CustomScrollView(
                slivers: [
                  CupertinoSliverNavigationBar(
                    largeTitle: const Text('Profile'),
                    trailing: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (readOnly) {
                            readOnly = false;
                          } else if (!readOnly && !madeChanges) {
                            readOnly = true;
                          } else {
                            if (_formKey.currentState!.validate()) {
                              saveAccount();
                            }
                          }
                        });
                      },
                      child: Text(
                        readOnly
                            ? 'Edit'
                            : madeChanges
                                ? 'Save'
                                : 'Cancel',
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                  donationsSliverList
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _profilePicture(String profilePicture) {
    return changeImage
        ? Image.file(
            newProfilePicture,
            width: 24.w,
            height: 12.h,
            fit: BoxFit.cover,
          )
        : Image.network(
            profilePicture,
            width: 24.w,
            height: 12.h,
            fit: BoxFit.cover,
          );
  }

  Widget _uploadProfilePicture() {
    Future<void> uploadImage() async {
      print('heelo');
      if (await Permission.photos.request().isGranted) {
        final picker = ImagePicker();

        final XFile? pickedImage =
            await picker.pickImage(source: ImageSource.gallery);

        print(pickedImage);
        if (pickedImage != null && pickedImage.path != '') {
          setState(() {
            changeImage = true;
            madeChanges = true;
            newProfilePicture = File(pickedImage.path);
          });
        }
      } else if (await Permission.photos.isDenied ||
          await Permission.photos.isPermanentlyDenied) {
        openAppSettings();
        setState(() {});
      }
    }

    return CupertinoButton(
        child: Text(
          'Upload new image',
          style: TextStyle(fontSize: 12.sp),
        ),
        onPressed: () {
          uploadImage();
          print('heels');
        });
  }

  Widget _hidden(bool hidden) {
    String description = '';
    IconData icon;

    if (hidden) {
      description = 'Profile is hidden';
      icon = Icons.visibility_off_rounded;
    } else {
      description = 'Profile is visible';
      icon = Icons.visibility_rounded;
    }
    return readOnly
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 15.sp,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                description,
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
              )
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                  value: hidden,
                  onChanged: readOnly
                      ? null
                      : (bool? value) {
                          newHidden = !newHidden;
                          setState(() {
                            madeChanges = true;
                          });
                        }),
              Text(
                'Set Profile Visibility',
                style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500),
              )
            ],
          );
  }

  Widget _field(String fieldName, TextEditingController controller) {
    return TextFormField(
      onChanged: (value) {
        setState(() {
          madeChanges = true;
        });
      },
      controller: controller,
      readOnly: fieldName == 'Email Address' ? true : readOnly,
      validator: fieldName == 'Full Name'
          ? fullNameValidator
          : fieldName == 'Password'
              ? passwordValidator
              : RequiredValidator(errorText: ''),
      autocorrect: false,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: fieldName,
        labelStyle: TextStyle(fontSize: 12.sp),
        helperText: getHelperText(fieldName),
      ),
      obscureText: fieldName == 'Password' ? true : false,
    );
  }

  Widget _confirmPasswordField(TextEditingController controller) {
    return TextFormField(
      readOnly: readOnly,
      controller: controller,
      validator: (val) => MatchValidator(errorText: 'Passwords do not match')
          .validateMatch(
              confirmPasswordController.text, passwordController.text),
      autocorrect: false,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: 'Confirm Password',
        labelStyle: TextStyle(fontSize: 12.sp),
        helperText: getHelperText('Confirm Password'),
        suffixIcon: IconButton(
          onPressed: () => confirmPasswordController.clear(),
          icon: Icon(
            Icons.clear,
            size: 13.sp,
          ),
        ),
      ),
      obscureText: true,
    );
  }

  String getHelperText(String fieldName) {
    switch (fieldName) {
      case 'Full Name':
        return 'Your first and last name';
      case 'Password':
        return 'Must be at least 8 characters long';
      case 'Email Address':
        return 'Email address cannot be changed anymore';
    }
    return '';
  }

  final fullNameValidator = MultiValidator([
    RequiredValidator(errorText: 'Full name is required'),
    PatternValidator(r'^[a-zA-Z ]+$', errorText: 'Only letters are allowed'),
    MinLengthValidator(3, errorText: 'Please enter your full name')
  ]);

  final passwordValidator = MultiValidator([
    MinLengthValidator(8, errorText: 'Password must be at least 8 digits long'),
    PatternValidator(r'^[a-zA-Z0-9]+$',
        errorText: 'Password must not have special character')
  ]);
}
