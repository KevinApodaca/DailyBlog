import 'package:flutter/material.dart';

class CreateBlog extends StatefulWidget {
  @override
  _CreateBlogState createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  TextEditingController _textFieldController = TextEditingController();
  TextEditingController _textFieldController2 = TextEditingController();
  TextEditingController _textFieldController3 = TextEditingController();
  String authorName, title, desc;
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
          Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(Icons.file_upload))
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(6)),
              width: MediaQuery.of(context).size.width,
              child: Icon(
                Icons.add_a_photo,
                color: Colors.black45,
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
