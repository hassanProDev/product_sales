import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:zoza_phone/model/model.dart';

class ItemWidget extends StatelessWidget {
  void Function(BuildContext context)? slidBtn;
  Color? backgroundColor;
  Color? foregroundColor;
  IconData? iconData;
  String? label;
  AccessoryModel accessoryModel;
  ItemWidget({
    super.key,
    this.iconData,
    this.foregroundColor,
    this.backgroundColor,
    this.slidBtn,
    this.label,
    required this.accessoryModel
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: slidBtn,
            backgroundColor: backgroundColor ?? Color(0xFFFE4A49),
            foregroundColor: foregroundColor ?? Colors.white,
            icon: iconData ?? Icons.delete,
            label:label?? 'Delete',
          ),
        ],
      ),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: ListTile(
          title: Text(accessoryModel.name),
          subtitle: Text(accessoryModel.id),
          trailing: Text(accessoryModel.price.toString()),
        ),
      ),
    );
  }
}
