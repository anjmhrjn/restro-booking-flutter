import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/dropdown/gf_multiselect.dart';
import 'package:getwidget/getwidget.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import 'package:restro_booking/providers/booking_provider.dart';
import 'package:restro_booking/providers/user_provider.dart';
import 'package:restro_booking/screen/bottomNavBar.dart';
import 'package:restro_booking/utility/app_url.dart';

class MyBookingsScreen extends StatefulWidget {
  const MyBookingsScreen({Key? key}) : super(key: key);

  @override
  _MyBookingsScreenState createState() => _MyBookingsScreenState();
}

class _MyBookingsScreenState extends State<MyBookingsScreen> {
  final formkey = GlobalKey<FormState>();
  String date = '';
  List<String> selected = [];

  @override
  void initState() {
    super.initState();
    final bkgMdl = Provider.of<BookingProvider>(context, listen: false);
    final usrMdl = Provider.of<UserProvider>(context, listen: false);
    bkgMdl.setCustomerBooking(usrMdl.user.token);
  }

  Future<bool> delReservation(bookingId) async {
    final bknMdl = Provider.of<BookingProvider>(context, listen: false);
    final usrMdl = Provider.of<UserProvider>(context, listen: false);
    final result = await bknMdl.deleteBooking(bookingId, usrMdl.user.token);
    return result;
  }

  Widget createCard(booking) {
    DateTime requested_date = DateTime.parse(booking.requested_for);
    DateTime start_time = DateTime.parse(booking.start_time).toLocal();
    DateTime end_time = DateTime.parse(booking.end_time).toLocal();

    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 2,
          ),
          child: ListTile(
            leading: CircleAvatar(
              // backgroundImage: Image.network(AppUrl.baseUrl + "/${item.images}"),
              radius: 30,
              backgroundImage: booking.user_detail.user_image != null ||
                      booking.user_detail.user_image.images == ''
                  ? NetworkImage(
                      AppUrl.baseUrl + "/${booking.user_detail.user_image}")
                  : NetworkImage(AppUrl.baseUrl + '/account.png'),
              backgroundColor: Colors.transparent,
            ), // image of user
            title: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Username: ${booking.user_detail.username}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text('Total Seats: ${booking.total_seats}'),
                SizedBox(
                  height: 5,
                ),
                Text('Table Number: ${booking.table_detail.table_number}'),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Table Capacity',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Minimum: ${booking.table_detail.min_capacity}',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Maximum: ${booking.table_detail.max_capacity}',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Requested Date: ${requested_date.year}-${requested_date.month}-${requested_date.day}',
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                    'Time: ${start_time.hour}:${start_time.minute} to ${end_time.hour}:${end_time.minute}'),
                SizedBox(
                  height: 5,
                ),
                Text('Status: ${booking.booking_status}'),
              ],
            ),
            subtitle: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    tooltip: 'Change Status',
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/update-booking',
                        arguments: {"id": booking.id},
                      );
                    },
                    color: Color(0xFF004194),
                  ),
                  IconButton(
                    onPressed: () async {
                      var deleted = await delReservation(booking.id);
                      if (deleted) {
                        MotionToast.success(
                          description: Text('Reservation Deleted'),
                        ).show(context);
                      } else {
                        MotionToast.error(
                          description: Text('Error in deleting Reservation'),
                        ).show(context);
                      }
                    },
                    icon: Icon(Icons.delete),
                    tooltip: 'Delete Reservation',
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
    final usrMdl = Provider.of<UserProvider>(context);
    BookingProvider bknMdl = Provider.of<BookingProvider>(context);
    final _items = [
      'Requested',
      'Approved',
      'Cancelled',
      'Disapproved',
      'Completed'
    ];
    return Scaffold(
        backgroundColor: Color(0xFFF6F2EC),
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
                            'Bookings',
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
                            'Here are the list of bookings you have made.',
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Apply Filters',
                              textScaleFactor: 2,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.filter_list_alt,
                              size: 35,
                            )
                          ],
                        ),
                        GFMultiSelect(
                          items: _items,
                          onSelect: (value) {
                            selected = [];
                            for (var i = 0; i < value.length; i++) {
                              selected.add(_items[value[i]]);
                            }
                          },
                          dropdownBgColor: Color(0xFFF6F2EC),
                          dropdownTitleTileText: 'Select Status',
                          dropdownTitleTileColor: Color(0xFFF6F2EC),
                          dropdownTitleTileMargin: EdgeInsets.only(
                            top: 22,
                          ),
                          dropdownTitleTilePadding: EdgeInsets.all(10),
                          dropdownUnderlineBorder: const BorderSide(
                              color: Colors.transparent, width: 2),
                          dropdownTitleTileBorder:
                              Border.all(color: Color(0xFFACC9DC), width: 1),
                          dropdownTitleTileBorderRadius:
                              BorderRadius.circular(25),
                          expandedIcon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.black54,
                          ),
                          collapsedIcon: const Icon(
                            Icons.keyboard_arrow_up,
                            color: Colors.black54,
                          ),
                          submitButton: Text('OK'),
                          dropdownTitleTileTextStyle: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                          padding: const EdgeInsets.all(6),
                          margin: const EdgeInsets.all(6),
                          type: GFCheckboxType.basic,
                          activeBgColor: Color(0xFFACC9DC),
                          inactiveBorderColor: Colors.grey,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        DateTimeFormField(
                          mode: DateTimeFieldPickerMode.date,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 20,
                            ),
                            suffixIcon: Icon(Icons.event_note),
                            labelText: 'Date',
                            hintText: 'Select date',
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
                          firstDate: DateTime.now(),
                          initialDate: DateTime.now().add(
                            const Duration(days: 10),
                          ),
                          autovalidateMode: AutovalidateMode.always,
                          validator: (DateTime? e) => (e?.day ?? 0) == 1
                              ? 'Please not the first day'
                              : null,
                          onDateSelected: (DateTime value) {
                            date = value.toString();
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton.icon(
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              formkey.currentState!.save();
                              String token = usrMdl.user.token!;
                              Map<String, dynamic> filterData = {
                                'status_types': selected.toString(),
                                'date': date.split(" ")[0]
                              };
                              bknMdl.filterBooking(filterData, token);
                              // final bool response =
                              //     await catMdl.addCategory(cm, token);
                              // if (response) {
                              //   formkey.currentState!.reset();
                              //   Navigator.pushNamed(context, '/add-item');
                              //   MotionToast.success(
                              //     description: Text('New Category Added'),
                              //   ).show(context);
                              // } else {
                              //   MotionToast.error(
                              //     description: Text('Error in adding category'),
                              //   ).show(context);
                              // }
                            }
                          },
                          icon: Icon(Icons.check_box_outlined),
                          label: Text('Submit'),
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
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 20,
                          // thickness: 1.5,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  child: Consumer<BookingProvider>(
                    builder: (context, value, child) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: value.booking.length,
                        itemBuilder: (context, index) {
                          return createCard(value.booking[index]);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: getCustomerBottomNavBar(context));
  }
}
