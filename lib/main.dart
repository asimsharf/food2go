import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food2go/scoped-model/items_model.dart';
import 'package:scoped_model/scoped_model.dart';

import 'tools/SplashScreenPage.dart';
import 'tools/routes.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new App());
  });
}

class App extends StatefulWidget {
  @override
  _AppState createState() => new _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: ProductsModel(),
      child: new MaterialApp(
          theme: Theme.of(context).copyWith(
              accentIconTheme: Theme.of(context)
                  .accentIconTheme
                  .copyWith(color: Colors.white),
              accentColor: Colors.deepOrange,
              primaryColor: Colors.deepOrange,
              primaryIconTheme: Theme.of(context)
                  .primaryIconTheme
                  .copyWith(color: Colors.white),
              primaryTextTheme: Theme.of(context)
                  .primaryTextTheme
                  .apply(bodyColor: Colors.white)),
          debugShowCheckedModeBanner: false,
//        home: SplashPageLoginTow(),
          home: SplashScreenPage(),
          routes: routes),
    );
  }
}
