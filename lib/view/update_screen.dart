import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoza_phone/controller/accessory_controller.dart';
import 'package:zoza_phone/model/model.dart';
import 'package:zoza_phone/view/widget/global_text_form.dart';

class UpdateScreen extends StatelessWidget {
  static const String updateScreen = "updateScreen";
  final formKey = GlobalKey<FormState>();
  TextEditingController id = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AccessoryModel accessoryModel =
        ModalRoute.of(context)?.settings.arguments as AccessoryModel;
    id.text = accessoryModel.id;
    name.text = accessoryModel.name;
    price.text = accessoryModel.price.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text("محمد الساحر"),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GlobalTextForm(
                hint: "id",
                controller: id,
                enabled: false,
              ),
              GlobalTextForm(
                hint: "Name",
                controller: name,
              ),
              GlobalTextForm(
                hint: "Price",
                controller: price,
                textInputType: TextInputType.number,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      accessoryModel.name = name.text;
                      accessoryModel.id = id.text;
                      accessoryModel.price = double.parse(price.text);
                      Provider.of<AccessoryController>(context, listen: false)
                          .updateAccessory(accessoryModel);
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Update"))
            ],
          ),
        ),
      ),
    );
  }
}
