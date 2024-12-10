import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:zoza_phone/model/model.dart';
import 'package:zoza_phone/view/add_screen.dart';
import 'package:zoza_phone/view/update_screen.dart';
import 'package:zoza_phone/view/view_item.dart';

class AccessoryController with ChangeNotifier {
  final String _accessoryKey = "accessory";

  void scannerQr(String nav, BuildContext context) async {
    String? res = await SimpleBarcodeScanner.scanBarcode(
      context,
      barcodeAppBar: const BarcodeAppBar(
        appBarTitle: 'Test',
        centerTitle: false,
        enableBackButton: true,
      ),
      isShowFlashIcon: true,
      delayMillis: 2000,
      cameraFace: CameraFace.back,
    );

    if (res != null) {
      if (nav == AddScreen.addScreen) {
        if (getData(res).price == -1) {
          Navigator.pushNamed(context, nav, arguments: res);
        }
      }

      if (nav == UpdateScreen.updateScreen) {
        if (getData(res).price!=-1) {
          Navigator.pushNamed(context, nav, arguments: getData(res));
        }
      }
      if (nav == ViewItem.viewItem) {
        if (getData(res).price!=-1) {
          Navigator.pushNamed(context, nav, arguments: getData(res));
        }
      }
    }
  }

  void deleteById(String id){
    List list=Hive.box("data").get(_accessoryKey);
    list.map((e)=>AccessoryModel.fromJson(e)).toList().removeWhere((e)=>e.id==id);
    notifyListeners();
  }

  void deleteWithQr(BuildContext context)async{
    String? res = await SimpleBarcodeScanner.scanBarcode(
      context,
      barcodeAppBar: const BarcodeAppBar(
        appBarTitle: 'Test',
        centerTitle: false,
        enableBackButton: true,
      ),
      isShowFlashIcon: true,
      delayMillis: 2000,
      cameraFace: CameraFace.back,
    );
    if(res!=null){
      deleteById(res);
    }
  }
  void searchLissener() {
    notifyListeners();
  }

  void addAccessory(AccessoryModel accessory) {
    List list = Hive.box("data").get(_accessoryKey, defaultValue: []);
    list.add(accessory.toJson());
    Hive.box("data").put(_accessoryKey, list);
    notifyListeners();
  }

  void updateAccessory(AccessoryModel accessory) {
    List list = Hive.box("data").get(_accessoryKey, defaultValue: []);
    list.removeWhere((e) => AccessoryModel.fromJson(e).id == accessory.id);
    list.add(accessory.toJson());
    Hive.box("data").put(_accessoryKey, list);
    notifyListeners();
  }

  AccessoryModel getData(String id) {
    List list = Hive.box("data").get(_accessoryKey, defaultValue: []);
    return list.map((e)=>AccessoryModel.fromJson(e)).firstWhere((e) => e.id == id,
        orElse: () {
      return AccessoryModel(name: "name", id: "id", price: -1);
    });
  }

  List<AccessoryModel> getAllData() {
    List list = Hive.box("data").get(_accessoryKey, defaultValue: []);
    return list.map((e) => AccessoryModel.fromJson(e)).toList();
  }
}
