import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login.dart';

void main() {
  runApp(Profile());
}

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            title: Text("Profile"),
            centerTitle: true,
            backgroundColor: Color(0xff073B3A),
          ),
        ),
        body: Container(
          color: Color(0xffEFEFEF),
          child: Stack(
            children: [
              Align(
                alignment: Alignment(0, -0.6),
                child: Icon(
                  Icons.person,
                  size: 96,
                  color: Theme.of(context).primaryColor,
                )
              ),
              Align(
                alignment: Alignment(0, -0.3),
                child: Container(
                  child: Text("Veronica",
                    textScaleFactor: 2,
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, 0.4),
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      side: BorderSide(color: Color(0xff073B3A))
                  ),
                  onPressed: () => _logout(context),
                  splashColor: Colors.grey,
                  child: Container(
                    height:  MediaQuery.of(context).size.height / 12,
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment(-0.2, 0),
                          child: Text("Log Out",
                              style: TextStyle(color: Color(0xff073B3A))),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.add, color: Color(0xff073B3A)),
                        )
                      ],
                    ),
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }

  _logout(context) {
    Route route = MaterialPageRoute(builder: (context) => LoginScreen());
    Navigator.pushReplacement(context, route);
  }
}
