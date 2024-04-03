import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:resturant_app/core/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/type_def.dart';
final loginRepositoryProvider=Provider((ref) => LoginRepository());
class LoginRepository{

  FutureVoid loginUser({required String email,required String password}) async {
    try{

      final SharedPreferences local=await SharedPreferences.getInstance();
      local.setString("email", email);
      local.setString("password", password);
      return right("");
    }
    catch(e){
     return left(Failure(e.toString()));
    }
  }
}