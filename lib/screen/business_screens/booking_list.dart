import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restro_booking/providers/booking_provider.dart';
import 'package:restro_booking/providers/table_provider.dart';
import 'package:restro_booking/providers/user_provider.dart';
import 'package:restro_booking/screen/bottomNavBar.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:restro_booking/utility/app_url.dart';

class BusinessBookingList extends StatefulWidget {
  const BusinessBookingList({Key? key}) : super(key: key);

  @override
  State<BusinessBookingList> createState() => _BusinessBookingListState();
}

class _BusinessBookingListState extends State<BusinessBookingList> {
  @override
  void initState() {
    super.initState();
    final bkgMdl = Provider.of<BookingProvider>(context, listen: false);
    final usrMdl = Provider.of<UserProvider>(context, listen: false);
    bkgMdl.setBusinessBooking(usrMdl.user.token);
  }

  // Future<bool> delTable(tableId) async {
  //   final tblMdl = Provider.of<TableProvider>(context, listen: false);
  //   final usrMdl = Provider.of<UserProvider>(context, listen: false);
  //   final result = await tblMdl.deleteTable(tableId, usrMdl.user.token);
  //   return result;
  // }

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
                        '/update-table',
                        // arguments: {"id": table.id},
                      );
                    },
                    color: Color(0xFF004194),
                  ),
                  // IconButton(
                  //   onPressed: () async {
                  //     // var deleted = await delTable(table.id);
                  //     // if (deleted) {
                  //     //   MotionToast.success(
                  //     //     description: Text('Table Deleted'),
                  //     //   ).show(context);
                  //     // } else {
                  //     //   MotionToast.error(
                  //     //     description: Text('Error in deleting table'),
                  //     //   ).show(context);
                  //     // }
                  //   },
                  //   icon: Icon(Icons.delete),
                  //   tooltip: 'Delete Table',
                  //   color: Colors.red,
                  // ),
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
                          'Here are the list of bookings for your restaurant.',
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
      bottomNavigationBar: getBusinessBottomNavBar(context),
    );
  }
}
