import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/services/auth.dart';
import 'package:ecommerce_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class SettingScreen extends StatefulWidget {
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  final databaseMethods = DatabaseMethods();
  final fireStore = FirebaseFirestore.instance;
  final String collectionName = 'users';

  File? _image;
  final _picker = ImagePicker();
  var imgValue;

  Future getImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    final File image = File(pickedFile!.path);

    setState(() {
      _image = image;
      uploadImage();
    });
  }

  Future uploadImage() async {
    String fileName = basename(_image!.path);
    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    Reference reference = firebaseStorage
        .ref()
        .child('image/$fileName' + DateTime.now().toString());
    UploadTask uploadTask = reference.putFile(_image!);

    uploadTask.then((res) {
      res.ref.getDownloadURL().then((value) => imgValue = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
                color: Color(0xff03d399),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
          ),
          Container(
            width: double.infinity,
            child: StreamBuilder<QuerySnapshot>(
              stream: fireStore.collection(collectionName).snapshots(),
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? userData(snapshot.data)
                    : snapshot.hasError
                        ? Text('Error')
                        : CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget userData(dynamic data) {
    return ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      child: GestureDetector(
                        onTap: getImageFromGallery,
                        child: CircleAvatar(
                          child: _image == null
                              ? null
                              : ClipOval(
                                  child: Image.file(
                                    _image!,
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.docs[index]['name'],
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          data.docs[index]['email'],
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: signOut,
                      child: Text(
                        'Sign Out',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Color(0xff03d399)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }
}
