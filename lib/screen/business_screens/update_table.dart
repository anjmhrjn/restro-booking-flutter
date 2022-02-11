import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import 'package:restro_booking/model/table_model.dart';
import 'package:restro_booking/providers/table_provider.dart';
import 'package:restro_booking/providers/user_provider.dart';
import 'package:restro_booking/screen/bottomNavBar.dart';

class UpdateTableScreen extends StatefulWidget {
  const UpdateTableScreen({Key? key}) : super(key: key);

  @override
  _UpdateTableScreenState createState() => _UpdateTableScreenState();
}

class _UpdateTableScreenState extends State<UpdateTableScreen> {
  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();

    final usrMdl = Provider.of<UserProvider>(context);
    TableProvider tbMdl = Provider.of<TableProvider>(context);

    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final TableModel tblData = tbMdl.findById(args['id']);
    String min_capacity = tblData.min_capacity!;
    String max_capacity = tblData.max_capacity!;
    String table_no = tblData.table_number!;
    bool? is_available = tblData.is_available!;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formkey,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment,
                children: [
                  Text(
                    'Update Table',
                    textScaleFactor: 2,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text('Add Multiple Tables at Once:'),
                  //     TextButton(
                  //       onPressed: () {},
                  //       child: Icon(Icons.add),
                  //       style: TextButton.styleFrom(
                  //         padding: EdgeInsets.zero,
                  //         minimumSize: Size(20, 30),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      min_capacity = value!;
                    },
                    initialValue: min_capacity,
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
                    initialValue: max_capacity,
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
                    initialValue: table_no,
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
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text('Availability'),
                  ),
                  DropdownButtonFormField(
                    items: <String>['True', 'False']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      is_available = value.toString().toLowerCase() == 'true';
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 20,
                      ),
                      hintText: is_available.toString().toUpperCase(),
                      // labelText: "Availability",
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
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () async {
                      if (formkey.currentState!.validate()) {
                        formkey.currentState!.save();
                        print(min_capacity);
                        print(max_capacity);
                        print(table_no);
                        print(is_available);
                        String token = usrMdl.user.token!;
                        String userId = usrMdl.user.userId!;

                        // String token = usrMdl.user.token!;
                        // String userId = usrMdl.user.userId!;

                        TableModel tm = TableModel(
                          id: tblData.id,
                          min_capacity: min_capacity,
                          max_capacity: max_capacity,
                          table_number: table_no,
                          is_available: is_available,
                          tableOf: userId,
                        );
                        final bool response =
                            await tbMdl.updateTable(tm, token);
                        if (response) {
                          Navigator.pushReplacementNamed(
                            context,
                            '/my-tables',
                          );
                          MotionToast.success(
                            description: Text('Table Updated'),
                          ).show(context);
                        } else {
                          MotionToast.error(
                            description: Text('Error in updating table'),
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
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/my-tables',
                      );
                    },
                    icon: Icon(Icons.arrow_back),
                    label: Text('Go Back'),
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFEE6A3E),
                      minimumSize: const Size(double.infinity, 40),
                      padding: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50),
                        ),
                      ),
                    ),
                  )
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
