import 'package:flutter/material.dart';
import 'package:postman/resources/colors.dart';
import 'package:postman/resources/values.dart';
import 'package:postman/ui/request_page.dart';
import 'package:postman/ui/response_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: accentColor,
        fontFamily: defaultAppFont,
      ),
      home: PostPage(),
    );
  }
}

class PostPage extends StatefulWidget {
  @override
  PostPageState createState() => PostPageState();
}

class PostPageState extends State<PostPage> {
  int page = 0;
  final PageController controller = PageController();
  @override
  void initState() {
    super.initState();
  }

  jumpToPage(int index) {
    controller.jumpToPage(index);
  }

  goBack() {
    controller.animateToPage(0,
        duration: Duration(milliseconds: 400), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: 2,
        controller: controller,
        onPageChanged: (p) {
          setState(
            () {
              page = p;
            },
          );
        },
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return RequestsPage(
                jumpToPage,
              );
              break;
            case 1:
              return ResponsePage(
                goBack,
              );
              break;
          }
          return Container();
        },
      ),
    );
  }
}
