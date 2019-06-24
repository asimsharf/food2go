import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food2go/model/Model_Dishes.dart';
import 'package:food2go/pages/DishesDetail.dart';
import 'package:food2go/tools/TextIcon.dart';
import 'package:google_fonts_arabic/fonts.dart';
import 'package:http/http.dart' as http;

class DishesPage extends StatefulWidget {
  int cat_id;
  String merchant_id;
  String merchant_bg;
  DishesPage({
    this.cat_id,
    this.merchant_id,
    this.merchant_bg,
  });
  @override
  State createState() => _DishesPage();
}

class _DishesPage extends State<DishesPage> {
  bool loading = false;
  List<Model_Dishes> _dishes = <Model_Dishes>[];

  Future<List<Model_Dishes>> get_all_category() async {
    String link =
        "http://mazzaya.net/restomax/mobileapp/api/getItemByCategory?cat_id=${widget.cat_id}&merchant_id=${widget.merchant_id}";
    var res = await http
        .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});
    setState(() {
      if (res.statusCode == 200) {
        var data = json.decode(res.body);
        var rest = data[0]['details']['item'] as List;
        _dishes = rest
            .map<Model_Dishes>((rest) => Model_Dishes.fromJson(rest))
            .toList();
        loading = false;
      }
    });
    return _dishes;
  }

  @override
  void initState() {
    super.initState();
    this.get_all_category();
    setState(() {
      loading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: Text(
            'Dishes',
            style: TextStyle(
              fontFamily: ArabicFonts.Cairo,
              package: 'google_fonts_arabic',
            ),
          ),
        ),
        body: loading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _dishes.length,
                itemBuilder: (BuildContext context, int index) {
                  final Dishes = _dishes[index];
                  final priceslist = Dishes.prices;
                  return new GestureDetector(
                    child: new Container(
                        decoration:
                            new BoxDecoration(color: Colors.white, boxShadow: [
                          new BoxShadow(
                            color: Colors.black,
                            blurRadius: 1.0,
                          ),
                        ]),
                        height: 100.0,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  height: 70.0,
                                  width: 90.0,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage('${Dishes.photo}'),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              Dishes.item_name,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: ArabicFonts.Cairo,
                                                package: 'google_fonts_arabic',
                                              ),
                                            ),
                                          ),
                                          TextIcon(
                                            text: "${543}",
                                            size: 14.0,
                                            icon: Icons.euro_symbol,
                                            isColumn: false,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              Dishes.item_description,
                                              style: TextStyle(
                                                fontSize: 10.0,
                                                fontFamily: ArabicFonts.Cairo,
                                                package: 'google_fonts_arabic',
                                              ),
                                            ),
                                          ),
                                          TextIcon(
                                            text: "${Dishes.discount}",
                                            icon: Icons.lock_open,
                                            isColumn: false,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Text(
                                              '${Dishes.single_details}',
                                              style: TextStyle(
                                                fontSize: 10.0,
                                                color: Colors.pinkAccent,
                                                fontFamily: ArabicFonts.Cairo,
                                                package: 'google_fonts_arabic',
                                              ),
                                            ),
                                          ),
                                          TextIcon(
                                            text: "address",
                                            icon: Icons.my_location,
                                            isColumn: false,
                                          ),
                                          TextIcon(
                                            text: "${1.5} km",
                                            icon: Icons.location_on,
                                            isColumn: false,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DishesDetail(
                              item_id: Dishes.item_id,
                              photo: Dishes.photo,
                              item_name: Dishes.item_name,
                              item_description: Dishes.item_description,
                              discount: Dishes.discount,
                              spicydish: Dishes.spicydish,
                              dish: Dishes.dish,
                              single_item: Dishes.single_item,
                              single_details: Dishes.single_details,
                              not_available: Dishes.not_available,
                              prices: Dishes.prices,
                              merchant_bg: widget.merchant_bg),
                        ),
                      );
                    },
                  );
                },
              ));
  }
}
