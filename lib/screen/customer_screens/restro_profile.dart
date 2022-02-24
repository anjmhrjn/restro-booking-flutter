import 'package:flutter/material.dart';
import 'package:bordered_text/bordered_text.dart';
import 'package:provider/provider.dart';
import 'package:restro_booking/model/user_model.dart';
import 'package:restro_booking/providers/restaurant_provider.dart';
import 'package:restro_booking/providers/user_provider.dart';
import 'package:restro_booking/screen/bottomNavBar.dart';
import 'package:restro_booking/utility/app_url.dart';

class RestroProfile extends StatelessWidget {
  const RestroProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final usrMdl = Provider.of<UserProvider>(context, listen: false);

    RestaurantProvider usrPrv = Provider.of<RestaurantProvider>(context);

    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final User restroData = usrPrv.findById(args['id']);

    List<String>? tag_list = restroData.tags ?? [];

    return Scaffold(
      backgroundColor: Color(0xFFF6F2EC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 240,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: restroData.user_image == null ||
                                restroData.user_image == ''
                            ? NetworkImage(
                                AppUrl.baseUrl + "/account.png",
                              )
                            : NetworkImage(
                                AppUrl.baseUrl + "/${restroData.user_image}",
                              ),
                        // image: AssetImage(
                        //   'images/aloo nazakat.jpg',
                        // ),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(1),
                          BlendMode.dstATop,
                        ),
                      ),
                      color: Color(0xFFF6F2EC),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.zero,
                        bottom: Radius.circular(35),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: BorderedText(
                        strokeWidth: 5.0,
                        child: Text(
                          '${restroData.name}',
                          style: TextStyle(
                            color: Color(0xFFF6F2EC),
                            fontWeight: FontWeight.bold,
                            fontSize: 27,
                            letterSpacing: 1.5,
                            // decorationColor: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Color(0xFFACC9DC),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${restroData.address}',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: Color(0xFF041838),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 30,
                      child: ListView.builder(
                        itemCount: tag_list.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFF004194),
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
                                tag_list[index],
                                style: TextStyle(
                                  color: Color(0xFFF6F2EC),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'About Us',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${restroData.bio}',
                      style: TextStyle(height: 1.4),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    // Align(
                    //   alignment: Alignment.topLeft,
                    //   child: Text(
                    //     'Popular Items',
                    //     style: TextStyle(
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 16,
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: 150,
                    //   child: ListView.builder(
                    //     itemCount: tag_list.length,
                    //     scrollDirection: Axis.horizontal,
                    //     itemBuilder: (BuildContext context, int index) {
                    //       return Padding(
                    //         padding: const EdgeInsets.only(top: 10, right: 10),
                    //         child: SizedBox(
                    //           width: 150,
                    //           child: ClipRRect(
                    //             borderRadius: BorderRadius.circular(8),
                    //             // height: 100,
                    //             child: Image.asset(
                    //               image_list[index],
                    //               fit: BoxFit.cover,
                    //             ),
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),

                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFACC9DC),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/restro-items',
                          arguments: {"id": restroData.id},
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'See Menu',
                            style: TextStyle(
                              color: Color(0xFF041838),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16,
                            color: Color(0xFF041838),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xFFEE6A3E),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/restro-tables',
                          arguments: {'id': restroData.id},
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Available Tables',
                            style: TextStyle(
                              color: Color(0xFFF6F2EC),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16,
                            color: Color(0xFFF6F2EC),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: usrMdl.user.user_type == 'Business'
          ? getBusinessBottomNavBar(context)
          : (usrMdl.user.user_type == 'Customer'
              ? getCustomerBottomNavBar(context)
              : getAdminBottomNavBar(context)),
    );
  }
}
