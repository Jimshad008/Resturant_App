import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:resturant_app/feature/login/repository/login_repository.dart';
import 'package:resturant_app/feature/home/screen/home_page.dart';

import '../../../core/util.dart';
final loginControllerProvider=Provider((ref) => LoginController(loginRepository: ref.read(loginRepositoryProvider)));
class LoginController{
  final LoginRepository _loginRepository;
  LoginController({required LoginRepository loginRepository}):_loginRepository=loginRepository;
  loginUser({required String email,required String password,required BuildContext context}) async {
    var res=await _loginRepository.loginUser(email: email, password: password);
    res.fold((l) => showSnackBar(context,l.message), (r) {
      Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => const HomePage(),), (route) => false);
      showSnackBar(context,"Login Successfully");
    } );
  }
}