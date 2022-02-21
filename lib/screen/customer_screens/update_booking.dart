import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import 'package:restro_booking/model/booking_model.dart';
import 'package:restro_booking/providers/booking_provider.dart';
import 'package:restro_booking/providers/restaurant_provider.dart';
import 'package:restro_booking/providers/user_provider.dart';
import 'package:restro_booking/screen/bottomNavBar.dart';

class UpdateBookingScreen extends StatefulWidget {
  const UpdateBookingScreen({Key? key}) : super(key: key);

  @override
  _UpdateBookingScreenState createState() => _UpdateBookingScreenState();
}

class _UpdateBookingScreenState extends State<UpdateBookingScreen> {
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final usrMdl = Provider.of<UserProvider>(context);
    final bknMdl = Provider.of<BookingProvider>(context);

    final args = ModalRoute.of(context)!.settings.arguments as Map;
    BookingModel bookingData = bknMdl.findById(args['id']);
    // print(bookingData.toJson());
    String requested_for = bookingData.requested_for!.split("T")[0];
    String total_seats = bookingData.total_seats!;
    String start_time = bookingData.start_time!.replaceAll("T", " ");
    String end_time = bookingData.end_time!.replaceAll("T", " ");

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 30,
            ),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Text(
                    'Update Booking',
                    textScaleFactor: 2,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      // fontSize: 23,
                      color: Color(0xFFEE6A3E),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    initialValue: total_seats,
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
                    initialValue: DateTime.parse(requested_for),
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
                    // firstDate: DateTime.now(),
                    // initialDate: DateTime.now().add(
                    //   const Duration(days: 10),
                    // ),
                    autovalidateMode: AutovalidateMode.always,
                    validator: (DateTime? e) =>
                        (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                    onDateSelected: (DateTime value) {
                      requested_for = value.toString();
                    },
                    onSaved: (DateTime? value) {
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
                          initialValue: DateTime.parse(start_time).toLocal(),
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
                          // firstDate: DateTime.now(),
                          // initialDate: DateTime.now().add(
                          //   const Duration(days: 10),
                          // ),
                          autovalidateMode: AutovalidateMode.always,
                          validator: (DateTime? e) {
                            return (e?.day ?? 0) == 1
                                ? 'Please not the first day'
                                : null;
                          },
                          onDateSelected: (DateTime value) {
                            start_time = value.toString();
                          },
                          onSaved: (DateTime? value) {
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
                            initialValue: DateTime.parse(end_time).toLocal(),
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
                            // firstDate: DateTime.now(),
                            // initialDate: DateTime.now().add(
                            //   const Duration(days: 10),
                            // ),
                            autovalidateMode: AutovalidateMode.always,
                            validator: (DateTime? e) {
                              return (e?.day ?? 0) == 1
                                  ? 'Please not the first day'
                                  : null;
                            },
                            onDateSelected: (DateTime value) {
                              end_time = value.toString();
                            },
                            onSaved: (DateTime? value) {
                              end_time = value.toString();
                            }),
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
                          id: args['id'],
                          requested_for: modified_date,
                          total_seats: total_seats,
                          start_time: modified_st,
                          end_time: modified_et,
                          table: bookingData.table,
                          user: bookingData.user,
                          created_date: bookingData.created_date,
                          booking_status: bookingData.booking_status,
                        );
                        final bool response = await bknMdl.updateBooking(
                          bm,
                          usrMdl.user.token!,
                        );
                        // final bool response = false;
                        if (response) {
                          formkey.currentState!.reset();
                          Navigator.pushNamed(
                            context,
                            '/my-reservations',
                          );
                          MotionToast.success(
                            description: Text('Reservation updated'),
                          ).show(context);
                        } else {
                          MotionToast.error(
                            description: Text('Error in making reservation'),
                          ).show(context);
                        }
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Update Booking',
                          textScaleFactor: 1.2,
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Icon(
                          Icons.mode_edit_outline_rounded,
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
        ),
      ),
      bottomNavigationBar: getCustomerBottomNavBar(context),
    );
  }
}
