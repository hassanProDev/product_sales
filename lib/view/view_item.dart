import 'package:flutter/material.dart';

import '../model/model.dart';

class ViewItem extends StatelessWidget {
  static const String viewItem = "viewItemScreen";

  @override
  Widget build(BuildContext context) {AccessoryModel accessoryModel =
  ModalRoute.of(context)?.settings.arguments as AccessoryModel;
    return Scaffold(      appBar: AppBar(
      title: Text("محمد الساحر"),
      centerTitle: true,
    ),
      body: Center(
        child: Card(elevation: 15,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: EdgeInsets.all(18.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 15,
                ),
                Text("Id ${accessoryModel.id}"),
                SizedBox(
                  height: 15,
                ),
                Text("Name ${accessoryModel.name}"),
                SizedBox(
                  height: 15,
                ),
                Text("Price ${accessoryModel.price}"),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
