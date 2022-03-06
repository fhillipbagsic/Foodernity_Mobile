import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodernity_mobile/Pages/Home.dart';
import 'package:foodernity_mobile/Pages/Signinup/Signin.dart';
import 'package:sizer/sizer.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  Future<void> initConnectivity() async {
    late ConnectivityResult result;

    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print('Couldnt check connectivity status');
      return;
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      print('Has internet connectivity');
    } else {
      _showDialog(context);
    }
  }

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Foodernity',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Sizer(builder: ((context, orientation, deviceType) {
          return const Home();
        })));
  }

  void _showDialog(context) {
    showDialog(
        context: context,
        builder: (context) {
          return Scaffold(
            body: SafeArea(
                child: AlertDialog(
              title: const Text('No Internet Connection'),
              content: const Text(
                  'The app requires internet connectivity to be used. Please check your connection and try again.'),
              actions: [
                ElevatedButton(
                    onPressed: () => exit(0), child: const Text('Quit'))
              ],
            )),
          );
        });
  }
}
