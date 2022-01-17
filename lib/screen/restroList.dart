import 'package:flutter/material.dart';
import 'package:restro_booking/model/info.dart';
import 'package:restro_booking/model/menu.dart';
import 'package:restro_booking/model/restrodetails.dart';

class RestroLists extends StatefulWidget {
  const RestroLists({Key? key}) : super(key: key);

  @override
  State<RestroLists> createState() => _RestroListsState();
}

class _RestroListsState extends State<RestroLists> {
  Widget menuCard(BuildContext context, RestroDetails restrodetail) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        color: Color(0xFFF6F2EC),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(restrodetail.image!),
              radius: 25,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${restrodetail.name}',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF041838),
                  ),
                ),
                SizedBox(
                  height: 25,
                  child: ListView.builder(
                    itemCount: restrodetail.tags!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Row(
                          children: [
                            Text(
                              restrodetail.tags![index],
                              style: TextStyle(
                                color: Color(0xFFACC9DC),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.star,
                  color: Color(0xFFEE6A3E),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '${restrodetail.rating}',
                  style: TextStyle(
                    color: Color(0xFF041838),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const List<String> category_list = [
      "Starters",
      "Appetizers",
      "Pizza",
      "Desert"
    ];

    List<RestroDetails> menuList = [
      RestroDetails(
        name: "MacLaren's",
        tags: ["Cafe", "Bar"],
        rating: 4.3,
        image: "images/snacks.jpg",
      ),
      RestroDetails(
        name: "Central Perk",
        tags: ["Cafe", "Bar"],
        rating: 4.3,
        image: "images/snacks.jpg",
      ),
      RestroDetails(
        name: "Namaste Bar",
        tags: ["Cafe", "Bar"],
        rating: 4.3,
        image: "images/snacks.jpg",
      ),
      RestroDetails(
        name: "Puzzles Bar",
        tags: ["Cafe", "Bar"],
        rating: 4.3,
        image: "images/snacks.jpg",
      )
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF004194),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.zero,
                    bottom: Radius.circular(35),
                  ),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 15,
                          left: 20,
                        ),
                        child: Text(
                          'Restaurants',
                          style: TextStyle(
                            color: Color(0xFFF6F2EC),
                            fontSize: 27,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 20,
                        right: 20,
                        bottom: 20,
                      ),
                      child: Container(
                        height: 35,
                        decoration: BoxDecoration(
                          color: Color(0xFFEE6A3E),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Form(
                          child: TextFormField(
                            style: TextStyle(
                              color: Color(0xFFF6F2EC),
                            ),
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                color: Color(0xFFF6F2EC),
                              ),
                              fillColor: Color(0xFFEE6A3E),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Color(0xFFEE6A3E),
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: 10,
                              ),
                              hintText: 'Search',
                              prefixIcon: Icon(
                                Icons.search,
                                size: 18,
                                color: Color(0xFFF6F2EC),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 15,
                ),
                child: ListView.builder(
                  itemCount: menuList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return menuCard(context, menuList[index]);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
