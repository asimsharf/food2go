import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food2go/model/Model_Merchant.dart';
import 'package:http/http.dart' as http;

class ContactsList extends StatefulWidget {
  static String tag = 'contactlist-page';

  @override
  State<StatefulWidget> createState() {
    return new _ContactsListState();
  }
}

class _ContactsListState extends State<ContactsList> {
  TextEditingController searchController = new TextEditingController();
  String filter;

  List<Model_Merchant> _browse_restaurant = <Model_Merchant>[];
  Future<List<Model_Merchant>> getBrowseRestaurant() async {
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
  initState() {
    this.getBrowseRestaurant();
    searchController.addListener(() {
      setState(() {
        filter = searchController.text;
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Contacts',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold))),
        body: new Column(
          children: <Widget>[
            new Padding(
              padding: new EdgeInsets.all(8.0),
              child: new TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search Contacts',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
            ),
            new Expanded(
              child: new ListView.builder(
                itemCount: _browse_restaurant.length,
                itemBuilder: (context, index) {
                  // if filter is null or empty returns all data
                  return filter == null || filter == ""
                      ? new ListTile(
                          title: Text(
                            '${_browse_restaurant[index].restaurant_name}',
                          ),
                          subtitle:
                              Text('${_browse_restaurant[index].cuisine}'),
                          leading: new CircleAvatar(
                              backgroundColor: Colors.blue,
                              child: Text(
                                  '${_browse_restaurant[index].restaurant_name.substring(0, 1)}')),
                          onTap: () =>
                              _onTapItem(context, _browse_restaurant[index]),
                        )
                      : '${_browse_restaurant[index].restaurant_name}'
                              .toLowerCase()
                              .contains(filter.toLowerCase())
                          ? new ListTile(
                              title: Text(
                                '${_browse_restaurant[index].restaurant_name}',
                              ),
                              subtitle:
                                  Text('${_browse_restaurant[index].cuisine}'),
                              leading: new CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  child: Text(
                                      '${_browse_restaurant[index].restaurant_name.substring(0, 1)}')),
                              onTap: () => _onTapItem(
                                  context, _browse_restaurant[index]),
                            )
                          : new Container();
                },
              ),
            ),
          ],
        ));
  }

  void _onTapItem(BuildContext context, Model_Merchant post) {
    Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text("Tap on " + ' - ' + post.restaurant_name)));
  }
}
