import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:resturant_app/feature/home/screen/home_page.dart';
import 'package:resturant_app/feature/login/screen/loginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Grand Marche',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key,});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
getUser() async {
  final SharedPreferences local=await SharedPreferences.getInstance();
  final email=local.get("email");
  if(email!=null){
    Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => HomePage(),), (route) => false);

  }
  else{
    Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => LoginScreen(),), (route) => false);
  }
}
@override
  void initState() {
Future.delayed(Duration(seconds: 2)).then((value) {
  getUser();
});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;

    return Scaffold(

      body: Center(
        child: SizedBox(
          width: width*0.8,
            height:height*0.5,
            child: Image.asset("assets/appLogo.png")),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
