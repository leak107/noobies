import 'package:flutter/material.dart';
import 'package:noobies/restaurant.dart';

class RestaurantWidget extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantWidget({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30.0,
        backgroundImage: NetworkImage('${restaurant.image}'),
        backgroundColor: Colors.transparent,
      ),
      title: Text('${restaurant.name}'),
      subtitle: Text('${restaurant.fullAddress}'),
      trailing: Column(children: [
        Icon(
          Icons.star,
          color: Colors.red[500],
        ),
        Text('${restaurant.rating}'),
      ]),
    );
  }
}
