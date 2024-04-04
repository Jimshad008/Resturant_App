import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class ExpandText extends StatefulWidget {
 final  String word;
  const ExpandText({super.key,required this.word});

  @override
  State<ExpandText> createState() => _ExpandTextState();
}

class _ExpandTextState extends State<ExpandText> {
  final isExpandableProvider=StateProvider((ref) => false);
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Consumer(
      builder: (context,ref,child) {
        final isExpanded=ref.watch(isExpandableProvider);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
             widget. word,

              maxLines: isExpanded ? 100 : 3, // Initially show 3 lines
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: width*0.04),
            ),
            SizedBox(height: 5.0),
            SizedBox(

              child: Padding(
                padding:  EdgeInsets.only(right: width*0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        ref.read(isExpandableProvider.notifier).update((state) => !state);
                      },
                      child: Text(
                        isExpanded ?'Read less...': 'Read more..'  ,
                        style: TextStyle(
                          fontSize: width*0.035,
                          decoration: TextDecoration.underline,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}
