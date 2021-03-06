import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/src/dio.dart';
import 'package:foodernity_mobile/main.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DonationService {
  Dio dio = new Dio();

  makeDonation(
      File donationImage,
      String donationName,
      List<String> foodCategories,
      List<String> quantities,
      List<String> expiryDates,
      String donatedTo) async {
    final prefs = await SharedPreferences.getInstance();

    try {
      final cloudinary =
          CloudinaryPublic('desimscj8', 'oqozctfv', cache: false);
      CloudinaryResponse response = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(donationImage.path,
              resourceType: CloudinaryResourceType.Image));

      return await dio.post(URL + 'makedonation',
          data: {
            'donationImage': response.secureUrl,
            'donationName': donationName,
            'foodCategories': foodCategories,
            'quantities': quantities,
            'expiryDates': expiryDates,
            'donatedTo': donatedTo,
            'token': prefs.getString('emailAddress')
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e.message);
    } on CloudinaryException catch (e) {
      print(e.message);
    }
  }

  getDonations() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      return await dio.post(URL + 'getdonations',
          data: {'token': prefs.getString('emailAddress')});
    } on DioError catch (e) {
      print(e.message);
    }
  }
}
