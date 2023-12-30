import 'package:flutter/material.dart';
import 'package:moses/documentationInfo/themeData.dart';

class SeekersMessaging extends StatefulWidget {
  const SeekersMessaging({Key? key}) : super(key: key);

  @override
  State<SeekersMessaging> createState() => _SeekersMessagingState();
}

class _SeekersMessagingState extends State<SeekersMessaging> {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    //List is temporarily hardcoded.
    //List needs to load list of advertisements from database.
    List testList = [1,2,3];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seekers'),
        backgroundColor: ThemeColors().seekersTheme,
        actions: <Widget> [
          Container(
              padding: const EdgeInsets.all(5),
              child: Image.asset('assets/images/seekers_logo.png')
          )
        ],
      ),

      body: Center(
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: ListView.builder(
              itemBuilder: (_, index) {
                //For now, the card it hardcoded.
                //When testList actually loads data from database, card should be designed.
                //It needs an image and a route.
                return Container(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Card(
                    child: InkWell(
                      onTap: () {},
                      child: SizedBox(          //1:6 ratio
                          height: width * 0.15,   //15% width
                          width: width * 0.90,    //90% width
                          child: Center(child: Text('Test add $index'))
                      ),
                    ),
                  ),
                );
              },
              itemCount: testList.length,
            ),
          )
      ),
    );
  }
}