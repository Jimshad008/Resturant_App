import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:resturant_app/core/util.dart';
import 'package:resturant_app/feature/login/controller/loginController.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final passwordVisibilityProvider=StateProvider((ref) => false);
  final rememberMeProvider=StateProvider((ref) => false);
  final TextEditingController userName=TextEditingController();
  final TextEditingController passWord=TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    // Perform custom password validation here
    if (value.length < 8) {
      return "Password must be at least 8 characters long";
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return "Password must contain at least one uppercase letter";
    }
    if (!value.contains(RegExp(r'[a-z]'))) {
      return "Password must contain at least one lowercase letter";
    }
    if (!value.contains(RegExp(r'[0-9]'))) {
      return "Password must contain at least one numeric character";
    }
    if (!value.contains(RegExp(r'[!@#$%^&*()<>?/|}{~:]'))) {
      return "Password must contain at least one special character";
    }
    return null; // Password is valid.
  }
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
  getLogin(WidgetRef ref){
    if(userName.text.trim().isNotEmpty&&passWord.text.trim().isNotEmpty){
      ref.read(loginControllerProvider).loginUser(email: userName.text.trim(), password: passWord.text.trim(), context: context);

    }
    else{
      userName.text.trim().isEmpty?
      showSnackBar(context,"Please Enter Username/Email" ): showSnackBar(context,"Please Enter Password" );
    }
  }
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:  EdgeInsets.all(width*0.1),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height*0.08,),
                SizedBox(
                  width: width*0.8,
                    height: height*0.3,
                    child: Image.asset("assets/loginImage.png")),
                SizedBox(height: height*0.025,),
                Text("Log in",style: TextStyle(fontSize: width*0.065,fontWeight: FontWeight.bold),),
                Text("your account",style: TextStyle(fontSize: width*0.065,fontWeight: FontWeight.bold)),
                SizedBox(height: height*0.015,),
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
                SizedBox(height: height*0.025,),
                Consumer(
                  builder: (context,ref,child) {
                    final passwordVisibility=ref.watch(passwordVisibilityProvider);
                    return SizedBox(
                      width: width*0.8,
                      height: height*0.08,
                      child: TextFormField(
                        cursorColor: Colors.orange,
                        autofillHints: const [AutofillHints.password],
                        controller: passWord,
                        validator: (value) {
                          return validatePassword(value);
                        },
                        obscureText: !passwordVisibility,

                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(
                            fontFamily: 'Lexend Deca',
                            color: const Color(0xFF57636C),
                            fontSize:width*0.035,
                            fontWeight: FontWeight.normal,
                          ),
                          hintText: 'Please Enter Password',
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
                              color:Colors.orange,
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
                              color: Colors.orange,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                         contentPadding: EdgeInsets.only(top: height*0.015,left: width*0.05),
                          suffixIcon: InkWell(
                            onTap: () {
                              ref.read(passwordVisibilityProvider.notifier).update((state) => !state);
                            },
                            focusNode: FocusNode(skipTraversal: true),
                            child: Icon(
                              passwordVisibility
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: const Color(0xFF757575),
                              size: width*0.04,
                            ),
                          ),
                        ),
                        style:TextStyle(
                          fontFamily: 'Lexend Deca',
                          color: const Color(0xFF1D2429),
                          fontSize:width*0.035,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    );
                  }
                ),
                SizedBox(height: height*0.01,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Consumer(
                          builder: (context,ref,child) {
                            final rememberMe=ref.watch(rememberMeProvider);
                            return SizedBox(
                              width: width*0.06,
                              height: height*0.02,
                              child: Transform.scale(
                                scale: 0.7,

                                child: Checkbox(


                                  value: rememberMe,
                                  onChanged: (value) {
                                    ref.read(rememberMeProvider.notifier).update((state) => !state);
                                    // Do something when checkbox value changes
                                  },
                                ),
                              ),
                            );
                          }
                        ),
                        Text("Remember me",style: TextStyle(fontSize: width*0.03),)
                      ],
                    ),
                    Text("Forgot Password?",style: TextStyle(fontSize: width*0.03,fontWeight: FontWeight.bold,color: Colors.blue.shade900))
                  ],
                ),
                SizedBox(height: height*0.1,),
                Consumer(
                  builder: (context,ref,child) {
                    return GestureDetector(
                      onTap: () {
    if (_formKey.currentState!.validate()) {
      getLogin(ref);
    }
                      },
                      child: Container(
                        width: width*0.8,
                        height: height*0.06,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width*0.02),
                          color: Colors.orange,
                        ),
                        child: Center(child: Text("Login",style: TextStyle(fontSize: width*0.05,color: Colors.white,fontWeight: FontWeight.bold),)),

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
