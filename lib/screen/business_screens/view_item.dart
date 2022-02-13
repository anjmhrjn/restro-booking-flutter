import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import 'package:restro_booking/model/item_model.dart';
import 'package:restro_booking/providers/item_provider.dart';
import 'package:restro_booking/providers/user_provider.dart';
import 'package:restro_booking/screen/bottomNavBar.dart';
import 'package:restro_booking/utility/app_url.dart';

class ViewItemScreen extends StatefulWidget {
  const ViewItemScreen({Key? key}) : super(key: key);

  @override
  _ViewItemScreenState createState() => _ViewItemScreenState();
}

class _ViewItemScreenState extends State<ViewItemScreen> {
  @override
  void initState() {
    super.initState();
    final itemMdl = Provider.of<ItemProvider>(context, listen: false);
    final usrMdl = Provider.of<UserProvider>(context, listen: false);
    itemMdl.getMyItems(usrMdl.user.token);
  }

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
                Text(
                  '${menuItem.description}',
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

  Widget createCard(item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.all(15),
          child: ListTile(
            leading: CircleAvatar(
              // backgroundImage: Image.network(AppUrl.baseUrl + "/${item.images}"),
              radius: 30,
              backgroundImage: item.images != null || item.images == ''
                  ? NetworkImage(AppUrl.baseUrl + "/${item.images}")
                  : NetworkImage(AppUrl.baseUrl + '/item_custom.jpg'),
              backgroundColor: Colors.transparent,
            ),
            title: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Item Name: ${item.name}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text('Price: NRs. ${item.price}'),
                SizedBox(
                  height: 5,
                ),
                Text('${item.description}'),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 35,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                      left: 20,
                      right: 20,
                    ),
                    child: ListView.builder(
                      itemCount: item.category_info.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFFEE6A3E),
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
                              item.category_info[index].name,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            subtitle: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    tooltip: 'Update Table',
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/update-item',
                        arguments: {"id": item.id},
                      );
                    },
                    color: Color(0xFF004194),
                  ),
                  IconButton(
                    onPressed: () async {
                      var deleted = await delItem(item.id);
                      if (deleted) {
                        MotionToast.success(
                          description: Text('Table Deleted'),
                        ).show(context);
                      } else {
                        MotionToast.error(
                          description: Text('Error in deleting table'),
                        ).show(context);
                      }
                    },
                    icon: Icon(Icons.delete),
                    tooltip: 'Delete Table',
                    color: Colors.red,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> delItem(itemId) async {
    final itemMdl = Provider.of<ItemProvider>(context, listen: false);
    final usrMdl = Provider.of<UserProvider>(context, listen: false);
    final result = await itemMdl.deleteItem(itemId, usrMdl.user.token);
    return result;
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
                          'My Items',
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
                          'Here is the list of items that you have created!',
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
                child: Consumer<ItemProvider>(
                  builder: (context, value, child) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: value.item.length,
                      itemBuilder: (context, index) {
                        return createCard(value.item[index]);
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
