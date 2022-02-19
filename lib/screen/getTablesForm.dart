import 'package:flutter/material.dart';
import 'package:date_field/date_field.dart';

Widget getTablesForm(BuildContext context) {
  var size = MediaQuery.of(context).size;
  return Form(
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
          validator: (DateTime? e) =>
              (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
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
                  labelText: 'Start Time',
                  hintText: 'Start Time',
                ),
                firstDate: DateTime.now(),
                initialDate: DateTime.now().add(
                  const Duration(days: 10),
                ),
                autovalidateMode: AutovalidateMode.always,
                validator: (DateTime? e) {
                  return (e?.day ?? 0) == 1 ? 'Please not the first day' : null;
                },
                onDateSelected: (DateTime value) {
                  print(value);
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
                autovalidateMode: AutovalidateMode.always,
                validator: (DateTime? e) {
                  return (e?.day ?? 0) == 1 ? 'Please not the first day' : null;
                },
                onDateSelected: (DateTime value) {
                  print(value);
                },
              ),
            ),
          ],
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
  );
}
