import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:resturant_app/feature/home/screen/widget/expandable_text.dart';
import 'package:resturant_app/model/reustarant_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class RestaurantDetails extends StatefulWidget {
  final Restaurant restaurant;
  final String image;
  const RestaurantDetails({super.key,required this.restaurant,required this.image});

  @override
  State<RestaurantDetails> createState() => _RestaurantDetailsState();
}

class _RestaurantDetailsState extends State<RestaurantDetails> {
  double raiting=0.0;
  String today="";
  Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunchUrl(Uri.parse(googleUrl))) {

      await launchUrl(Uri.parse(googleUrl));
    } else {
      throw 'Could not launch $googleUrl';
    }
  }
  String getDayName(DateTime dateTime) {
    // Define a list of day names
    List<String> daysOfWeek = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];

    // Get the index of the day of the week (0 for Monday, 1 for Tuesday, etc.)
    int dayIndex = dateTime.weekday - 1;

    // Return the day name
    return daysOfWeek[dayIndex];
  }
  getRaiting(){
    var sum=0;
    for(int i=0;i<widget.restaurant.reviews.length;i++){
      sum=sum+widget.restaurant.reviews[i].rating;


    }
    raiting=sum/widget.restaurant.reviews.length;
  }
  List timeKeys=[];
  Map time={

  };
  String getCorrectTime(String time){
    String result="";
    int c=0;
    int ind=0;
    if(!time.contains(',')){
      for(int i=0;i<time.length;i++){

        if(time[i]=="="){
          ind++;
          result="$result${time.substring(c,i)}:";
          c=i+2;
          if(ind==2){
            result="$result${time.substring(c,time.length)}";
          }
        }

      }
    }
    else{
      for(int i=0;i<time.length;i++){

        if(time[i]=="="){

          result="$result${time.substring(c,i)}:";
          c=i+2;

        }

      }
      result="$result${time.substring(c,time.length)}";
    }


    return result;
  }
  getTime(){
    today=getDayName(DateTime.now());
   time["Sunday"]=getCorrectTime(widget.restaurant.operatingHours.sunday);
   time["Monday"]=getCorrectTime(widget.restaurant.operatingHours.monday);
   time["Tuesday"]=getCorrectTime(widget.restaurant.operatingHours.tuesday);
   time["Wednesday"]=getCorrectTime(widget.restaurant.operatingHours.wednesday);
   time["Thursday"]=getCorrectTime(widget.restaurant.operatingHours.thursday);
   time["Friday"]=getCorrectTime(widget.restaurant.operatingHours.friday);
   time["Saturday"]=getCorrectTime(widget.restaurant.operatingHours.saturday);
   for(var i in time.keys){
     if(i!=today){
       timeKeys.add(i);
     }
   }
  }
  @override
  void initState() {





getTime();

  getRaiting();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print(today);
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Scaffold(

      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: width,
                    height: height*0.3,
                    child: Image.asset(widget.image,fit: BoxFit.cover,)
                ),
                Positioned(
                  bottom: 0,
                    left: width*0.03,
                    child:  Text(widget.restaurant.name,style: TextStyle(fontSize: width*0.04),)),
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
                  Text(widget.restaurant.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: width*0.05),),
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
                        Text(raiting.toStringAsFixed(1),style: TextStyle(color: Colors.white,fontSize: width*0.03),),
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
                  Text(widget.restaurant.neighborhood.name,style: TextStyle(fontSize: width*0.04,fontWeight: FontWeight.w500),),
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
                  Text(widget.restaurant.cuisineType,style: TextStyle(fontSize: width*0.04),),
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
                  Text(widget.restaurant.address,style: TextStyle(fontSize: width*0.04),),
                ],
              ),
            ),
            SizedBox(height: height*0.005,),
            Padding(
              padding:  EdgeInsets.only(left: width*0.07),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Expanded(
                    child: ExpandablePanel(
                      collapsed: Container(), expanded: SizedBox(

                      child:Padding(
                        padding:  EdgeInsets.only(left:width*0.07),
                        child: Column(
                          children: List.generate(timeKeys.length, (index) =>SizedBox(
                              child: Column(
                                children: [

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: width*0.2,
                                          child: Text("${timeKeys[index]}:",style: TextStyle(fontSize: width*0.04),)),
                                      SizedBox(
                                        width: width*0.6,
                                          child: Text("${time[timeKeys[index]]}",style: TextStyle(fontSize: width*0.04),)),
                                    ],
                                  ),
                                  SizedBox(height: height*0.005,),
                                ],
                              ))),
                        ),
                      )

                    ),
                      theme: ExpandableThemeData(
                        iconColor: Colors.black,
                        iconSize: 14,
                        iconPadding: EdgeInsets.only(bottom: height*0.008,right: width*0.05)
                      ),

                    header: SizedBox(
                      height: height*0.02,
                        child: Row(
                          children: [
                            Icon(Icons.access_time_filled_rounded,color: Colors.grey,size: width*0.06,),
                            SizedBox(width: width*0.01,),
                            Text("$today: ${time[today]}",style: TextStyle(fontSize: width*0.04),),
                          ],
                        )),


                    ),
                  ),],
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

            Padding(
              padding:  EdgeInsets.only(left: width*0.06,right:width*0.06 ),
              child: SizedBox(
                width: width,

                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.restaurant.reviews.length,
                  itemBuilder: (context, index) {
                  return SizedBox(
                    child: Column(
                      children: [

                        SizedBox(
                          width: width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
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
                                        Text(widget.restaurant.reviews[index].rating.toStringAsFixed(1).toString(),style: TextStyle(color: Colors.white,fontSize: width*0.03),),
                                        SizedBox(width: width*0.01,),
                                        Icon(Icons.star,color: Colors.white,size: width*0.04,)
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: width*0.01,),
                                  Text(widget.restaurant.reviews[index].name,style: TextStyle(fontSize: width*0.04),),


                                ],
                              ),

                             ExpandText(word: widget.restaurant.reviews[index].comments,),
                              SizedBox(height: height*0.005,),
                              Row(
                                children: [
                                  Text(widget.restaurant.reviews[index].date.name
                                      .substring(0, 7) +
                                      ' ' +
                                      widget.restaurant.reviews[index].date.name
                                          .substring(8, 10) +
                                      " " +
                                      widget.restaurant.reviews[index].date.name
                                          .substring(10).toString(),style: TextStyle(fontSize: width*0.035),),
                                ],
                              )
                            ],
                          ),
                        ),
                        Divider()
                      ],
                    ),
                  );
                },),
              ),
            )
          ],
        ),
      ),
      floatingActionButton:GestureDetector(
        onTap: () {
          openMap(widget.restaurant.latlng.lat, widget.restaurant.latlng.lng);
        },
        child: CircleAvatar(
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
      ),
    );
  }
}
