import 'package:flutter/material.dart';
import 'package:food2go/model/MazzayaResponse.dart';

import '../customviews/progress_dialog.dart';
import '../futures/app_futures.dart';
import '../models/base/EventObject.dart';
import '../pages/LoginPage.dart';
import '../utils/constants.dart';

class RegisterPage extends StatefulWidget {
  @override
  createState() => new RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final globalKey = new GlobalKey<ScaffoldState>();

  ProgressDialog progressDialog =
      ProgressDialog.getProgressDialog(ProgressDialogTitles.USER_REGISTER);

  TextEditingController fnameController = new TextEditingController(text: "");
  TextEditingController lnameController = new TextEditingController(text: "");
  TextEditingController phoneController = new TextEditingController(text: "");
  TextEditingController emailController = new TextEditingController(text: "");
  TextEditingController passwordController =
      new TextEditingController(text: "");
  TextEditingController cpasswordController =
  new TextEditingController(text: "");

//------------------------------------------------------------------------------

  bool isValidEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    RegExp regExp = new RegExp(p);

    return regExp.hasMatch(em);
  }

//------------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: globalKey,
        backgroundColor: Colors.deepOrange,
        body: new Stack(
          children: <Widget>[_loginContainer(), progressDialog],
        ));
  }

//------------------------------------------------------------------------------
  Widget _loginContainer() {
    return new Container(
        child: new ListView(
      children: <Widget>[
        new Center(
          child: new Column(
            children: <Widget>[
//------------------------------------------------------------------------------
              _appIcon(),
//------------------------------------------------------------------------------
              _formContainer(),
//------------------------------------------------------------------------------
            ],
          ),
        ),
      ],
    ));
  }

//------------------------------------------------------------------------------
  Widget _appIcon() {
    return new Container(
      decoration: new BoxDecoration(color: Colors.deepOrange),
      child: new Image(
        image: new AssetImage("assets/images/ic_launcher.png"),
        height: 170.0,
        width: 170.0,
      ),
      margin: EdgeInsets.only(top: 20.0),
    );
  }

//------------------------------------------------------------------------------
  Widget _formContainer() {
    return new Container(
      child: new Form(
          child: new Theme(
              data: new ThemeData(primarySwatch: Colors.deepOrange),
              child: new Column(
                children: <Widget>[
//------------------------------------------------------------------------------
                  _fnameContainer(),
//------------------------------------------------------------------------------
                  _lnameContainer(),
//------------------------------------------------------------------------------
                  _phoneContainer(),
//------------------------------------------------------------------------------
                  _emailContainer(),
//------------------------------------------------------------------------------
                  _passwordContainer(),
//------------------------------------------------------------------------------
                  _cpasswordContainer(),
//------------------------------------------------------------------------------
                  _registerButtonContainer(),
//------------------------------------------------------------------------------
                  _loginNowLabel(),
//------------------------------------------------------------------------------
                ],
              ))),
      margin: EdgeInsets.only(top: 20.0, left: 25.0, right: 25.0),
    );
  }

//------------------------------------------------------------------------------
  Widget _fnameContainer() {
    return new Container(
        child: new TextFormField(
            controller: fnameController,
            decoration: InputDecoration(
              suffixIcon: new Icon(
                Icons.face,
                color: Colors.white,
              ),
              labelText: Texts.FIRST_NAME,
              labelStyle: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            keyboardType: TextInputType.text),
        margin: EdgeInsets.only(bottom: 5.0));
  }

//------------------------------------------------------------------------------
  Widget _lnameContainer() {
    return new Container(
        child: new TextFormField(
            controller: lnameController,
            decoration: InputDecoration(
              suffixIcon: new Icon(
                Icons.face,
                color: Colors.white,
              ),
              labelText: Texts.LAST_NAME,
              labelStyle: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            keyboardType: TextInputType.text),
        margin: EdgeInsets.only(bottom: 5.0));
  }

//------------------------------------------------------------------------------
  Widget _phoneContainer() {
    return new Container(
        child: new TextFormField(
            controller: phoneController,
            decoration: InputDecoration(
              suffixIcon: new Icon(
                Icons.phone,
                color: Colors.white,
              ),
              labelText: Texts.PHONE_NUMBER,
              labelStyle: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            keyboardType: TextInputType.number),
        margin: EdgeInsets.only(bottom: 5.0));
  }

//------------------------------------------------------------------------------
  Widget _emailContainer() {
    return new Container(
        child: new TextFormField(
            controller: emailController,
            decoration: InputDecoration(
                suffixIcon: new Icon(
                  Icons.email,
                  color: Colors.white,
                ),
                labelText: Texts.EMAIL,
                labelStyle: TextStyle(fontSize: 18.0, color: Colors.white)),
            keyboardType: TextInputType.emailAddress),
        margin: EdgeInsets.only(bottom: 20.0));
  }

//------------------------------------------------------------------------------
  Widget _passwordContainer() {
    return new Container(
        child: new TextFormField(
          controller: passwordController,
          decoration: InputDecoration(
              suffixIcon: new Icon(
                Icons.vpn_key,
                color: Colors.white,
              ),
              labelText: Texts.PASSWORD,
              labelStyle: TextStyle(fontSize: 18.0, color: Colors.white)),
          keyboardType: TextInputType.text,
          obscureText: true,
        ),
        margin: EdgeInsets.only(bottom: 35.0));
  }

//------------------------------------------------------------------------------
  Widget _cpasswordContainer() {
    return new Container(
        child: new TextFormField(
          controller: cpasswordController,
          decoration: InputDecoration(
              suffixIcon: new Icon(
                Icons.vpn_key,
                color: Colors.white,
              ),
              labelText: Texts.CONFIRME_PASSWORD,
              labelStyle: TextStyle(fontSize: 18.0, color: Colors.white)),
          keyboardType: TextInputType.text,
          obscureText: true,
        ),
        margin: EdgeInsets.only(bottom: 35.0));
  }

//------------------------------------------------------------------------------
  Widget _registerButtonContainer() {
    return new Container(
        width: double.infinity,
        decoration: new BoxDecoration(color: Colors.deepOrange),
        child: new MaterialButton(
          textColor: Colors.deepOrange,
          color: Colors.white,
          padding: EdgeInsets.all(15.0),
          onPressed: _registerButtonAction,
          child: new Text(
            Texts.REGISTER,
            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          ),
        ),
        margin: EdgeInsets.only(bottom: 30.0));
  }

//------------------------------------------------------------------------------
  Widget _loginNowLabel() {
    return new GestureDetector(
      onTap: _goToLoginScreen,
      child: new Container(
          child: new Text(
            Texts.LOGIN_NOW,
            style: TextStyle(fontSize: 18.0, color: Colors.white),
          ),
          margin: EdgeInsets.only(bottom: 30.0)),
    );
  }

//------------------------------------------------------------------------------
  void _registerButtonAction() {
    if (fnameController.text == "") {
      globalKey.currentState.showSnackBar(new SnackBar(
        content: new Text(
          SnackBarText.ENTER_FIRST_NAME,
          style: TextStyle(color: Colors.white),
        ),
      ));
      return;
    }

    if (lnameController.text == "") {
      globalKey.currentState.showSnackBar(new SnackBar(
        content: new Text(
          SnackBarText.ENTER_LAST,
          style: TextStyle(color: Colors.white),
        ),
      ));
      return;
    }

    if (phoneController.text == "") {
      globalKey.currentState.showSnackBar(new SnackBar(
        content: new Text(
          SnackBarText.ENTER_PHONE,
          style: TextStyle(color: Colors.white),
        ),
      ));
      return;
    }

    if (emailController.text == "") {
      globalKey.currentState.showSnackBar(new SnackBar(
        content: new Text(
          SnackBarText.ENTER_EMAIL,
          style: TextStyle(color: Colors.white),
        ),
      ));
      return;
    }

    if (!isValidEmail(emailController.text)) {
      globalKey.currentState.showSnackBar(new SnackBar(
        content: new Text(SnackBarText.ENTER_VALID_MAIL),
      ));
      return;
    }

    if (passwordController.text == "") {
      globalKey.currentState.showSnackBar(new SnackBar(
        content: new Text(SnackBarText.ENTER_PASS),
      ));
      return;
    }

    if (cpasswordController.text == "") {
      globalKey.currentState.showSnackBar(new SnackBar(
        content: new Text(SnackBarText.ENTER_CONFIRMED_PASS),
      ));
      return;
    }

    FocusScope.of(context).requestFocus(new FocusNode());
    progressDialog.showProgress();
    _registerUser(
        fnameController.text,
        lnameController.text,
        phoneController.text,
        emailController.text,
        passwordController.text,
        cpasswordController.text);
  }

//------------------------------------------------------------------------------
  void _registerUser(String firstName, String lastName, String contactPhone,
      String emailAddress, String password, String cPassword) async {
    MazzayaResponse mazzayaResponse;
    EventObject eventObject = await registerUser(
        firstName, lastName, contactPhone, emailAddress, password, cPassword);

    if (eventObject.object != null && eventObject.object != '') {
      mazzayaResponse = eventObject.object;
    }

    switch (eventObject.id) {
      case 1:
        {
          setState(() {
            globalKey.currentState.showSnackBar(new SnackBar(
              content: new Text(mazzayaResponse.msg),
            ));
            progressDialog.hideProgress();
            _goToLoginScreen();
          });
        }
        break;
      case 2:
        {
          setState(() {
            globalKey.currentState.showSnackBar(new SnackBar(
              content: new Text(mazzayaResponse.msg),
            ));
            progressDialog.hideProgress();
          });
        }
        break;
      case EventConstants.NO_INTERNET_CONNECTION:
        {
          setState(() {
            globalKey.currentState.showSnackBar(new SnackBar(
              content: new Text(SnackBarText.NO_INTERNET_CONNECTION),
            ));
            progressDialog.hideProgress();
          });
        }
        break;
    }
  }

//------------------------------------------------------------------------------

  void _goToLoginScreen() {
    Navigator.pushReplacement(
      context,
      new MaterialPageRoute(builder: (context) => new LoginPage()),
    );
  }
//------------------------------------------------------------------------------
}
