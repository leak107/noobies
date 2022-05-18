import 'package:flutter/material.dart';
import 'package:noobies/restaurant.dart';
import 'package:noobies/restaurant_detail.dart';
import 'package:noobies/restaurant_widget.dart';
import 'package:noobies/search_page.dart';

class RestaurantList extends StatefulWidget {
  const RestaurantList({Key? key}) : super(key: key);

  @override
  _RestaurantListState createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  late Future <List<Restaurant>> futureRestaurants;
  final List<Restaurant> restaurants = [];

  @override
  void initState() {
      super.initState();

      futureRestaurants = fetchRestaurant();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant List'),
        actions: [
            IconButton(
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => SearchPage(restaurants: restaurants))),
                icon: Icon(Icons.search),
            ),
        ]
      ),
      body: Container(
          child: FutureBuilder <List<Restaurant>>(
              future: futureRestaurants,
              builder: (BuildContext context, AsyncSnapshot snapshot){
                  if (snapshot.hasData) {
                      restaurants.addAll(snapshot.data);

                      return ListView.builder(
                          padding: const EdgeInsets.all(16.0),
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index){
                              return GestureDetector(
                                  onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              DetailScreen(restaurant: snapshot.data[index])));
                                  },
                                  child: RestaurantWidget(restaurant: snapshot.data[index]),
                              );
                          }
                      );
                  } else {
                      return Center(
                          child: CircularProgressIndicator()
                      );
                  }
              }
          )
      ),
    );
  }
}

