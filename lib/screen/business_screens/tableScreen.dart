import 'package:flutter/material.dart';
import 'package:restro_booking/screen/business_screens/get_table_item_screen.dart';

class TableScreen extends StatelessWidget {
  const TableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return getTableItemScreen(
      context,
      {
        "addBtnText": "Add New Table",
        "addBtnRoute": "/addTable",
        "viewBtnText": "View My Tables",
        "viewBtnRoute": "/my-tables",
      },
    );
  }
}
