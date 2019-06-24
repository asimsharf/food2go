import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food2go/testApp/entities/note.dart';
import 'package:http/http.dart' as http;

class HomeSearchPage extends StatefulWidget {
  @override
  _HomeSearchPage createState() => _HomeSearchPage();
}

class _HomeSearchPage extends State<HomeSearchPage> {
  List<Model_Merchant> _browse_restaurant = <Model_Merchant>[];
  Future<List<Model_Merchant>> _getBrowseRestaurant() async {
    String link = "http://mazzaya.net/restomax/mobileapp/api/BrowseRestaurant";
    var res = await http
        .get(Uri.encodeFull(link), headers: {"Accept": "application/json"});

    setState(() {
      if (res.statusCode == 200) {
        var data = json.decode(res.body);
        var rest = data[0]['details']['data'] as List;
        for (var dataJson in rest) {
          _browse_restaurant.add(Model_Merchant.fromJson(dataJson));
        }
        _browse_restaurant = rest
            .map<Model_Merchant>((rest) => Model_Merchant.fromJson(rest))
            .toList();
      }
    });
    return _browse_restaurant;
  }

  @override
  void initState() {
    _getBrowseRestaurant().then((value) {
      setState(() {
        _browse_restaurant.addAll(value);
        _browse_restaurant = _browse_restaurant;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter listview with json'),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            return index == 0 ? _searchBar() : _listItem(index - 1);
          },
          itemCount: _browse_restaurant.length + 1,
        ));
  }

  _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(hintText: 'Search...'),
        onChanged: (text) {
          text = text.toLowerCase();
          setState(() {
            _browse_restaurant = _browse_restaurant.where((Model_Cards) {
              var _Model_Cards_full_name =
                  Model_Cards.restaurant_name.toLowerCase();
              return _Model_Cards_full_name.contains(text);
            }).toList();
          });
        },
      ),
    );
  }

  _listItem(index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(
            top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              _browse_restaurant[index].restaurant_name,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              _browse_restaurant[index].restaurant_name,
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}
