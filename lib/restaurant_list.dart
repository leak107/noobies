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
  final List <Restaurant> restaurantList = [];
  bool isSearching = false;
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
      super.initState();

      futureRestaurants = fetchRestaurant();
  }

  void filterRestaurant(String query) {
      if (query.isNotEmpty) {
          isSearching = true;
          List <Restaurant> filteredRestaurant = [];
          restaurantList.forEach((restaurant) {
              if (restaurant.name.toLowerCase().contains(query.toLowerCase())) {
                  filteredRestaurant.add(restaurant);
              }
          });

          setState(() {
              restaurantList.clear();
              restaurantList.addAll(filteredRestaurant);
          });
      } else {
          isSearching = false;

          setState(() {});
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant List'),
      ),
      body: Container(
          child: Column(
              children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                          onChanged: (value) {
                              filterRestaurant(value);
                          },
                          controller: editingController,
                          decoration: InputDecoration(
                              labelText: "Search",
                              hintText: "Search",
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                      ),
                  ),
                  FutureBuilder <List<Restaurant>>(
                      future: futureRestaurants,
                      builder: (BuildContext context, AsyncSnapshot snapshot){
                          if (snapshot.hasData) {
                              if (isSearching == false) {
                                  restaurantList.addAll(snapshot.data);
                              }

                              return Expanded(
                                  child: ListView.builder(
                                      padding: const EdgeInsets.all(16.0),
                                      itemCount: isSearching ? restaurantList.length : snapshot.data.length,
                                      itemBuilder: (BuildContext context, int index){
                                          return GestureDetector(
                                              onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                          DetailScreen(restaurant: isSearching ? restaurantList[index] : snapshot.data[index])));
                                              },
                                              child: RestaurantWidget(restaurant: isSearching ? restaurantList[index] : snapshot.data[index]),
                                          );
                                      }
                                  )
                              );
                          } else {
                              return Center(
                                  child: CircularProgressIndicator()
                              );
                          }
                      }

                  )
              ],
          )
      )
    );
  }
}
