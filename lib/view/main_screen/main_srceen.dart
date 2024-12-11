import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoza_phone/controller/accessory_controller.dart';
import 'package:zoza_phone/model/model.dart';
import 'package:zoza_phone/view/add_screen.dart';
import 'package:zoza_phone/view/main_screen/widget/main_bottom_bar.dart';
import 'package:zoza_phone/view/main_screen/widget/main_drawer.dart';
import 'package:zoza_phone/view/widget/global_text_form.dart';
import 'package:zoza_phone/view/main_screen/widget/item_widget.dart';

class MainScreen extends StatelessWidget {
  static const String mainScreen = "mainScreen";
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AccessoryController prov = Provider.of<AccessoryController>(context);
    List<AccessoryModel> list = prov
        .getAllData()
        .where((e) => e.name.contains(controller.text))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text("محمد الساحر"),
        centerTitle: true,
      ),
      drawer: MainDrawer(),
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
                  return ItemWidget(
                    accessoryModel: list[index],
                    slidBtn: (context) {
                      prov.deleteById(list[index].id);
                    },
                  );
                },
              ),
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
      bottomNavigationBar: MainBottomBar(),
    );
  }
}
