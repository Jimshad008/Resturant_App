import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:resturant_app/core/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/type_def.dart';
final loginRepositoryProvider=Provider((ref) => LoginRepository());
class LoginRepository{

  FutureVoid loginUser({required String email,required String password,required bool rememberMe}) async {
    try{


      final SharedPreferences local=await SharedPreferences.getInstance();
      String? a=local.getString(email);
      if(a==null){
        local.setString(email, password);
        if(rememberMe){
          local.setString("rememberMe", email);
        }
        return right("");
      }
      else{
        if(a==password){
          if(rememberMe){
            local.setString("rememberMe", email);
          }
          return right("");
        }
        else{
          return left(Failure("Incorrect Password,user already Exist"));
        }
      }

      local.setString(email, password);
      if(rememberMe){
        local.setString("rememberMe", email);
      }

    }
    catch(e){
     return left(Failure(e.toString()));
    }
  }
  FutureVoid logoutUser() async {
    try{
      final SharedPreferences local=await SharedPreferences.getInstance();
      local.remove("rememberMe");
      return right("");
    }catch(e){
      return left(Failure(e.toString()));
    }
  }
  FutureEither<String> forgotPassword({required String email,required bool notARobot})async{
    try{
      if(notARobot){
        final SharedPreferences local=await SharedPreferences.getInstance();
        String? data=local.getString(email);
        if(data!=null){
          return right(data);
        }
        else{
          return left(Failure("Email not Found or incorrect"));
        }

      }
      else{
        return left(Failure("Please Verify Iam not a Robot"));
      }
    }catch(e){
      return left(Failure(e.toString()));
    }
  }
}