import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:resturant_app/feature/login/controller/loginController.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }
  final notRobotProvider=StateProvider((ref) => false);
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController userName=TextEditingController();
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.orange,
        title: Text("Forgot Password?",style: TextStyle(fontWeight:FontWeight.bold,fontSize: width*0.05,color: Colors.white),),
      ),
      body: Center(
        child: Container(
          width: width*0.9,
          height: height*0.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width*0.05),
               border: Border.all(color: Colors.orange,width: 2)
          ),
          child:Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: width*0.8,
                      height: height*0.08,
                      child: TextFormField(

                        cursorColor: Colors.orange,
                        autofillHints: const [AutofillHints.name],
                        validator: (value) {
                          return  validateEmail(value);
                        },
                        controller: userName,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Username/Email',
                          labelStyle: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: const Color(0xFF57636C),
                            fontSize: width*0.035,
                            fontWeight: FontWeight.normal,
                          ),
                          hintText: 'Please Enter Username/Email',
                          hintStyle: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: const Color(0xFF57636C),
                            fontSize: width*0.035,
                            fontWeight: FontWeight.normal,
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.orange,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.orange,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.orange,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color:Colors.orange,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.only(top: height*0.015,left: width*0.05),
                        ),
                        style:TextStyle(
                          fontFamily: 'Lexend Deca',
                          color: const Color(0xFF1D2429),
                          fontSize: width*0.035,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    SizedBox(height: height*0.01,),
                    SizedBox(
                      width: width*0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Consumer(
                              builder: (context,ref,child) {
                                final notARobot=ref.watch(notRobotProvider);
                                return SizedBox(
                                  width: width*0.06,
                                  height: height*0.02,
                                  child: Checkbox(
                                    side: const BorderSide(color: Colors.orange,width: 2),


                                    value: notARobot,
                                    onChanged: (value) {
                                      ref.read(notRobotProvider.notifier).update((state) => !state);
                                      // Do something when checkbox value changes
                                    },
                                  ),
                                );
                              }
                          ),
                          SizedBox(width: width*0.025,),
                          Text("Iam not a Robot.",style: TextStyle(fontSize: width*0.04),)
                        ],
                      ),
                    ),
                  ],
                ),

                Consumer(
                  builder: (context,ref,child) {
                    final notARobot=ref.watch(notRobotProvider);
                    return GestureDetector(
                       onTap: () {
                         if (_formKey.currentState!.validate()) {
                           ref.read(loginControllerProvider).forgotPassword(email: userName.text.trim(), notARobot: notARobot, context: context, width: width, height: height);
                         }
                       },
                      child: Container(
                        width: width*0.7,
                        height: height*0.06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width*0.02),
                          color: Colors.orange,
                        ),
                        child: Center(child: Text("Submit",style: TextStyle(fontSize: width*0.05,color: Colors.white,fontWeight: FontWeight.bold),)),

                      ),
                    );
                  }
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
