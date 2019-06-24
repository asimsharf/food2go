import 'package:flutter/material.dart';
import 'package:google_fonts_arabic/fonts.dart';

var item_id;

class OrderItem {
  String item_name;
  int qty;
  String category_id;
  double price;
  String photo;
  int item_id;
  OrderItem(this.item_id, this.item_name, this.category_id, this.qty,
      this.price, this.photo);
}

class CartPage extends StatefulWidget {
  String item_id;
  int cat_id;
  String merchant_id;
  String photo;
  String item_name;
  String item_description;
  String prices;
  String discount;
  String spicydish;
  String dish;
  int single_item;
  String single_details;
  String not_available;
  String merchant_bg;
  int qty;

  CartPage(
      {this.item_id,
      this.cat_id,
      this.merchant_id,
      this.photo,
      this.item_name,
      this.item_description,
      this.prices,
      this.single_details,
      this.discount,
      this.dish,
      this.not_available,
      this.single_item,
      this.spicydish,
      this.merchant_bg,
      this.qty});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new OrderPageState();
  }
}

class OrderPageState extends State<CartPage> {
  final List<OrderItem> _items = <OrderItem>[
    new OrderItem(1, 'Mixed Grill', 'Platter', 1, 30.0, 'drawerbg.jpg'),
    new OrderItem(2, 'Grilled Chicken', 'Sandwich', 2, 10.0, 'drawerbg.jpg'),
    new OrderItem(3, 'Fresh Orange Juice', 'Drink', 3, 8.0, 'drawerbg.jpg'),
    new OrderItem(4, 'Fresh Apple Juice', 'Drink', 1, 8.0, 'drawerbg.jpg'),
    new OrderItem(5, 'Fresh Apple Juice', 'Drink', 1, 8.0, 'drawerbg.jpg'),
  ];

  final ddlValues = <int>[1, 2, 3, 4, 5];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: new CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: <Widget>[
          new SliverAppBar(
            expandedHeight: 180.0,
            pinned: true,
            flexibleSpace: new FlexibleSpaceBar(
              title: const Text("Cart order",
                  style: TextStyle(
                    fontFamily: ArabicFonts.Cairo,
                    package: 'google_fonts_arabic',
                  )),
              background:
                  new Image.network("${widget.merchant_bg}", fit: BoxFit.cover),
            ),
          ),
          new SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              sliver: new SliverFixedExtentList(
                itemExtent: 200.0,
                delegate: new SliverChildBuilderDelegate(
                    (builder, index) => _buildListItem(_items[index]),
                    childCount: _items.length),
              )),
          new SliverToBoxAdapter(
              child: new Container(
            alignment: Alignment.center,
            height: 50.0,
            color: const Color(0xffe04d25),
            child: new InkWell(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Text(
                    'Check out',
                    style: new TextStyle(
                        color: Colors.white,
                        fontFamily: ArabicFonts.Cairo,
                        package: 'google_fonts_arabic',
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0),
                  ),
                  new SizedBox(
                    width: 10.0,
                  ),
                  new Hero(
                      tag: "basket",
                      child: new Icon(
                        Icons.shopping_basket,
                        color: Colors.black,
                        size: 24.0,
                      ))
                ],
              ),
              onTap: () {},
            ),
          ))
        ],
      ),
    );
  }

  //قائمة من المنتجات المضافة اليى السله
  Widget _buildListItem(OrderItem itm) {
    return new Card(
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Flexible(
            child: _buildColumn1(itm),
            flex: 1,
          ),
          new Flexible(child: _buildColumn2(itm), flex: 3),
        ],
      ),
    );
  }

  Widget _buildColumn1(OrderItem itm) {
    return new Column(
      children: <Widget>[
        new Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 15.0, top: 5.0),
            child: new InkWell(
              child: new Hero(
                child: new Image.network(
                  '${widget.photo}',
                  width: 100.0,
                  height: 100.0,
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                ),
                tag: itm.item_id,
              ),
              onTap: () {
                Navigator.of(context).push(new PageRouteBuilder(
                    opaque: false,
                    pageBuilder: (BuildContext context, _, __) {
                      return new Material(
                          color: Colors.black38,
                          child: new Container(
                            padding: const EdgeInsets.all(30.0),
                            child: new InkWell(
                              child: new Hero(
                                child: new Image.network(
                                  '${widget.photo}',
                                  width: 300.0,
                                  height: 300.0,
                                  alignment: Alignment.center,
                                  fit: BoxFit.contain,
                                ),
                                tag: itm.item_id,
                              ),
                              onTap: () {
                                Navigator.pop(context);
                              },
                            ),
                          ));
                    }));
              },
            ))
      ],
    );
  }

  Widget _buildColumn2(OrderItem itm) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        new Padding(
          padding: const EdgeInsets.only(bottom: 10.0, top: 10.0),
          child: new Text(
            itm.item_name,
            style: TextStyle(
                fontFamily: ArabicFonts.Cairo,
                package: 'google_fonts_arabic',
                fontWeight: FontWeight.bold),
          ),
        ),
        new Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: new Text(itm.category_id),
        ),
        new Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new Text(
                "Quantity",
                style: TextStyle(
                    fontFamily: ArabicFonts.Cairo,
                    package: 'google_fonts_arabic',
                    color: Colors.grey),
              ),
              new SizedBox(
                width: 20.0,
              ),
              new DropdownButton<int>(
                items: ddlValues.map((f) {
                  return new DropdownMenuItem<int>(
                    value: f,
                    child: new Text(f.toString()),
                  );
                }).toList(),
                value: itm.qty,
                onChanged: (int newVal) {
                  itm.qty = newVal;
                  this.setState(() {});
                },
              )
            ],
          ),
        ),
        _buildBottomRow(itm.price, itm.qty),
      ],
    );
  }

  Widget _buildBottomRow(double itemPrice, int qty) {
    return new Container(
        margin: const EdgeInsets.only(bottom: 10.0, right: 10.0),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Flexible(
              flex: 1,
              child: new Text(
                "Dish Price",
                style: TextStyle(
                    fontFamily: ArabicFonts.Cairo,
                    package: 'google_fonts_arabic',
                    color: Colors.grey),
              ),
            ),
            //  new SizedBox(width: 5.0,),
            new Flexible(
                flex: 1,
                child: new Text(
                  itemPrice.toStringAsPrecision(2),
                  style: TextStyle(
                      fontFamily: ArabicFonts.Cairo,
                      package: 'google_fonts_arabic',
                      fontWeight: FontWeight.bold),
                )),
            // new SizedBox(width: 10.0,),
            new Flexible(
              flex: 1,
              child: new Text(
                "Total Amount",
                style: TextStyle(
                    fontFamily: ArabicFonts.Cairo,
                    package: 'google_fonts_arabic',
                    color: Colors.grey),
              ),
            ),
            new SizedBox(
              width: 5.0,
            ),
            new Flexible(
                flex: 1,
                child: new Text(
                  (qty * itemPrice).toString(),
                  style: TextStyle(
                      fontFamily: ArabicFonts.Cairo,
                      package: 'google_fonts_arabic',
                      fontWeight: FontWeight.bold),
                ))
          ],
        ));
  }
}
