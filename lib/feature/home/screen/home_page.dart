import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resturant_app/feature/home/screen/restaurants_detail_page.dart';
import 'package:resturant_app/feature/login/screen/loginScreen.dart';
import 'package:http/http.dart' as https;
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  getApi() async {


      print("wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww");
      var response = await https.get((Uri.parse(
          "https://firstflight-web.ipixsolutions.net/api/getRestaurants")));
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);
        print("!@#%^&^%#@#%^&*(");
        // _resto = Restaurants.fromJson(data);
      } else {
        print("Failed to load data");
      }


  }
  @override
  void initState() {
    print("!!!!!!!!!!!!!!!!!!");
    getApi();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("RESTAURANTS",style: TextStyle(fontWeight:FontWeight.bold,fontSize: width*0.05,color: Colors.white),),
        actions:[
          GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder:(context) => LoginScreen(),), (route) => false);
            },
            child: Row(
              children: [
                Icon(Icons.logout,color: Colors.white,),

                Text("Logout",style: TextStyle(color: Colors.white),)
              ],
            ),
          ),
          SizedBox(width: width*0.05,)
        ] ,
      ),
      body: Container(
        height: height,

        child: ListView.builder(
          itemCount: 5,
          itemBuilder:
            (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(context, CupertinoPageRoute(builder: (context) => const RestaurantDetails(),), );
              },
              child: Column(
                children: [
                  Container(
                    width: width,
                    height: height*0.4,
                    child: Column(
                      children: [
                        Padding(
                          padding:  EdgeInsets.only(top:height*0.008,bottom:height*0.008   ),
                          child: SizedBox(
                           width: width,
                              height: height*0.25,
                              child: Image.network("https://wallup.net/wp-content/uploads/2019/09/761345-restaurant-food-architecture-interior-design-room.jpg")),
                        ),
                        SizedBox(height: height*0.01,),
                        Padding(
                          padding:  EdgeInsets.only(left: width*0.07,right: width*0.07),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Restaurant Name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: width*0.04),),
                              Container(
                                width: width*0.13,
                                height: height*0.025,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(width*0.025),
                                  color: Colors.green
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('3.7',style: TextStyle(color: Colors.white,fontSize: width*0.03),),
                                    SizedBox(width: width*0.01,),
                                    Icon(Icons.star,color: Colors.white,size: width*0.04,)
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: height*0.02,),
                        Padding(
                          padding:  EdgeInsets.only(left: width*0.07),
                          child: Row(
                            children: [
                              Icon(Icons.restaurant_menu,color: Colors.grey,size: width*0.05,),
                              SizedBox(width: width*0.01,),
                              Text("Cuisine type",style: TextStyle(fontSize: width*0.03),),
                            ],
                          ),
                        ),
                        SizedBox(height: height*0.005,),
                        Padding(
                          padding:  EdgeInsets.only(left: width*0.07),
                          child: Row(
                            children: [
                              Icon(Icons.location_on_outlined,color: Colors.grey,size: width*0.05,),
                              SizedBox(width: width*0.01,),
                              Text("Location",style: TextStyle(fontSize: width*0.03),),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 1,
                      child: Divider(thickness: 1,color: Colors.grey,))
                ],
              ),
            );

        },),
      ),
    );
  }
}
