import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:resturant_app/feature/login/repository/login_repository.dart';
import 'package:resturant_app/feature/home/screen/home_page.dart';
import 'package:resturant_app/feature/login/screen/loginScreen.dart';
import 'package:scratcher/widgets.dart';

import '../../../core/util.dart';
final loginControllerProvider=Provider((ref) => LoginController(loginRepository: ref.read(loginRepositoryProvider)));
class LoginController{
  final LoginRepository _loginRepository;
  LoginController({required LoginRepository loginRepository}):_loginRepository=loginRepository;
  loginUser({required String email,required String password,required BuildContext context,required bool rememberMe}) async {
    var res=await _loginRepository.loginUser(email: email, password: password,rememberMe: rememberMe);
    res.fold((l) => showSnackBar(context,l.message), (r) {
      Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => const HomePage(),), (route) => false);
      showSnackBar(context,"Login Successfully");
    } );
  }
  logoutUser({required BuildContext context}) async {
    var res=await _loginRepository.logoutUser();
    res.fold((l) => showSnackBar(context,l.message), (r) {
      Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => const LoginScreen(),), (route) => false);
      showSnackBar(context,"Logout Successfully");
    } );
  }
  forgotPassword({required String email,required bool notARobot,required BuildContext context,required double width,required double height})async{
    var res=await _loginRepository.forgotPassword(email: email, notARobot: notARobot);
    res.fold((l) => showSnackBar(context,l.message), (r) {



     showDialog(context: context, builder: (context) => AlertDialog(

       title: const Text('Your Password!',),
       content: Column(
         mainAxisSize: MainAxisSize.min,
         children: [
           const Text("Please Scratch for your Password:"),
           SizedBox(height: height*0.01,),
           Scratcher(
             brushSize: width*0.02,
             threshold: width*0.025,
             color: Colors.grey,

             child: Container(
               height: height*0.08,
               width: width*0.8,
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(width*0.02),
                 color: Colors.orange

               ),
               child:Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: [
                   Text(
                     r,style: TextStyle(fontSize: width*0.04,color: Colors.white,fontWeight: FontWeight.bold),
                   ),
                   GestureDetector(onTap: () {
                     Clipboard.setData(ClipboardData(text: r));
                   },child: Icon(Icons.copy,color: Colors.white,size: width*0.06,))
                 ],
               ) ,
             ),
           )
         ],
       ),
     ) ,);

    } );
  }
}