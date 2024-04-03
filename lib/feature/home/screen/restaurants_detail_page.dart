import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resturant_app/feature/home/screen/widget/expandable_text.dart';

class RestaurantDetails extends StatefulWidget {
  const RestaurantDetails({super.key});

  @override
  State<RestaurantDetails> createState() => _RestaurantDetailsState();
}

class _RestaurantDetailsState extends State<RestaurantDetails> {
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Scaffold(

      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                width: width,
                  height: height*0.3,
                  child: Image.network("https://wallup.net/wp-content/uploads/2019/09/761345-restaurant-food-architecture-interior-design-room.jpg",fit: BoxFit.cover,)
              ),
              Positioned(
                bottom: 0,
                  left: width*0.03,
                  child:  Text("Restaurant Name",style: TextStyle(fontSize: width*0.04),)),
              Positioned(
                  top: height*0.04,
                  left: width*0.03,
                  child:  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                      child: SizedBox(
                        width: width*0.1,
                          height: width*0.1,
                          child: Icon(CupertinoIcons.back,size: width*0.06,))),)
            ],
          ),
          SizedBox(height: height*0.01,),
          Padding(
            padding:  EdgeInsets.only(left: width*0.07,right: width*0.07),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Restaurant Name",style: TextStyle(fontWeight: FontWeight.bold,fontSize: width*0.05),),
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
            padding:  EdgeInsets.only(left: width*0.08),
            child: Row(
              children: [
                Text("Cuisine type",style: TextStyle(fontSize: width*0.04),),
              ],
            ),
          ),
          SizedBox(height: height*0.005,),
          Padding(
            padding:  EdgeInsets.only(left: width*0.07),
            child: Row(
              children: [
                Icon(Icons.restaurant_menu,color: Colors.grey,size: width*0.06,),
                SizedBox(width: width*0.01,),
                Text("Cuisine type",style: TextStyle(fontSize: width*0.04),),
              ],
            ),
          ),
          SizedBox(height: height*0.005,),
          Padding(
            padding:  EdgeInsets.only(left: width*0.07),
            child: Row(
              children: [
                Icon(Icons.location_on_outlined,color: Colors.grey,size: width*0.06,),
                SizedBox(width: width*0.01,),
                Text("Location",style: TextStyle(fontSize: width*0.04),),
              ],
            ),
          ),
          SizedBox(height: height*0.005,),
          Padding(
            padding:  EdgeInsets.only(left: width*0.07),
            child: Row(
              children: [
                Icon(Icons.access_time_filled_rounded,color: Colors.grey,size: width*0.06,),
                SizedBox(width: width*0.01,),
                Text("Time",style: TextStyle(fontSize: width*0.04),),
              ],
            ),
          ),
          SizedBox(height: height*0.02,),
          Padding(
            padding:  EdgeInsets.only(left: width*0.07),
            child: Row(
              children: [

                Text("Raiting & Reviews",style: TextStyle(fontWeight: FontWeight.bold,fontSize: width*0.05),),
              ],
            ),
          ),
          SizedBox(height: height*0.005,),
          Padding(
            padding:  EdgeInsets.only(left: width*0.07),
            child: SizedBox(
              width: width,
              height: height*0.445,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                return Column(
                  children: [
                    SizedBox(
                      width: width,
                      child: Column(
                        children: [
                          Row(
                            children: [
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
                              ),
                              SizedBox(width: width*0.01,),
                              Text("Name",style: TextStyle(fontSize: width*0.04),),


                            ],
                          ),
                         
                         ExpandText(word: 'Lorem ipsum dolor sit amet, consecteturLorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus vehicula purus et lectus hendrerit adipiscing elit. Phasellus vehicula purus et lectus hendrerit  vestibulum. Vivamus pharetra fermentum arcu, nec lacinia ex iaculis quis. Aenean in justo vitae turpis euismod gravida.',),
                          SizedBox(height: height*0.005,),
                          Row(
                            children: [
                              Text("Date & time",style: TextStyle(fontSize: width*0.04),),
                            ],
                          )
                        ],
                      ),
                    ),
                    Divider()
                  ],
                );
              },),
            ),
          )
        ],
      ),
      floatingActionButton:CircleAvatar(
        radius: width*0.08,
        backgroundColor: Colors.orange,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.directions_outlined,color: Colors.white,),
            Text("GO",style: TextStyle(
              color: Colors.white,
                fontSize: width*0.03,
              fontWeight: FontWeight.bold 
            ),)
          ],
        ),
      ),
    );
  }
}
