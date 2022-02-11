// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restro_booking/model/table_model.dart';
import 'package:restro_booking/providers/table_provider.dart';
import 'package:restro_booking/providers/user_provider.dart';
import 'package:restro_booking/screen/bottomNavBar.dart';
import 'package:motion_toast/motion_toast.dart';

class MyTableScreen extends StatefulWidget {
  const MyTableScreen({Key? key}) : super(key: key);

  @override
  State<MyTableScreen> createState() => _MyTableScreenState();
}

class _MyTableScreenState extends State<MyTableScreen> {
  @override
  void initState() {
    super.initState();
    final tblMdl = Provider.of<TableProvider>(context, listen: false);
    final usrMdl = Provider.of<UserProvider>(context, listen: false);
    tblMdl.getMyTables(usrMdl.user.userId, usrMdl.user.token);
  }

  Future<bool> delTable(tableId) async {
    final tblMdl = Provider.of<TableProvider>(context, listen: false);
    final usrMdl = Provider.of<UserProvider>(context, listen: false);
    final result = await tblMdl.deleteTable(tableId, usrMdl.user.token);
    return result;
  }

  Widget createCard(table) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        color: Color(0xFFF6F2EC),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: ListTile(
            leading: Icon(
              Icons.table_chart_rounded,
              size: 50,
              color: Color(0xFFEE6A3E),
            ),
            title: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Table Number: ${table.table_number}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text('Minimum Capacity: ${table.min_capacity}'),
                SizedBox(
                  height: 5,
                ),
                Text('Maximum Capacity: ${table.max_capacity}'),
                SizedBox(
                  height: 5,
                ),
                Text('Available: ${table.is_available}')
              ],
            ),
            subtitle: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    tooltip: 'Update Table',
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/update-table',
                        arguments: {"id": table.id},
                      );
                    },
                    color: Color(0xFF004194),
                  ),
                  IconButton(
                    onPressed: () async {
                      var deleted = await delTable(table.id);
                      if (deleted) {
                        MotionToast.success(
                          description: Text('Table Deleted'),
                        ).show(context);
                      } else {
                        MotionToast.error(
                          description: Text('Error in deleting table'),
                        ).show(context);
                      }
                    },
                    icon: Icon(Icons.delete),
                    tooltip: 'Delete Table',
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF004194),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.zero,
                    bottom: Radius.circular(35),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Center(
                    child: Column(
                      children: const [
                        Text(
                          'My Tables',
                          textScaleFactor: 1.5,
                          style: TextStyle(
                            color: Color(0xFFF6F2EC),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'Here is the list of tables that you have created!',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Color(0xFFF6F2EC),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 25,
                ),
                child: Consumer<TableProvider>(
                  builder: (context, value, child) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: value.table.length,
                      itemBuilder: (context, index) {
                        return createCard(value.table[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: getBusinessBottomNavBar(context),
    );
  }
}
