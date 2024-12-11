import 'dart:io';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zoza_phone/controller/accessory_controller.dart';
import 'package:zoza_phone/model/model.dart';
import 'package:zoza_phone/view/add_screen.dart';
import 'package:zoza_phone/view/generate_qr.dart';
import 'package:zoza_phone/view/main_screen/main_srceen.dart';
import 'package:zoza_phone/view/update_screen.dart';
import 'package:zoza_phone/view/view_item.dart';
import 'package:zoza_phone/view/widget/global_text_form.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String androidId = "";

  Future<String> getDeviceId() async {
    if (Platform.isAndroid) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id;
    }
    return "";
  }

  androidId = await getDeviceId();
  print(androidId);
  await Hive.initFlutter();
  await Hive.openBox("data");
  if (androidId == "UP1A.231005.007") {
    runApp(MyApp());
  } else {
    runApp(MaterialApp(
      home: Scaffold(),
    ));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ChangeNotifierProvider(
        create: (BuildContext context) {
          return AccessoryController();
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: MainScreen.mainScreen,
          routes: {
            MainScreen.mainScreen: (_) => MainScreen(),
            AddScreen.addScreen: (_) => AddScreen(),
            UpdateScreen.updateScreen: (_) => UpdateScreen(),
            ViewItem.viewItem: (_) => ViewItem(),
            ProductQRGeneratorScreen.productQrScreen: (_) => ProductQRGeneratorScreen(),
          },
        ),
      ),
    );
  }
}

