import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  String _password;
  String _email;

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Color(0xff073B3A)),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Color(0xff073B3A),
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
          ),
          Text(
            'Recuérdame',
            style: TextStyle(
              color: Color(0xff073B3A),
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          final form = _formKey.currentState;
          if (form.validate()) {
            // Text forms was validated.
            form.save();
            checkPassword();
          } else {
            //;
          }
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'Iniciar Sesión',
          style: TextStyle(
            color: Color(0xff073B3A),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Form(
            key: _formKey,
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.white,
                ),
                Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 120.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Registrarse',
                          style: TextStyle(
                            color: Color(0xff073B3A),
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 30.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Usuario',
                              style: TextStyle(
                                color: Color(0xff073B3A),
                                fontWeight: FontWeight.bold,
                                fontFamily: 'OpenSans',
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Container(
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Color(0xff073B3A)),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              height: 60.0,
                              child: TextFormField(
                                onSaved: (value) => {
                                  _email = value,
                                  print(_email)
                                },
                                style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  color: Color(0xff073B3A),
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 14.0),
                                    prefixIcon: Icon(
                                      Icons.account_circle_outlined,
                                      color: Color(0xff073B3A),
                                    ),
                                    hintText: 'Ingrese su nombre de usuario',
                                    hintStyle: TextStyle(
                                      color: Color(0xff073B3A),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'OpenSans',
                                    )
                                 ),
                               ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Contraseña',
                                style: TextStyle(
                                  color: Color(0xff073B3A),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'OpenSans',
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Color(0xff073B3A)),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                height: 60.0,
                                child: TextFormField(
                                  onSaved: (value) => {
                                    _password = value,
                                    print(_password)
                                  },
                                  obscureText: true,
                                  style: TextStyle(
                                    color: Color(0xff073B3A),
                                    fontFamily: 'OpenSans',
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(top: 14.0),
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Color(0xff073B3A),
                                    ),
                                    hintText: 'Ingrese su contraseña',
                                    hintStyle: TextStyle(
                                        color: Color(0xff073B3A),
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'OpenSans',
                                        fontSize: 14
                                    ),
                                  ),
                                ),
                              ),
                            ]
                          )
                        ),
                        SizedBox(height: 30.0),
                        _buildRememberMeCheckbox(),
                        _buildLoginBtn(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        )
      )
    );
  }

  checkPassword() async {
    Route route = MaterialPageRoute(builder: (context) => MyHomePage());
    Navigator.pushReplacement(context, route);
    var client = http.Client();
    var url = 'https://wakerakka.herokuapp.com/';
    var endpoint = 'authenticate/';
    /**Map<String,String> headers = {
      'Keep-Alive' : 'timeout=1'
    };**/
    try {
      var uriResponse = await client.post(url+endpoint,
          body: {'username': _email, 'pwd': _password});

      if (uriResponse.statusCode == 202) {
        Route route = MaterialPageRoute(builder: (context) => MyHomePage());
        Navigator.pushReplacement(context, route);
      }
      else {
        print("wrong password");
      }
    } finally {
      client.close();
    }
  }
}