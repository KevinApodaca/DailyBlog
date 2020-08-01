import 'dart:io';

import 'package:DailyBlog/services/crud.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class CreateBlog extends StatefulWidget {
  @override
  _CreateBlogState createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  TextEditingController _textFieldController = TextEditingController();
  TextEditingController _textFieldController2 = TextEditingController();
  TextEditingController _textFieldController3 = TextEditingController();
  String authorName, title, desc;
  bool _isLoading = false;
  CrudMethods crudMethods = new CrudMethods();
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  uploadBlog() async {
    if (_image != null) {
      setState(() {
        _isLoading = true;
      });
      /* Upload to firebase storage */
      StorageReference firebaseStorageReference = FirebaseStorage.instance
          .ref()
          .child("blogImages")
          .child("${randomAlphaNumeric(9)}.jpg");

      final StorageUploadTask task = firebaseStorageReference.putFile(_image);

      var downloadUrl = await (await task.onComplete).ref.getDownloadURL();

      Map<String, String> blogMap = {
        "imgUrl": downloadUrl,
        "Author": authorName,
        "Title": title,
        "Description": desc,
      };

      crudMethods.addData(blogMap).then((result) {
        Navigator.pop(context);
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Daily",
              style: TextStyle(fontSize: 22),
            ),
            Text(
              "Blog",
              style: TextStyle(color: Colors.cyanAccent, fontSize: 22),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              uploadBlog();
            },
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Tooltip(
                    message: 'Publish Blog', child: Icon(Icons.file_upload))),
          )
        ],
      ),
      body: _isLoading
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : Container(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      getImage();
                    },
                    child: _image != null
                        ? Container(
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            width: MediaQuery.of(context).size.width,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.file(
                                _image,
                                fit: BoxFit.cover,
                              ),
                            ),
                            height: 170,
                          )
                        : Container(
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            height: 170,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6)),
                            width: MediaQuery.of(context).size.width,
                            child: Tooltip(
                              message: 'Upload an image with your blog!',
                              child: Icon(
                                Icons.add_a_photo,
                                color: Colors.black45,
                              ),
                            ),
                          ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: _textFieldController,
                          decoration: InputDecoration(
                              hintText: "Your Name", icon: Icon(Icons.person)),
                          onChanged: (value) {
                            authorName = value;
                          },
                        ),
                        TextField(
                          controller: _textFieldController2,
                          decoration: InputDecoration(
                              hintText: "Blog Title", icon: Icon(Icons.title)),
                          onChanged: (value) {
                            title = value;
                          },
                        ),
                        TextField(
                          maxLines: null,
                          controller: _textFieldController3,
                          decoration: InputDecoration(
                              hintText: "Blog Description",
                              icon: Icon(Icons.description)),
                          onChanged: (value) {
                            desc = value;
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
