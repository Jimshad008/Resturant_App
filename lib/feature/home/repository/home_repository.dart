import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:resturant_app/model/reustarant_model.dart';
import 'package:http/http.dart' as http;
final homeRepositoryProvider=Provider((ref) => HomeRepository());
class HomeRepository{
 Future<Restaurants> getRestaurants()async{
   var datas;

   final response = await http.get((Uri.parse(
       "https://firstflight-web.ipixsolutions.net/api/getRestaurants")));
   if (response.statusCode == 200) {
     var data = jsonDecode(response.body);
     datas = Restaurants.fromJson(data);
     // _resto = Restaurants.fromJson(data);
   } else {
     "Failed to load data";
   }
   return datas;
 }

}