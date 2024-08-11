import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    inti();

    super.initState();
  }

  inti() async {

    Future.delayed(Duration(seconds: 2)).then((_) async {
      final remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(hours: 1),
      ));
      // await remoteConfig.setDefaults(const {
      //   "app_entry": true,
      // });

      remoteConfig.onConfigUpdated.listen((event) async {
        await remoteConfig.fetchAndActivate();
        print("ssss 222");

        bool isAppEntry =   remoteConfig.getBool("app_entry");
        print("ssss $isAppEntry");
        if(isAppEntry){
          Get.offAllNamed('/home');

        }else{
          Get.offAllNamed('/crash');

        }
        // Use the new config values here.
      });
      print("ssss 222");
      await remoteConfig.fetchAndActivate();


      bool isAppEntry =   remoteConfig.getBool("app_entry");
      print("ssss $isAppEntry");

      if(remoteConfig.getBool("app_entry")){
        Get.offAllNamed('/home');
      }else{
        Get.offAllNamed('/crash');

      }

    });

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icon/icon.png',
                width: 200,
                height: 200,
              ),

            ],
          ),
        ),
      ),
    );
  }
}