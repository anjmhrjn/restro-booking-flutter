import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import 'package:restro_booking/model/booking_model.dart';
import 'package:restro_booking/model/table_model.dart';
import 'package:restro_booking/providers/booking_provider.dart';
import 'package:restro_booking/providers/table_provider.dart';
import 'package:restro_booking/providers/user_provider.dart';
import 'package:restro_booking/screen/bottomNavBar.dart';

class UpdateBookingStatusScreen extends StatefulWidget {
  const UpdateBookingStatusScreen({Key? key}) : super(key: key);

  @override
  _UpdateBookingStatusScreenState createState() =>
      _UpdateBookingStatusScreenState();
}

class _UpdateBookingStatusScreenState extends State<UpdateBookingStatusScreen> {
  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();

    final usrMdl = Provider.of<UserProvider>(context);
    BookingProvider bknMdl = Provider.of<BookingProvider>(context);

    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final BookingModel bkgData = bknMdl.findById(args['id']);
    String booking_status = bkgData.booking_status!;

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
                    'Update Booking Status',
                    textScaleFactor: 2,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField(
                    items: <String>[
                      'Requested',
                      'Approved',
                      'Cancelled',
                      'Disapproved',
                      'Completed',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    value: booking_status,
                    onChanged: (value) {
                      booking_status = value.toString();
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 20,
                      ),
                      hintText: "Change Status of Booking",
                      labelText: "Status",
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
                        String token = usrMdl.user.token!;

                        BookingModel bm = BookingModel(
                            id: bkgData.id, booking_status: booking_status);
                        final bool response =
                            await bknMdl.updateBookingStatus(bm, token);
                        if (response) {
                          Navigator.pushReplacementNamed(
                            context,
                            '/business-bookings',
                          );
                          MotionToast.success(
                            description: Text('Status Updated'),
                          ).show(context);
                        } else {
                          MotionToast.error(
                            description: Text('Error in updating status'),
                          ).show(context);
                        }
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Change Status',
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
                        '/business-bookings',
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
