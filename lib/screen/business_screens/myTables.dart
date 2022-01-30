import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restro_booking/model/tableModel.dart';
import 'package:restro_booking/providers/table_provider.dart';
import 'package:restro_booking/providers/user_provider.dart';
import 'package:restro_booking/screen/bottomNavBar.dart';

class MyTableScreen extends StatefulWidget {
  const MyTableScreen({Key? key}) : super(key: key);

  @override
  State<MyTableScreen> createState() => _MyTableScreenState();
}

class _MyTableScreenState extends State<MyTableScreen> {
  List<TableModel> tblData = [];
  @override
  void initState() {
    super.initState();
    final tblMdl = Provider.of<TableProvider>(context, listen: false);
    final usrMdl = Provider.of<UserProvider>(context, listen: false);
    tblMdl.getMyTables(usrMdl.user.userId, usrMdl.user.token);
  }

  final Future<String> _calculation = Future<String>.delayed(
    const Duration(seconds: 2),
    () => 'Data Loaded',
  );

  Widget getFutureWidget() {
    return (FutureBuilder(
      future: _calculation,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = [
            const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 60,
            ),
          ];
        } else if (snapshot.hasError) {
          children = <Widget>[
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Result: ${snapshot.data}'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text('Error: ${snapshot.error}'),
            )
          ];
        } else {
          children = const <Widget>[
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('Awaiting result...'),
            )
          ];
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          ),
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    final tblMdl = Provider.of<TableProvider>(context, listen: false);
    final usrMdl = Provider.of<UserProvider>(context, listen: false);
    tblMdl.getMyTables(usrMdl.user.userId, usrMdl.user.token);
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
                  horizontal: 15,
                ),
                child: getFutureWidget(),
              ),
              Consumer<TableProvider>(
                builder: (context, tbl, child) {
                  print("Table: ${tbl.table}");
                  return Text('hello');
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: getBusinessBottomNavBar(context),
    );
  }
}
