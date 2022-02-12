import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restro_booking/model/category_model.dart';
import 'package:restro_booking/screen/bottomNavBar.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:getwidget/getwidget.dart';

class AddItemScreen extends StatefulWidget {
  const AddItemScreen({Key? key}) : super(key: key);

  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final formkey = GlobalKey<FormState>();
  File? _image;

  String name = '';
  List<String> categories = [];
  String price = '';
  String description = '';

  //method to open image from gallery
  _imageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
    });
  }

  //method to open image from camera
  _imageFromCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _image = File(image!.path);
    });
  }

  static List<CategoryModel> _category = [
    CategoryModel(id: '1', name: 'Snacks'),
    CategoryModel(id: '2', name: 'Foods'),
    CategoryModel(id: '3', name: 'Drinks'),
    CategoryModel(id: '4', name: 'Dessert'),
    CategoryModel(id: '5', name: 'Breakfast'),
  ];

  @override
  void initState() {
    super.initState();
    _image = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F2EC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formkey,
              child: Column(
                children: [
                  Text(
                    'Add Item',
                    textScaleFactor: 2,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: _image == null
                            ? const AssetImage('images/item_custom.jpg')
                                as ImageProvider
                            : FileImage(_image!),
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (builder) => bottomSheet());
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: const Icon(
                              Icons.upload,
                              color: Colors.red,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Item Image',
                    textScaleFactor: 1.5,
                  ),
                  GFMultiSelect(
                    items: ['Messi', 'Griezmann', 'Coutinho'],
                    onSelect: (value) {
                      print('selected $value ');
                    },
                    dropdownBgColor: Color(0xFFF6F2EC),
                    dropdownTitleTileText: 'Select Category',
                    dropdownTitleTileColor: Color(0xFFF6F2EC),
                    dropdownTitleTileMargin: EdgeInsets.only(
                      top: 22,
                    ),
                    dropdownTitleTilePadding: EdgeInsets.all(10),
                    dropdownUnderlineBorder:
                        const BorderSide(color: Colors.transparent, width: 2),
                    dropdownTitleTileBorder:
                        Border.all(color: Color(0xFFACC9DC), width: 1),
                    dropdownTitleTileBorderRadius: BorderRadius.circular(25),
                    expandedIcon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.black54,
                    ),
                    collapsedIcon: const Icon(
                      Icons.keyboard_arrow_up,
                      color: Colors.black54,
                    ),
                    submitButton: Text('OK'),
                    dropdownTitleTileTextStyle: const TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                    padding: const EdgeInsets.all(6),
                    margin: const EdgeInsets.all(6),
                    type: GFCheckboxType.basic,
                    activeBgColor: Color(0xFFACC9DC),
                    inactiveBorderColor: Colors.grey,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      // min_capacity = value!;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 20,
                      ),
                      hintText: "Name of the item",
                      labelText: "Item Name",
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
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      // max_capacity = value!;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 20,
                      ),
                      hintText: "Price of the item",
                      labelText: "Item Price",
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
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    onSaved: (value) {
                      // table_no = value!;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 20,
                      ),
                      hintText: "Description of item",
                      labelText: "Item Description",
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
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // if (formkey.currentState!.validate()) {
                      //   formkey.currentState!.save();
                      //   String token = usrMdl.user.token!;
                      //   String userId = usrMdl.user.userId!;

                      //   TableModel tm = TableModel(
                      //     min_capacity: min_capacity,
                      //     max_capacity: max_capacity,
                      //     table_number: table_no,
                      //     is_available: true,
                      //     tableOf: userId,
                      //   );
                      //   final bool response = await tbMdl.addTable(tm, token);
                      //   if (response) {
                      //     formkey.currentState!.reset();
                      //     MotionToast.success(
                      //       description: Text('New Table Added'),
                      //     ).show(context);
                      //   } else {
                      //     MotionToast.error(
                      //       description: Text('Error in adding table'),
                      //     ).show(context);
                      //   }
                      // }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Submit',
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
                      Navigator.pushNamed(context, '/add-category');
                    },
                    icon: Icon(Icons.add),
                    label: Text('Add Category'),
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

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          const Text(
            'Choose profile photo',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  _imageFromCamera();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.camera),
                label: const Text('Camera'),
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  _imageFromGallery();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.image),
                label: const Text('Gallery'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
