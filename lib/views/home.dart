import 'package:DailyBlog/services/crud.dart';
import 'package:DailyBlog/views/create_blog.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CrudMethods crudMethods = new CrudMethods();
  QuerySnapshot blogSnapshot;

  Widget BlogList() {
    return Container(
      child: blogSnapshot != null
          ? Column(
              children: <Widget>[
                ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemCount: blogSnapshot.documents.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return BlogTile(
                        author: blogSnapshot.documents[index].data['Author'],
                        title: blogSnapshot.documents[index].data['Title'],
                        desc: blogSnapshot.documents[index].data['Description'],
                        imgUrl: blogSnapshot.documents[index].data['imgUrl'],
                      );
                    })
              ],
            )
          : Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
    );
  }

  @override
  void initState() {
    super.initState();
    crudMethods.getData().then((result) {
      blogSnapshot = result;
    });
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
      ),
      body: BlogList(),
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateBlog()));
              },
              child: Icon(Icons.add),
            )
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  String imgUrl, title, desc, author;

  BlogTile(
      {@required this.imgUrl,
      @required this.title,
      @required this.desc,
      @required this.author});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      height: 150,
      child: Stack(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(
                imgUrl,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              )),
          Container(
            height: 170,
            decoration: BoxDecoration(
                color: Colors.black45.withOpacity(0.3),
                borderRadius: BorderRadius.circular(6)),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  desc,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 4,
                ),
                Text('By: ' + author)
              ],
            ),
          )
        ],
      ),
    );
  }
}
