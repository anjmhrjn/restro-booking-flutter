import 'package:flutter/material.dart';
import 'package:restro_booking/screen/info.dart';
import 'package:date_field/date_field.dart';

class BookTable extends StatefulWidget {
  const BookTable({Key? key}) : super(key: key);

  @override
  _BookTableState createState() => _BookTableState();
}

class _BookTableState extends State<BookTable> {
  final List<RestroInfo> restroInfo = const <RestroInfo>[
    RestroInfo(
      title: 'Address',
      icon: Icons.location_on,
      detail: 'Jhamsikhel, Lalitpur',
    ),
    RestroInfo(
      title: 'Phone',
      icon: Icons.phone,
      detail: '9898989898',
    ),
    RestroInfo(
      title: 'Time',
      icon: Icons.watch_later,
      detail: '7:00 AM - 7:00 PM',
    ),
    RestroInfo(
      title: 'Guests',
      icon: Icons.group,
      detail: '1-8',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 10;
    final double itemWidth = size.width / 2;
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
                          'Lorem Ipsum Cafe',
                          style: TextStyle(
                            fontSize: 27,
                            color: Color(0xFF041838),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
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
                            mainAxisSpacing: 10.0,
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
                      ),
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
                  child: Column(
                    children: [
                      TextFormField(
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
                        autovalidateMode: AutovalidateMode.always,
                        validator: (DateTime? e) => (e?.day ?? 0) == 1
                            ? 'Please not the first day'
                            : null,
                        onDateSelected: (DateTime value) {
                          print(value);
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
                                labelText: 'Time',
                                hintText: 'Start Time',
                              ),
                              firstDate: DateTime.now(),
                              initialDate: DateTime.now().add(
                                const Duration(days: 10),
                              ),
                              autovalidateMode: AutovalidateMode.always,
                              validator: (DateTime? e) {
                                return (e?.day ?? 0) == 1
                                    ? 'Please not the first day'
                                    : null;
                              },
                              onDateSelected: (DateTime value) {
                                print(value);
                              },
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            '-',
                            textScaleFactor: 2,
                          ),
                          SizedBox(
                            width: 15,
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
                                labelText: 'Time',
                                hintText: 'End Time',
                              ),
                              firstDate: DateTime.now(),
                              initialDate: DateTime.now().add(
                                const Duration(days: 10),
                              ),
                              autovalidateMode: AutovalidateMode.always,
                              validator: (DateTime? e) {
                                return (e?.day ?? 0) == 1
                                    ? 'Please not the first day'
                                    : null;
                              },
                              onDateSelected: (DateTime value) {
                                print(value);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                child: Form(
                  child: Column(
                    children: [
                      Divider(
                        thickness: 2,
                        color: Color(0xFFACC9DC),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Available Tables',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 27,
                          color: Color(0xFFEE6A3E),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      DropdownButtonFormField(
                        items: <String>['Table1', 'Table2']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {},
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 17,
                          ),
                          hintText: 'Table Name',
                          labelText: 'Tables',
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
                        height: 15,
                      ),
                      ElevatedButton(
                        onPressed: () {},
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
    );
  }
}
