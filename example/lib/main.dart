import 'package:file_view_pager/file_view_pager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FileViewPager Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyFileViewPager(
        title: 'FileViewPager Example',
      ),
    );
  }
}

class MyFileViewPager extends StatefulWidget {
  final String title;

  const MyFileViewPager({Key? key, required this.title}) : super(key: key);

  @override
  State<MyFileViewPager> createState() => _MyFileViewPagerState();
}

class _MyFileViewPagerState extends State<MyFileViewPager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: CupertinoButton(
        onPressed: () {
          openFileViewPager(
              context,
              FVPParam(urls: [
                "https://res.cloudinary.com/startup-grind/image/upload/c_fill,dpr_2.0,f_auto,g_center,h_1080,q_100,w_1080/v1/gcs/platform-data-goog/events/flutter_I6JGxZE.jpg",
                "https://i0.wp.com/www.techbooky.com/wp-content/uploads/2020/12/flutter-logo-sharing.png?resize=750%2C369&ssl=1",
                "https://www.clickdimensions.com/links/TestPDFfile.pdf",
                "https://calibre-ebook.com/downloads/demos/demo.docx",
                "https://www.cmu.edu/blackboard/files/evaluate/tests-example.xls"
              ], initPosition: 0),
              text: const FVPText(
                  successMessage: "Hura", errorMessage: "Failed"));
        },
        child: const Text('Open File View Pager'),
      )),
    );
  }
}
