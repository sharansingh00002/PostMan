import 'package:flutter/material.dart';
import 'package:postman/Bloc/bloc.dart';
import 'package:postman/resources/colors.dart';
import 'package:postman/resources/strings.dart';
import 'package:postman/ui/home_page.dart';
import 'package:postman/widgets/bloc_provider.dart';
import 'package:postman/widgets/bold_text_widget.dart';
import 'package:postman/widgets/custom_dialog.dart';
import 'package:postman/widgets/modal_bottom_sheet.dart';
import 'package:postman/widgets/show_error_dialog.dart';

class RequestsPage extends StatefulWidget {
  final PostPageState pageState;
  RequestsPage(
    this.pageState,
  );

  @override
  _RequestsPageState createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _headerTypeController = TextEditingController();
  final TextEditingController _headerValueController = TextEditingController();

  List<HeaderValues> headerValuesList = List();
  Map<String, String> headerValuesMap = Map();

  String requestTypeDropDownValue = requestsList[0];
  String sslType = sslTypeList[0];

  Repository repository = Repository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          msgRequestMethod,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      DropdownButton<String>(
                        value: requestTypeDropDownValue,
                        onChanged: (String value) {
                          setState(
                            () {
                              requestTypeDropDownValue = value;
                            },
                          );
                        },
                        items: requestsList.map<DropdownMenuItem<String>>(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          },
                        ).toList(),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      DropdownButton<String>(
                        value: sslType,
                        onChanged: (String value) {
                          setState(
                            () {
                              sslType = value;
                            },
                          );
                        },
                        items: sslTypeList.map<DropdownMenuItem<String>>(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          },
                        ).toList(),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                        ),
                        width: MediaQuery.of(context).size.width * 0.50,
                        child: TextFormField(
                          cursorColor: accentColor,
                          controller: _urlController,
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        color: accentColor,
                        onPressed: () {
                          _headerValueController.clear();
                          _headerTypeController.clear();
                          showModalBottomSheetApp<void>(
                            dialogHeightPercentage: 0.4,
                            context: context,
                            builder: (BuildContext _) {
                              return Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: BoldText(
                                        text: msgAddHeader,
                                        positionsToBold: [1],
                                        color: Colors.black,
                                        fontSize: 22.0,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16.0,
                                        horizontal: 10.0,
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          BoldText(
                                            text: msgType,
                                            positionsToBold: [0],
                                            fontSize: 18.0,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                              left: 16.0,
                                            ),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            child: TextFormField(
                                              maxLines: 1,
                                              cursorColor: accentColor,
                                              controller: _headerTypeController,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 16.0,
                                        horizontal: 10.0,
                                      ),
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Row(
                                          children: <Widget>[
                                            BoldText(
                                              text: msgValue,
                                              positionsToBold: [0],
                                              fontSize: 18.0,
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                left: 16.0,
                                              ),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              child: TextFormField(
                                                maxLines: 1,
                                                cursorColor: accentColor,
                                                controller:
                                                    _headerValueController,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 16.0,
                                      ),
                                      child: RaisedButton(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 32.0,
                                        ),
                                        color: accentColor,
                                        onPressed: () {
                                          if (_headerTypeController
                                                  .text.isNotEmpty &&
                                              _headerValueController
                                                  .text.isNotEmpty) {
                                            headerValuesList.removeWhere(
                                              (HeaderValues val) =>
                                                  val.type ==
                                                  _headerTypeController.text,
                                            );
                                            headerValuesList.add(
                                              HeaderValues(
                                                type:
                                                    _headerTypeController.text,
                                                value:
                                                    _headerValueController.text,
                                              ),
                                            );
                                            headerValuesMap[
                                                    _headerTypeController
                                                        .text] =
                                                _headerValueController.text;
                                            setState(() {});
                                            Navigator.pop(context);
                                          } else {
                                            showErrorDialog(
                                              child: Text(
                                                msgValuesAbsentError,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                              context: context,
                                              bgColor: accentColor,
                                              timeStay: 800,
                                            );
                                          }
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                        ),
                                        child: Text(
                                          msgAddHeader.split(' ')[0],
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: BoldText(
                          text: msgAddHeader,
                          positionsToBold: [1],
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: ListView.builder(
                      itemCount: headerValuesList.length,
                      itemBuilder: (context, index) =>
                          headerValueWidget(headerValuesList[index]),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              color: accentColor,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    repository
                        .makeRequest(
                      requestType: requestTypeDropDownValue,
                      url: sslType + _urlController.text,
                      headers: headerValuesMap,
                    )
                        .then(
                      (_) {
                        widget.pageState.controller.jumpToPage(1);
                      },
                    );
                  },
                  child: Text(
                    msgSend,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget headerValueWidget(HeaderValues headerValues) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onLongPress: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialog(
                title: msgDeleteHeader,
                description: msgDeleteHeaderDescription,
                buttons: <Widget>[
                  FlatButton(
                    child: Text(
                      actionNo.toUpperCase(),
                      style: TextStyle(color: unselectedColor),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  FlatButton(
                    child: Text(
                      actionYes.toUpperCase(),
                      style: TextStyle(color: accentColor),
                    ),
                    onPressed: () {
                      setState(
                        () {
                          headerValuesList
                              .removeWhere((val) => val == headerValues);
                          headerValuesMap.remove(headerValues.type);
                        },
                      );
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      children: <Widget>[
                        BoldText(
                          text: msgType,
                          positionsToBold: [0],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                          ),
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Text(headerValues.type)),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                  ),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        BoldText(
                          text: msgValue,
                          positionsToBold: [0],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(headerValues.value),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HeaderValues {
  String type;
  String value;
  HeaderValues({this.type, this.value});
}
