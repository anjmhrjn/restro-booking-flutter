import 'package:flutter/material.dart';
import 'package:restro_booking/screen/bottomNavBar.dart';
import 'package:restro_booking/screen/business_screens/get_table_item_screen.dart';

class ItemScreen extends StatelessWidget {
  const ItemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getTableItemScreen(context, {
      "addBtnText": "Add New Item",
      "viewBtnText": "View My Items",
    });
  }
}
