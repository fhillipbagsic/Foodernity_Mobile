import 'package:dio/dio.dart';
import 'package:foodernity_mobile/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CallForDonationService {
  Dio dio = new Dio();

  getCallForDonations() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      return await dio.post(URL + 'getcallfordonations',
          data: {
            'status': ['Active'],
            'token': prefs.getString('emailAddress')
          },
          options: Options(contentType: Headers.formUrlEncodedContentType));
    } on DioError catch (e) {
      print(e.message);
    }
  }
}
