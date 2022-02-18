import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restro_booking/model/item_model.dart';
import 'package:restro_booking/model/menu.dart';
import 'package:restro_booking/model/user_model.dart';
import 'package:restro_booking/providers/item_provider.dart';
import 'package:restro_booking/providers/restaurant_provider.dart';
import 'package:restro_booking/providers/user_provider.dart';
import 'package:restro_booking/screen/bottomNavBar.dart';
import 'package:restro_booking/utility/app_url.dart';

class MenuItems extends StatefulWidget {
  final String? id;
  const MenuItems({Key? key, this.id}) : super(key: key);

  @override
  State<MenuItems> createState() => _MenuItemsState();
}

class _MenuItemsState extends State<MenuItems> {
  Widget menuCard(BuildContext context, ItemModel menuItem) {
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
              // backgroundImage: AssetImage(menuItem.image![0]),
              backgroundImage: menuItem.images != null || menuItem.images == ''
                  ? NetworkImage(AppUrl.baseUrl + "/${menuItem.images}")
                  : NetworkImage(AppUrl.baseUrl + '/item_custom.jpg'),
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
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${menuItem.description}',
                  style: TextStyle(
                    color: Colors.black45,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 55,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                      // left: 20,
                      right: 20,
                      bottom: 20,
                    ),
                    child: ListView.builder(
                      itemCount: menuItem.category_info!.length,
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
                              menuItem.category_info![index].name!,
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
  void initState() {
    super.initState();
    final itemMdl = Provider.of<ItemProvider>(context, listen: false);
    final usrMdl = Provider.of<UserProvider>(context, listen: false);
    // final args = ModalRoute.of(context)!.settings.arguments as Map;
    final id = widget.id;
    itemMdl.setRestroItems(id, usrMdl.user.token);
  }

  @override
  Widget build(BuildContext context) {
    RestaurantProvider usrPrv = Provider.of<RestaurantProvider>(context);

    final User restroData = usrPrv.findById(widget.id!);
    const List<String> category_list = [
      "Starters",
      "Appetizers",
      "Pizza",
      "Desert"
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
                          '${restroData.name}',
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
                        bottom: 20,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Color(0xFFF6F2EC),
                            size: 23,
                          ),
                          Text(
                            '${restroData.address}',
                            style: TextStyle(
                              color: Color(0xFFF6F2EC),
                              fontStyle: FontStyle.italic,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
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
                child: Consumer<ItemProvider>(
                  builder: (context, value, child) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: value.item.length,
                      itemBuilder: (context, index) {
                        return menuCard(context, value.item[index]);
                      },
                    );
                  },
                ),
                // child: ListView.builder(
                //   itemCount: menuList.length,
                //   shrinkWrap: true,
                //   scrollDirection: Axis.vertical,
                //   itemBuilder: (BuildContext context, int index) {
                //     return menuCard(context, menuList[index]);
                //   },
                // ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: getCustomerBottomNavBar(context),
    );
  }
}
