import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:wifi_hunter/wifi_hunter.dart';
import 'package:wifi_hunter/wifi_hunter_result.dart';
import 'package:permission_handler/permission_handler.dart';


class ActivityWifi extends StatefulWidget {
  const ActivityWifi({Key? key}) : super(key: key);

  @override
  State<ActivityWifi> createState() => _ActivityWifiState();
}

class _ActivityWifiState extends State<ActivityWifi> {
  WiFiHunterResult wiFiHunterResult = WiFiHunterResult();
  Color huntButtonColor = Colors.lightBlue;

  Future<void> huntWiFis() async {
    setState(() => huntButtonColor = Colors.red);

    try {
      //demandeDePermission();
      wiFiHunterResult = (await WiFiHunter.huntWiFiNetworks)!;
    } on PlatformException catch (exception) {
      print(exception.toString());
    }

    if (!mounted) return;

    setState(() => huntButtonColor = Colors.lightBlue);
  }

/*
  Future<void> demandeDePermission() async {
    List<AppPermission> permissionsList = <AppPermission>[
      AppPermission(permission: Permission.location),
    ];
      await permissionsList[0].permission.request();
      if (await permissionsList[0].permission.isGranted) {
        print("permission.isGranted");
      }
  }
 */

  Future<void> demandeDePermission() async {
    await Permission.location.request();
    if (await Permission.location.isGranted) {
      print("permission.isGranted");
    }
  }

  @override
  Widget build(BuildContext context) {
    //demandeDePermission();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('WiFiHunter example app'),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                child: ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(huntButtonColor)),
                    onPressed: () => huntWiFis(),
                    child: const Text('Hunt Networks')
                ),
              ),
              wiFiHunterResult.results.isNotEmpty ? Container(
                margin: const EdgeInsets.only(bottom: 20.0, left: 30.0, right: 30.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(wiFiHunterResult.results.length, (index) =>
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          child: ListTile(
                              leading: Text(wiFiHunterResult.results[index].level.toString() + ' dbm'),
                              title: Text(wiFiHunterResult.results[index].SSID),
                              subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('BSSID : ' + wiFiHunterResult.results[index].BSSID),
                                    Text('Capabilities : ' + wiFiHunterResult.results[index].capabilities),
                                    Text('Frequency : ' + wiFiHunterResult.results[index].frequency.toString()),
                                    Text('Channel Width : ' + wiFiHunterResult.results[index].channelWidth.toString()),
                                    Text('Timestamp : ' + wiFiHunterResult.results[index].timestamp.toString())
                                  ]
                              )
                          ),
                        )
                    )
                ),
              ) : Container()
            ],
          ),
        ),
      ),
    );
  }
}


class AppPermission{
  Permission permission;
  String status;

  AppPermission({
    this.status = "Unknown",
    required this.permission,
  });
}

/*
List<AppPermission> permissionsList = <AppPermission>[
  // AppPermission(permission: Permission.camera),
  // AppPermission(permission: Permission.bluetooth),
  // AppPermission(permission: Permission.calendar),
  // AppPermission(permission: Permission.contacts),
  AppPermission(permission: Permission.location),
  // AppPermission(permission: Permission.microphone),
  // AppPermission(permission: Permission.notification),
  // AppPermission(permission: Permission.phone),
  // AppPermission(permission: Permission.storage),
  // AppPermission(permission: Permission.photos),
  // AppPermission(permission: Permission.sensors),
  // AppPermission(permission: Permission.sms),
  // AppPermission(permission: Permission.reminders),
  // AppPermission(permission: Permission.bluetoothConnect),
];
 */