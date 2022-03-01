import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import 'package:restro_booking/model/booking_model.dart';
import 'package:restro_booking/model/table_model.dart';
import 'package:restro_booking/model/user_model.dart';
import 'package:restro_booking/providers/booking_provider.dart';
import 'package:restro_booking/providers/restaurant_provider.dart';
import 'package:restro_booking/providers/user_provider.dart';
import 'package:restro_booking/screen/bottomNavBar.dart';
import 'package:restro_booking/screen/getTablesForm.dart';
import 'package:restro_booking/model/info.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ReserveTable extends StatefulWidget {
  const ReserveTable({Key? key}) : super(key: key);

  @override
  _ReserveTableState createState() => _ReserveTableState();
}

class _ReserveTableState extends State<ReserveTable> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  onSelectNotification(String? payload) {}

  showNotification() async {
    var android = AndroidNotificationDetails('id', 'channel ',
        channelDescription: "oleoleole",
        priority: Priority.high,
        importance: Importance.max);
    var platform = new NotificationDetails(android: android);
    await flutterLocalNotificationsPlugin.show(
        0, 'Booking Confirmation', 'Reservation has been made', platform,
        payload: 'Welcome to the Local Notification demo');
  }

  @override
  void initState() {
    super.initState();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('account');
    var initSetttings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);
  }

  Widget getRestroInfo(BuildContext context, restroData, tableData) {
    var size = MediaQuery.of(context).size;
    var divisible_num = size.width > 600 ? 10 : 10;
    final double itemHeight =
        (size.height - kToolbarHeight - 24) / divisible_num;
    final double itemWidth = size.width / 2;
    final phone = restroData.phone == null ||
            restroData.phone == '' ||
            restroData.phone == 'null'
        ? '-----'
        : restroData.phone;

    final List<RestroInfo> restroInfo = <RestroInfo>[
      RestroInfo(
        title: 'Address',
        icon: Icons.location_on,
        detail: '${restroData.address}',
      ),
      RestroInfo(
        title: 'Phone',
        icon: Icons.phone,
        detail: phone,
      ),
      RestroInfo(
        title: 'Table Number',
        icon: Icons.table_chart,
        detail: '${tableData.table_number}',
      ),
      RestroInfo(
        title: 'Capacity',
        icon: Icons.group,
        detail: '${tableData.min_capacity}-${tableData.max_capacity}',
      ),
    ];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.count(
          // controller:
          //     new ScrollController(keepScrollOffset: false),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          childAspectRatio: (itemWidth / itemHeight),
          crossAxisCount: 2,
          crossAxisSpacing: 15.0,
          mainAxisSpacing: 0.1,
          children: List.generate(restroInfo.length, (index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      restroInfo[index].icon,
                      color: Color(0xFFACC9DC),
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      restroInfo[index].title!,
                      style: TextStyle(
                        color: Color(0xFFACC9DC),
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  restroInfo[index].detail!,
                  style: TextStyle(
                    color: Color(0xFF041838),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  final formkey = GlobalKey<FormState>();
  String total_seats = '';
  String requested_for = '';
  String start_time = '';
  String end_time = '';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final usrMdl = Provider.of<UserProvider>(context);
    final bknMdl = Provider.of<BookingProvider>(context);
    RestaurantProvider resMdl = Provider.of<RestaurantProvider>(context);

    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final TableModel tblData = resMdl.findTableById(args['table_id']);
    final User restroData = resMdl.findById(args["restro_id"]);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                // height: 150,
                decoration: BoxDecoration(
                  color: Color(0xFFF6F2EC),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.zero,
                    bottom: Radius.circular(35),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 30,
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          '${restroData.name}',
                          style: TextStyle(
                            fontSize: 27,
                            color: Color(0xFF041838),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      getRestroInfo(context, restroData, tblData),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        onSaved: (value) {
                          total_seats = value!;
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 17,
                          ),
                          hintText: 'Enter number of seats',
                          labelText: 'No. of seats',
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Color(0xFFACC9DC),
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            borderSide: BorderSide(
                              color: Color(0xFFACC9DC),
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      DateTimeFormField(
                        mode: DateTimeFieldPickerMode.date,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 17,
                          ),
                          errorStyle: TextStyle(color: Colors.redAccent),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            borderSide: BorderSide(
                              color: Color(0xFFACC9DC),
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            borderSide: BorderSide(
                              color: Color(0xFFACC9DC),
                              width: 2.0,
                            ),
                          ),
                          suffixIcon: Icon(Icons.event_note),
                          labelText: 'Date',
                          hintText: 'Select date for reservation',
                        ),
                        firstDate: DateTime.now(),
                        initialDate: DateTime.now().add(
                          const Duration(days: 10),
                        ),
                        onDateSelected: (DateTime value) {
                          requested_for = value.toString();
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Container(
                            width: (size.width - 80) / 2,
                            child: DateTimeFormField(
                              mode: DateTimeFieldPickerMode.time,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 17,
                                ),
                                errorStyle: TextStyle(color: Colors.redAccent),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide(
                                    color: Color(0xFFACC9DC),
                                    width: 2.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide(
                                    color: Color(0xFFACC9DC),
                                    width: 2.0,
                                  ),
                                ),
                                labelText: 'Start Time',
                                hintText: 'Start Time',
                              ),
                              firstDate: DateTime.now(),
                              initialDate: DateTime.now().add(
                                const Duration(days: 10),
                              ),
                              onDateSelected: (DateTime value) {
                                start_time = value.toString();
                              },
                            ),
                          ),
                          SizedBox(
                            width: 13,
                          ),
                          Text(
                            'to',
                            // textScaleFactor: 2,
                          ),
                          SizedBox(
                            width: 13,
                          ),
                          Container(
                            width: (size.width - 80) / 2,
                            child: DateTimeFormField(
                              mode: DateTimeFieldPickerMode.time,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 17,
                                ),
                                errorStyle: TextStyle(color: Colors.redAccent),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide(
                                    color: Color(0xFFACC9DC),
                                    width: 2.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  ),
                                  borderSide: BorderSide(
                                    color: Color(0xFFACC9DC),
                                    width: 2.0,
                                  ),
                                ),
                                labelText: 'End Time',
                                hintText: 'End Time',
                              ),
                              firstDate: DateTime.now(),
                              initialDate: DateTime.now().add(
                                const Duration(days: 10),
                              ),
                              onDateSelected: (DateTime value) {
                                end_time = value.toString();
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            formkey.currentState!.save();
                            String modified_date = requested_for.split(" ")[0];
                            String modified_st =
                                "${modified_date}T${start_time.split(" ")[1]}";
                            String modified_et =
                                "${modified_date}T${end_time.split(" ")[1]}";

                            BookingModel bm = BookingModel(
                              created_date: DateTime.now().toString(),
                              requested_for: modified_date,
                              total_seats: total_seats,
                              start_time: modified_st,
                              end_time: modified_et,
                              table: args['table_id'],
                              user: usrMdl.user.userId,
                            );
                            final bool response = await bknMdl.makeReservation(
                                bm, usrMdl.user.token!, Client());
                            // final bool response = false;
                            if (response) {
                              showNotification();
                              formkey.currentState!.reset();
                              MotionToast.success(
                                description: Text('Reservation success'),
                              ).show(context);
                            } else {
                              MotionToast.error(
                                description:
                                    Text('Error in making reservation'),
                              ).show(context);
                            }
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Book Now',
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
                          // primary: Color(0xFFEE6A3E),
                          primary: Color(0xFF004194),
                          minimumSize: const Size(double.infinity, 40),
                          padding: EdgeInsets.all(8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: getCustomerBottomNavBar(context),
    );
  }
}
