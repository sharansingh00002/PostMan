import 'package:flutter/material.dart';
import 'package:postman/model/responseModel.dart';
import 'package:postman/resources/colors.dart';
import 'package:postman/resources/global.dart';
import 'package:postman/widgets/bold_text_widget.dart';

class ResponsePage extends StatelessWidget {
//  final ResponseModel responseModel = mainResponseModel;
  final goBack;
  ResponsePage(this.goBack);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'RESPONSE',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              goBack();
            }),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<ResponseModel>(
            stream: globalResponseStream,
            builder: (context, snapshot) {
              return (snapshot.data != null)
                  ? Container(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          children: <Widget>[
                            BoldText(
                              text:
                                  'Response Code ${snapshot.data.responseCode}',
                              positionsToBold: [0, 2],
                              fontSize: 18.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 16.0,
                              ),
                              child: Column(
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
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(4.0),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.7,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: accentColor),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Scrollbar(
                                        child: SingleChildScrollView(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              snapshot.data.body,
                                              style: TextStyle(
                                                fontSize: 12.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container();
            }),
      ),
    );
  }
}
