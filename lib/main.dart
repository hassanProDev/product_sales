import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zoza_phone/controller/accessory_controller.dart';
import 'package:zoza_phone/model/model.dart';
import 'package:zoza_phone/view/add_screen.dart';
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

  androidId= await getDeviceId();
  print(androidId);
  await Hive.initFlutter();
  await Hive.openBox("data");
  if(androidId=="UP1A.231005.007"){
    runApp(MyApp());
  }else{
    runApp(MaterialApp(home: Scaffold(),));
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
        child:  MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: MainScreen.mainScreen,
            routes: {
              MainScreen.mainScreen: (_) => MainScreen(),
              AddScreen.addScreen: (_) => AddScreen(),
              UpdateScreen.updateScreen: (_) => UpdateScreen(),
              ViewItem.viewItem: (_) => ViewItem(),
            },
        ),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  static const String mainScreen = "mainScreen";
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AccessoryController prov =Provider.of<AccessoryController>(context);
  List<AccessoryModel> list = prov.getAllData().where((e) => e.name.contains(controller.text)).toList();
  
    return Scaffold(
      appBar: AppBar(
        title: Text("محمد الساحر"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            GlobalTextForm(
              hint: "Search",
              controller: controller,
              onChanged: (v) {
                prov.searchLissener();
              },
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      child: ListTile(
                        title: Text(list[index].name),
                        subtitle: Text(list[index].id),
                        trailing: Text(list[index].price.toString()),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          prov.scannerQr(AddScreen.addScreen, context);
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              prov.scannerQr(UpdateScreen.updateScreen, context);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.change_circle_outlined),
                Text("Update"),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              prov.scannerQr(ViewItem.viewItem, context);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.document_scanner_outlined),
                Text("Scann"),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
