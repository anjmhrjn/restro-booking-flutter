// import 'package:flutter/material.dart';
// import 'package:restro_booking/screen/bottomNavBar.dart';

// class RestaurantList extends StatefulWidget {
//   const RestaurantList({Key? key}) : super(key: key);

//   @override
//   _RestaurantListState createState() => _RestaurantListState();
// }

// class _RestaurantListState extends State<RestaurantList> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: Color(0xFFF6F2EC),
//         body: SafeArea(
//           child: SingleChildScrollView(),
//         ),
//         bottomNavigationBar: getCustomerBottomNavBar(context));
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restro_booking/model/info.dart';
import 'package:restro_booking/model/menu.dart';
import 'package:restro_booking/model/restrodetails.dart';
import 'package:restro_booking/model/user_model.dart';
import 'package:restro_booking/providers/restaurant_provider.dart';
import 'package:restro_booking/providers/user_provider.dart';
import 'package:restro_booking/screen/bottomNavBar.dart';
import 'package:restro_booking/utility/app_url.dart';

class RestaurantList extends StatefulWidget {
  const RestaurantList({Key? key}) : super(key: key);

  @override
  State<RestaurantList> createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  @override
  void initState() {
    super.initState();
    final resMdl = Provider.of<RestaurantProvider>(context, listen: false);
    final usrMdl = Provider.of<UserProvider>(context, listen: false);
    resMdl.getAllRestaurants(usrMdl.user.token);
  }

  Widget smallScreenWidget(value) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: value.restaurants.length,
      itemBuilder: (context, index) {
        return menuCard(context, value.restaurants[index]);
      },
    );
  }

  Widget bigScreenWidget(value, size) {
    final double itemHeight = (size.height - kToolbarHeight - 24) / 5;
    final double itemWidth = size.width / 2;
    return Padding(
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
        children: List.generate(value.restaurants.length, (index) {
          return menuCard(context, value.restaurants[index]);
        }),
      ),
    );
  }

  Widget menuCard(BuildContext context, User restrodetail) {
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
            onTap: () {
              Navigator.pushNamed(
                context,
                '/restro-profile',
                arguments: {"id": restrodetail.id},
              );
            },
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              // backgroundImage: AssetImage(restrodetail.image!),
              backgroundImage: restrodetail.user_image == null ||
                      restrodetail.user_image == ''
                  ? NetworkImage(
                      AppUrl.baseUrl + "/account.png",
                    )
                  : NetworkImage(
                      AppUrl.baseUrl + "/${restrodetail.user_image}",
                    ),
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
                // SizedBox(
                //   height: 25,
                //   child: ListView.builder(
                //     itemCount: restrodetail.tags!.length,
                //     scrollDirection: Axis.horizontal,
                //     itemBuilder: (BuildContext context, int index) {
                //       return Padding(
                //         padding: const EdgeInsets.only(top: 5),
                //         child: Row(
                //           children: [
                //             Text(
                //               restrodetail.tags![index],
                //               style: TextStyle(
                //                 color: Color(0xFFACC9DC),
                //               ),
                //             ),
                //             SizedBox(
                //               width: 15,
                //             )
                //           ],
                //         ),
                //       );
                //     },
                //   ),
                // ),
              ],
            ),
            // trailing: Row(
            //   mainAxisSize: MainAxisSize.min,
            //   children: [
            //     Icon(
            //       Icons.star,
            //       color: Color(0xFFEE6A3E),
            //     ),
            //     SizedBox(
            //       width: 10,
            //     ),
            //     Text(
            //       '${restrodetail.rating}',
            //       style: TextStyle(
            //         color: Color(0xFF041838),
            //       ),
            //     ),
            //   ],
            // ),
          ),
        ),
      ),
    );
  }

  final formkey = GlobalKey<FormState>();
  String name = '';

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final resMdl = Provider.of<RestaurantProvider>(context);
    final usrMdl = Provider.of<UserProvider>(context);

    return Scaffold(
      backgroundColor: Color(0xFFF6F2EC),
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
                          key: formkey,
                          child: TextFormField(
                            onFieldSubmitted: (value) {
                              if (formkey.currentState!.validate()) {
                                formkey.currentState!.save();
                                String token = usrMdl.user.token!;
                                String userId = usrMdl.user.userId!;
                                resMdl.searchRestaurant(name, token);
                              }
                            },
                            onSaved: (value) {
                              name = value!;
                            },
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
                child: Consumer<RestaurantProvider>(
                  builder: (context, value, child) {
                    return size.width > 600
                        ? bigScreenWidget(value, size)
                        : smallScreenWidget(value);
                    // return ListView.builder(
                    //   shrinkWrap: true,
                    //   itemCount: value.restaurants.length,
                    //   itemBuilder: (context, index) {
                    //     return menuCard(context, value.restaurants[index]);
                    //   },
                    // );
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
