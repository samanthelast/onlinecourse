import 'package:flutter/material.dart';

import 'course.dart';

class Search extends StatefulWidget {
  Search({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _SearchState createState() => new _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController editingController = TextEditingController();

  final title = [
    'اموزش کراس',
    'اموزش سی پلاس پلاس',
    'مهندسی نرم افزار',
    'اموزش رسپری پای',
    'اموزش رسپری پای',
    'اموزش رسپری پای',
    'اموزش رسپری پای',
  ];
  final creators = [
    'سامان اریانپور',
    'محمد دیلمی',
    'همایون بهشتی',
    'علی میرزازاده',
    'علی میرزازاده',
    'علی میرزازاده',
    'علی میرزازاده',
  ];
  var items = List<String>();

  @override
  void initState() {
    items.addAll(title);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(title);
    if (query.isNotEmpty) {
      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        if (item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(title);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 64, left: 32, right: 32),
      child: Column(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Directionality(
                child: TextField(
                  onChanged: (value) {
                    filterSearchResults(value);
                  },
                  controller: editingController,
                  decoration: InputDecoration(
                      labelText: "جستجو",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
                ),
                textDirection: TextDirection.rtl,
              )),
          Expanded(
            child: ListView.builder(
              
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(children:<Widget>[ListTile(
                      title: Text('${items[index]}'),
                      trailing: Text('${creators[index]}'),
                      onTap: () {
                        _RouteToCourseScreen(context);
                        /*      _RouteToDetailScreen(
                        context,
                        Products[index].getcardColor(),
                        Products[index].getimgUrl(),
                        Products[index].getpreviousPrice(),
                        Products[index].getprice(),
                        Products[index].getTitle()); */
                      },
                    ),Divider()]
                  
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
void _RouteToCourseScreen(BuildContext context) {
  
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Course(
            videoID: '1',
            videoVal: '1',
            title:'1',
            videoLengh:'1',
            price:'1',
            description:'1',
          ),
        ));
  

}
  /*  void _RouteToDetailScreen(BuildContext context, int cardColor, String imgUrl,
      String title, String previousPrice, String price) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailScreen(
            cardColor: cardColor,
            imgUrl: imgUrl,
            title: title,
            previousPrice: previousPrice,
            price: price,
          ),
        ));
  } */
}
