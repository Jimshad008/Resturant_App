import 'package:flutter/material.dart';

import 'constant/global_constants.dart';


class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    width=MediaQuery.of(context).size.width;
    height=MediaQuery.of(context).size.height;
    return  Center(
      child:CircularProgressIndicator()
    );
  }
}
