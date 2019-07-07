import 'package:flutter/material.dart';
import 'package:postman/database/sqlDB.dart';
import 'package:postman/model/responseModel.dart';
import 'package:postman/resources/colors.dart';
import 'package:postman/resources/strings.dart';
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
  PostPageState pageState;
  final PageController controller = PageController();
  @override
  void initState() {
    pageState = this;
    super.initState();
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
                pageState,
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
//      body: Container(
//        child: Column(
//          children: <Widget>[
//            Container(
//              height: 50,
//              width: MediaQuery.of(context).size.width,
//              child: Row(
//                mainAxisAlignment: MainAxisAlignment.spaceAround,
//                children: <Widget>[
//                  IconButton(
//                    icon: Icon(Icons.home),
//                    iconSize: 36,
//                    color: (page == 0) ? selectedColor : unselectedColor,
//                    onPressed: () => setState(
//                      () {
//                        page = 0;
//                        controller.jumpToPage(0);
//                      },
//                    ),
//                  ),
//                  IconButton(
//                    icon: Icon(Icons.restore),
//                    iconSize: 36,
//                    color: (page == 1) ? selectedColor : unselectedColor,
//                    onPressed: () => setState(
//                      () {
//                        page = 1;
//                        controller.jumpToPage(1);
//                      },
//                    ),
//                  ),
//                ],
//              ),
//            ),
//            Container(
//              height: 4,
//              padding: const EdgeInsets.symmetric(
//                vertical: 16.0,
//              ),
//              width: MediaQuery.of(context).size.width,
//              color: unselectedColor,
//            ),
//            PageView.builder(
//              controller: controller,
//              onPageChanged: (p) {
//                setState(
//                  () {
//                    page = p;
//                  },
//                );
//              },
//              itemBuilder: (context, index) {
//                switch (index) {
//                  case 0:
//                    return RequestsPage(
//                      pageState,
//                    );
//                    break;
//                  case 1:
//                    return ResponsePage();
//                    break;
//                }
//                return Container();
//              },
//            ),
//          ],
//        ),
//      ),
    );
  }
}
