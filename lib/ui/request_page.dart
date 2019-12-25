import 'package:flutter/material.dart';
import 'package:postman/Repo/repository.dart';
import 'package:postman/database/sqlDB.dart';
import 'package:postman/model/DatabaseModels.dart';
import 'package:postman/resources/colors.dart';
import 'package:postman/resources/strings.dart';
import 'package:postman/widgets/bold_text_widget.dart';
import 'package:postman/widgets/custom_dialog.dart';
import 'package:postman/widgets/modal_bottom_sheet.dart';
import 'package:postman/widgets/show_error_dialog.dart';
import 'package:rxdart/rxdart.dart';

class RequestsPage extends StatefulWidget {
  final jumpToPage;
  RequestsPage(this.jumpToPage);

  @override
  _RequestsPageState createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _headerTypeController = TextEditingController();
  final TextEditingController _headerValueController = TextEditingController();
  final headerValueStream = BehaviorSubject<String>();

  List<HeaderValuesModel> headerValuesList = List();
  Map<String, String> headerValuesMap = Map();

  String requestTypeDropDownValue = requestsList[0];
  String sslType = sslTypeList[0];

  Repository repository = Repository();
  final SqliteDB _sqliteDB = SqliteDB();

  @override
  void initState() {
    headerValueStream.sink.add(mainHeadersList[0]);
    super.initState();
  }

  @override
  void dispose() {
    headerValueStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          titleRequestPage,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
            onPressed: () {
              if (_urlController.text.trim().isNotEmpty) {
                _sqliteDB
                    .insertIntoDB(
                  api: sslType + _urlController.text,
                  headers: headerValuesMap,
                )
                    .then((_) {
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(
                      'Api request has been saved.',
                      style: TextStyle(color: accentColor),
                      textAlign: TextAlign.center,
                    ),
                    backgroundColor: Colors.white,
                  ));
                });
              } else {
                showErrorDialog(
                  child: Text(
                    'Url field is empty',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                  context: context,
                  bgColor: accentColor,
                  timeStay: 1500,
                );
              }
            },
          ),
          IconButton(
            icon: Icon(
              Icons.collections,
              color: Colors.white,
            ),
            onPressed: () {
              _sqliteDB.getDataFromDB().then(
                (data) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Center(
                            child: Material(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.75,
                                width: MediaQuery.of(context).size.width * 0.9,
                                padding: const EdgeInsets.only(
                                  top: 32.0,
                                  bottom: 32.0,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'API List',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
//                                      width: MediaQuery.of(context).size.width *
//                                          0.60,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.6,
                                      child: ListView.builder(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 8.0),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: data?.apis?.length ?? 0,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.75,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.65,
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 16.0,
                                            ),
                                            child: Card(
                                              elevation: 8.0,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: <Widget>[
                                                        BoldText(
                                                          text:
                                                              'Api ${index + 1}',
                                                          positionsToBold: [1],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            IconButton(
                                                              icon: Icon(
                                                                Icons.delete,
                                                                color:
                                                                    accentColor,
                                                              ),
                                                              onPressed: () {
                                                                showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return CustomDialog(
                                                                      title:
                                                                          msgDeleteApi,
                                                                      description:
                                                                          msgDeleteApiDescription,
                                                                      buttons: <
                                                                          Widget>[
                                                                        FlatButton(
                                                                          child:
                                                                              Text(
                                                                            actionNo.toUpperCase(),
                                                                            style:
                                                                                TextStyle(color: unselectedColor),
                                                                          ),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                        ),
                                                                        FlatButton(
                                                                          child:
                                                                              Text(
                                                                            actionYes.toUpperCase(),
                                                                            style:
                                                                                TextStyle(color: accentColor),
                                                                          ),
                                                                          onPressed:
                                                                              () async {
                                                                            await _sqliteDB.deleteFromDB(data.id[index]);
                                                                            Navigator.pop(context);
                                                                            Navigator.pop(context);
                                                                          },
                                                                        ),
                                                                      ],
                                                                    );
                                                                  },
                                                                );
                                                              },
                                                            ),
                                                            IconButton(
                                                              icon: Icon(
                                                                Icons
                                                                    .done_outline,
                                                                color:
                                                                    accentColor,
                                                              ),
                                                              onPressed: () {
                                                                _urlController
                                                                    .text = data.apis[
                                                                        index]
                                                                    .substring((data
                                                                            .apis[index]
                                                                            .startsWith('http://'))
                                                                        ? 7
                                                                        : 8);
                                                                headerValuesMap
                                                                    .clear();
                                                                headerValuesList
                                                                    .clear();
                                                                List<HeaderValuesModel>
                                                                    list =
                                                                    data.headersList[
                                                                        index];
                                                                for (HeaderValuesModel model
                                                                    in list) {
                                                                  headerValuesList
                                                                      .add(
                                                                          model);
                                                                  headerValuesMap[
                                                                          model
                                                                              .key] =
                                                                      model
                                                                          .value;
                                                                }
                                                                setState(() {});
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8.0),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.65,
                                                      child: BoldText(
                                                        text:
                                                            'Api: ${data.apis[index]}',
                                                        positionsToBold: [0],
                                                        fontSize: 14.0,
                                                      )),
                                                  Visibility(
                                                    visible: data
                                                            .headersList[index]
                                                            .length >
                                                        0,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: BoldText(
                                                        text:
                                                            'Headers Included',
                                                        positionsToBold: [0],
                                                        fontSize: 14.0,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.35,
                                                    child: ListView.builder(
                                                      itemCount: data
                                                          .headersList[index]
                                                          .length,
                                                      itemBuilder:
                                                          (context, index2) {
                                                        List<HeaderValuesModel>
                                                            headerValue =
                                                            data.headersList[
                                                                index];
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  bottom: 4.0,
                                                                  left: 8.0),
                                                          child: Text(
                                                            headerValue[index2]
                                                                .key,
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      });
                },
              );
            },
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Padding(
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
                            keyboardType: TextInputType.url,
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
                              dialogHeightPercentage: 0.5,
                              context: context,
                              builder: (BuildContext _) {
                                return Container(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 32.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
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
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              BoldText(
                                                text: msgType,
                                                positionsToBold: [0],
                                                fontSize: 18.0,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 16.0,
                                                  ),
                                                  child: StreamBuilder<String>(
                                                      stream: headerValueStream
                                                          .stream,
                                                      builder:
                                                          (context, snapshot) {
                                                        return DropdownButton<
                                                            String>(
                                                          value: (snapshot
                                                                  .data ??
                                                              mainHeadersList[
                                                                  0]),
                                                          onChanged:
                                                              (String value) {
                                                            headerValueStream
                                                                .sink
                                                                .add(value);
                                                          },
                                                          items: mainHeadersList
                                                              .map<
                                                                  DropdownMenuItem<
                                                                      String>>(
                                                            (String value) {
                                                              return DropdownMenuItem<
                                                                  String>(
                                                                value: value,
                                                                child:
                                                                    Text(value),
                                                              );
                                                            },
                                                          ).toList(),
                                                        );
                                                      }),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 16.0,
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              BoldText(
                                                text: msgValue,
                                                positionsToBold: [0],
                                                fontSize: 18.0,
                                              ),
                                              Expanded(
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 16.0,
                                                  ),
                                                  child: TextFormField(
                                                    maxLines: 1,
                                                    cursorColor: accentColor,
                                                    controller:
                                                        _headerValueController,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 16.0,
                                          ),
                                          child: StreamBuilder<String>(
                                              stream: headerValueStream.stream,
                                              builder: (context, snapshot) {
                                                return RaisedButton(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 32.0,
                                                  ),
                                                  color: accentColor,
                                                  onPressed: () {
                                                    if (_headerValueController
                                                        .text.isNotEmpty) {
                                                      headerValuesList
                                                          .removeWhere(
                                                        (HeaderValuesModel
                                                                val) =>
                                                            val.key ==
                                                            (snapshot.data ??
                                                                mainHeadersList[
                                                                    0]),
                                                      );
                                                      headerValuesList.add(
                                                          HeaderValuesModel(
                                                        (snapshot.data ??
                                                            mainHeadersList[0]),
                                                        _headerValueController
                                                            .text,
                                                      ));
                                                      headerValuesMap[(snapshot
                                                                  .data ??
                                                              mainHeadersList[
                                                                  0])] =
                                                          _headerValueController
                                                              .text;

                                                      setState(() {
                                                        Navigator.pop(context);
                                                      });
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
                                                        timeStay: 1500,
                                                      );
                                                    }
                                                  },
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4.0),
                                                  ),
                                                  child: Text(
                                                    msgAddHeader.split(' ')[0],
                                                    style: TextStyle(
                                                      fontSize: 18.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                      ],
                                    ),
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
                    Visibility(
                      visible: headerValuesList.length > 0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Headers',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: ListView.builder(
                        itemCount: headerValuesList.length,
                        itemBuilder: (context, index) =>
                            headerValueWidget(headerValuesList[index]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  if (_urlController.text.isNotEmpty) {
                    repository
                        .makeRequest(
                      requestType: requestTypeDropDownValue,
                      url: sslType + _urlController.text,
                      headers: headerValuesMap,
                    )
                        .then(
                      (_) {
                        if (_ != null) {
                          FocusScope.of(context).requestFocus(FocusNode());
                          widget.jumpToPage(1);
                        } else {
                          showErrorDialog(
                            child: Text(
                              'Url is not correct',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                            context: context,
                            bgColor: accentColor,
                            timeStay: 1500,
                          );
                        }
                      },
                    );
                  } else {
                    showErrorDialog(
                      context: context,
                      timeStay: 2000,
                      bgColor: Colors.deepOrangeAccent,
                      child: Text(
                        'Url field is empty',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    );
                  }
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  color: accentColor,
                  child: Center(
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
            ),
          ],
        ),
      ),
    );
  }

  Widget headerValueWidget(HeaderValuesModel headerValues) {
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
                          headerValuesMap.remove(headerValues.key);
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
          child: Stack(
            children: <Widget>[
              Padding(
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
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: Text(headerValues.key)),
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
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: Icon(
                    Icons.close,
                    size: 20,
                  ),
                  onPressed: () {
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
                                    headerValuesList.removeWhere(
                                        (val) => val == headerValues);
                                    headerValuesMap.remove(headerValues.key);
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
