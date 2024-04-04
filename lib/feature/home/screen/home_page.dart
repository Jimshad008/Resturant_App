import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:resturant_app/core/error_text.dart';
import 'package:resturant_app/core/loader.dart';
import 'package:resturant_app/feature/home/controller/home_controller.dart';
import 'package:resturant_app/feature/home/screen/restaurants_detail_page.dart';
import 'package:resturant_app/feature/login/controller/loginController.dart';
import 'package:resturant_app/feature/login/screen/loginScreen.dart';
import 'package:http/http.dart' as https;
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List images=[
    "assets/res1.jpg",
    "assets/res2.jpg",
    "assets/res3.jpg",
    "assets/res4.jpg",
    "assets/res5.jpg",

  ];

  @override
  void initState() {

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
          Consumer(
            builder: (context,ref,child) {
              return GestureDetector(
                onTap: () {
                  ref.read(loginControllerProvider).logoutUser(context: context);
                },
                child: const Row(
                  children: [
                    Icon(Icons.logout,color: Colors.white,),

                    Text("Logout",style: TextStyle(color: Colors.white),)
                  ],
                ),
              );
            }
          ),
          SizedBox(width: width*0.05,)
        ] ,
      ),
      body: SizedBox(
        height: height,

        child: Consumer(
          builder: (context,ref,child) {

            return ref.watch(getRestaurantsProvider).when(data: (rest) {
              print("QQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQ");
              return  ListView.builder(
                itemCount: rest.restaurants.length,
                itemBuilder:
                    (context, index) {
                  double raiting=0.0;
                  var sum=0;
                  for(int i=0;i<rest.restaurants[index].reviews.length;i++){
                    sum=sum+rest.restaurants[index].reviews[i].rating;


                  }
                  raiting=sum/rest.restaurants[index].reviews.length;


                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, CupertinoPageRoute(builder: (context) =>  RestaurantDetails(restaurant:rest.restaurants[index],image:images[index%5] , ),), );
                    },
                    child: Column(
                      children: [
                        SizedBox(
                          width: width,
                          height: height*0.4,
                          child: Column(
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(top:height*0.008,bottom:height*0.008   ),
                                child: SizedBox(
                                    width: width,
                                    height: height*0.25,
                                    child: Image.asset(images[index%5],fit: BoxFit.fill,)),
                              ),
                              SizedBox(height: height*0.01,),
                              Padding(
                                padding:  EdgeInsets.only(left: width*0.07,right: width*0.07),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(rest.restaurants[index].name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: width*0.04),),
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
                                          Text(raiting.toStringAsFixed(1).toString(),style: TextStyle(color: Colors.white,fontSize: width*0.03),),
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
                                    Text(rest.restaurants[index].cuisineType,style: TextStyle(fontSize: width*0.03),),
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
                                    Text(rest.restaurants[index].address,style: TextStyle(fontSize: width*0.03),),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                            height: 1,
                            child: Divider(thickness: 1,color: Colors.grey,))
                      ],
                    ),
                  );

                },);
            }, error: (error, stackTrace) {
              print(error);
              return ErrorText(error: error.toString());
            }, loading: () =>const Loader() ,);

          }
        ),
      ),
    );
  }
}
