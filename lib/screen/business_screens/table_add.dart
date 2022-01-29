import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import 'package:restro_booking/model/tableModel.dart';
import 'package:restro_booking/providers/table_provider.dart';
import 'package:restro_booking/providers/user_provider.dart';
import 'package:restro_booking/screen/bottomNavBar.dart';

class TableAdd extends StatefulWidget {
  const TableAdd({Key? key}) : super(key: key);

  @override
  _TableAddState createState() => _TableAddState();
}

class _TableAddState extends State<TableAdd> {
  // @override
  // void initState() {
  //   super.initState();
  //   final usrMdl = Provider.of<UserProvider>(context, listen: false);
  //   usrMdl.user;
  // }

  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    String min_capacity = '';
    String max_capacity = '';
    String table_no = '';
    final usrMdl = Provider.of<UserProvider>(context);
    TableProvider tbMdl = Provider.of<TableProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xFFF6F2EC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Text(
                    'Add Table',
                    textScaleFactor: 2,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Add Multiple Tables at Once:'),
                      TextButton(
                        onPressed: () {},
                        child: Icon(Icons.add),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size(20, 30),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      min_capacity = value!;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 20,
                      ),
                      hintText: "Minimum capacity of the table",
                      labelText: "Minimum Capacity",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                          color: Color(0xFFACC9DC),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                          color: Color(0xFFACC9DC),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      max_capacity = value!;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 20,
                      ),
                      hintText: "Maximum capacity of the table",
                      labelText: "Maximum Capacity",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                          color: Color(0xFFACC9DC),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                          color: Color(0xFFACC9DC),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      table_no = value!;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 20,
                      ),
                      hintText: "Number of the table",
                      labelText: "Table Number",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                          color: Color(0xFFACC9DC),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                          color: Color(0xFFACC9DC),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        formkey.currentState!.save();
                        String token = usrMdl.user.token!;
                        String userId = usrMdl.user.userId!;

                        TableModel tm = TableModel(
                          min_capacity: min_capacity,
                          max_capacity: max_capacity,
                          table_number: table_no,
                          is_available: true,
                          tableOf: userId,
                        );
                        final bool response = await tbMdl.addTable(tm, token);
                        if (response) {
                          formkey.currentState!.reset();
                          MotionToast.success(
                            description: Text('New Table Added'),
                          ).show(context);
                        } else {
                          MotionToast.error(
                            description: Text('Error in adding table'),
                          ).show(context);
                        }
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Submit',
                          textScaleFactor: 1.2,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Icon(
                          Icons.check_box_outlined,
                          size: 19,
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFF004194),
                      minimumSize: const Size(double.infinity, 40),
                      padding: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: getBusinessBottomNavBar(context),
    );
  }
}
