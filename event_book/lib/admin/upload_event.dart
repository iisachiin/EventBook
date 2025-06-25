import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_book/services/database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class UploadEvent extends StatefulWidget {
  const UploadEvent({super.key});

  @override
  State<UploadEvent> createState() => _UploadEventState();
}

class _UploadEventState extends State<UploadEvent> {
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController pricecontroller = new TextEditingController();
  TextEditingController detailscontroller = new TextEditingController();

  final List<String> eventCatagory = ["Music", "Clothing", "Food", "Festival"];
  String? value;
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.arrow_back_ios_new_outlined),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width / 4.2),
                  Text(
                    "Upload Event",
                    // textAlign:TextAlign.center,
                    style: TextStyle(
                      color: Color(0xff6351ec),
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),
              selectedImage != null
                  ? Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        selectedImage!,
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                  : Center(
                    child: GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: Container(
                        height: 150,
                        width: 150,

                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black45, width: 2.0),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(Icons.camera_alt_outlined),
                      ),
                    ),
                  ),
              SizedBox(height: 20.0),
              Text(
                "Event Name",
                // textAlign:TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xffececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: namecontroller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Event Name",
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                "Ticket Price",
                // textAlign:TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xffececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: pricecontroller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Enter Price",
                  ),
                ),
              ),

              SizedBox(height: 20.0),
              Text(
                "Ticket Price",
                // textAlign:TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),

              // SizedBox(height: 20.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xffececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    items:
                        eventCatagory
                            .map(
                              (item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              ),
                            )
                            .toList(),
                    onChanged:
                        ((value) => setState(() {
                          this.value = value;
                        })),
                    dropdownColor: Colors.white,
                    hint: Text("Select Category"),
                    icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                    iconSize: 34.0,
                    value: value,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.calendar_month, color: Colors.blue, size: 30),
                  SizedBox(width: 10),
                  Text(
                    DateFormat('yyyy-mm-dd').format(selectedDate!),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.alarm_add_outlined, color: Colors.blue, size: 30),
                  Text(formatTimeOfDay(selectedTime!), ),
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                "Event Details",
                // textAlign:TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xffececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: detailscontroller,
                  maxLines: 6,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "What will be on that event...?",
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                onTap: () async {
                  // This code is used to upload the event images on the FireBase

                  // String addId = randomAlphaNumeric(10);
                  // Reference firebaseStorageRef = FirebaseStorage.instance
                  //     .ref()
                  //     .child("blogImages")
                  //     .child(addId);
                  // final UploadTask task = firebaseStorageRef.putFile(
                  //   selectedImage!,
                  // );
                  // var downloadUrl = await (await task).ref.getDownloadURL();
                  String id = randomAlphaNumeric(10);
                  Map<String, dynamic> uploadevent = {
                    // "Image": downloadUrl, // use it when we upload to fire base
                    "Image": "",
                    "Name": namecontroller.text,
                    "Price": pricecontroller.text,
                    "Category": value,
                    "Detail": detailscontroller.text,
                  };
                  await DatabaseMethods().addEvent(uploadevent, id).then((
                    value,
                  ) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(
                          "Uploaded successfully",
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                    setState(() {
                      namecontroller.text = "";
                      pricecontroller.text = "";
                      detailscontroller.text = "";
                      selectedImage = null;
                    });
                  });
                },
                child: Center(
                  child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(0xff6351ec),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        "Upload",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
