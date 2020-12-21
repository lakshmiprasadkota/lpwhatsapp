import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCountry = "+91";
  TextEditingController number = TextEditingController();
  TextEditingController massege = TextEditingController();
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.blueGrey),
      ),
      drawer: Drawer(
        elevation: 100,
        semanticLabel: "haii",
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Text("Discription")
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 100),
          child: Column(
            children: [
              Container(
                child: Row(
                  children: [
                    Expanded(
                      flex: 30,
                      child: Container(
                        height: 50,
                        width: 50,
                        child: CountryCodePicker(
                          onChanged: (item) {
                            setState(() {
                              selectedCountry = item.dialCode;
                            });
                            print("country Code ${item.dialCode}");
                          },
                          padding: EdgeInsets.all(10),
                          hideSearch: true,
                          searchDecoration: InputDecoration(
                            isDense: true,
                          ),
                          dialogSize: Size.square(300),
                          dialogBackgroundColor: Colors.blue,
                          showDropDownButton: true,
                          boxDecoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0, 4),
                                  blurRadius: 10,
                                  spreadRadius: 2)
                            ],
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                bottomRight: Radius.circular(100)),
                          ),
                          initialSelection: "IN",
                          favorite: ["+91", "IN"],
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 70,
                        child: Container(
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                                color: Colors.blueGrey[50],
                                offset: Offset(0, 4),
                                blurRadius: 10)
                          ]),
                          child: TextField(
                            maxLines: 1,
                            maxLength: 10,
                            controller: number,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                                isDense: true,
                                fillColor: Colors.white,
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(150)),
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(150)),
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                    )),
                                labelText: "Phn No",
                                labelStyle: TextStyle(
                                    color: Colors.blueGrey, fontSize: 13)),
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 15,
                  right: 10,
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.blueGrey[50],
                        offset: Offset(0, 10),
                        blurRadius: 15,
                        spreadRadius: 1)
                  ],
                ),
                child: TextField(
                  maxLines: 3,
                  controller: massege,
                  decoration: InputDecoration(
                      isDense: true,
                      fillColor: Colors.white,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomRight: Radius.circular(150)),
                          borderSide: BorderSide(color: Colors.transparent)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomRight: Radius.circular(150)),
                          borderSide: BorderSide(
                            color: Colors.transparent,
                          )),
                      labelText: "Message",
                      labelStyle:
                          TextStyle(color: Colors.blueGrey, fontSize: 15)),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              RaisedButton(
                onPressed: () {
                  sendMassege();
                },
                padding:
                    EdgeInsets.only(left: 100, right: 100, top: 10, bottom: 8),
                color: Colors.blueGrey,
                child: Text(
                  "Send message",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void sendMassege() {
    String num;
    String msg;
    if (number.text == null || number.text.length < 10) {
      _globalKey.currentState
          .showSnackBar(SnackBar(content: Text("Enter Valid Mobile Number")));
      return;
    }
    num = selectedCountry + number.text;
    msg = massege.text;

    String url = "https://wa.me/$num?text=" + Uri.encodeComponent(msg);
    _launchURL(url);
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
