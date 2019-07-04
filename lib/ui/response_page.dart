import 'package:flutter/material.dart';
import 'package:postman/model/responseModel.dart';
import 'package:postman/resources/colors.dart';
import 'package:postman/resources/values.dart';
import 'package:postman/widgets/bold_text_widget.dart';

import 'home_page.dart';

class ResponsePage extends StatelessWidget {
  ResponseModel responseModel = mainResponseModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: <Widget>[
            BoldText(
              text: 'Response Code ${responseModel.responseCode}',
              positionsToBold: [0, 2],
              fontSize: 18.0,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 16.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Body',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      width: MediaQuery.of(context).size.width * 0.65,
                      decoration: BoxDecoration(
                        border: Border.all(color: accentColor),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: SingleChildScrollView(
                        child: Text(responseModel.body),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
