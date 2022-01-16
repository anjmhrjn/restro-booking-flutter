import 'package:flutter/material.dart';
import 'package:restro_booking/model/menu.dart';

class MenuItems extends StatelessWidget {
  const MenuItems({Key? key}) : super(key: key);

  Widget menuCard(BuildContext context, Menu menuItem) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
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
              backgroundImage: AssetImage(menuItem.image![0]),
              radius: 25,
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '${menuItem.name}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF041838),
                    ),
                  ),
                ),
                Text(
                  '${menuItem.desc}',
                  style: TextStyle(
                    color: Color(0xFFACC9DC),
                  ),
                ),
              ],
            ),
            trailing: Text(
              'NRs. ${menuItem.price}',
              style: TextStyle(
                color: Color(0xFF041838),
              ),
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

    List<Menu> menuList = [
      Menu(
        name: 'Veg roll',
        desc: '5pcs, Paneer, Onions',
        image: ['images/snacks.jpg'],
        price: 150,
      ),
      Menu(
        name: 'Aaloo Nazakat',
        desc: '5pcs, Paneer, Onions',
        image: ['images/snacks.jpg'],
        price: 150,
      ),
      Menu(
        name: 'Just Tadka',
        desc: '5pcs, Paneer, Onions',
        image: ['images/snacks.jpg'],
        price: 150,
      ),
      Menu(
        name: 'Mithoo',
        desc: '5pcs, Paneer, Onions',
        image: ['images/snacks.jpg'],
        price: 150,
      ),
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
                          'Lorem Ipsum Cafe',
                          style: TextStyle(
                            color: Color(0xFFF6F2EC),
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 5,
                        left: 18,
                      ),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.location_on,
                            color: Color(0xFFF6F2EC),
                            size: 23,
                          ),
                          Text(
                            'Jhamsikhel, Lalitpur',
                            style: TextStyle(
                              color: Color(0xFFF6F2EC),
                              fontStyle: FontStyle.italic,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: Color(0xFFACC9DC),
                    ),
                    SizedBox(
                      height: 55,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 5,
                          left: 20,
                          right: 20,
                          bottom: 20,
                        ),
                        child: ListView.builder(
                          itemCount: category_list.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFFACC9DC),
                                  // minimumSize: const Size(double.infinity, 40),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),

                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                ),
                                onPressed: () {},
                                child: Text(
                                  category_list[index],
                                  style: TextStyle(
                                    color: Color(0xFF041838),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Menu',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                  color: Color(0xFFEE6A3E),
                ),
              ),
              SizedBox(
                height: 10,
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
