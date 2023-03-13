import 'package:flutter/material.dart';
import 'package:moses/documentationInfo/temporaryTestData.dart';

class MinistryLoginSelection extends StatefulWidget {
  const MinistryLoginSelection({Key? key}) : super(key: key);

  @override
  State<MinistryLoginSelection> createState() => _MinistryLoginSelectionState();
}

class _MinistryLoginSelectionState extends State<MinistryLoginSelection> {

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    //For now, this page uses a hardcoded list: testPrograms
    //This page needs to load the list of ministries from the database.

    return Scaffold(
      appBar: AppBar(
        title: const Text('Landmark Baptist Church'),
        actions: <Widget> [
          Container(
              padding: const EdgeInsets.all(5),
              child: Image.asset('assets/images/lbc_logo_outlined.png')
          )
        ],
      ),

      body: Center(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: ListView.builder(
            itemBuilder: (_, index) {
              return Container(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  children: [
                    SizedBox(
                      width: (width-80)/3,
                      height: (width-80)/3,
                      child: Card(
                        child: InkWell(
                          onTap: () { //Temporary testing navigation
                            Navigator.pushNamed(context, '/seekersHomePage');
                          },
                          child: Center(child: Text(testPrograms[3*index].title)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20,),
                    SizedBox(
                      width: (width-80)/3,
                      height: (width-80)/3,
                      child: 3*index+1 >= testPrograms.length ? null: Card(
                        child: InkWell(
                          onTap: () { //Temporary testing navigation
                            Navigator.pushNamed(context, '/seekersHomePage');
                          },
                          child: Center(child: Text(testPrograms[3*index+1].title)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20,),
                    SizedBox(
                      width: (width-80)/3,
                      height: (width-80)/3,
                      child: 3*index+2 >= testPrograms.length ? null: Card(
                        child: InkWell(
                          onTap: () { //Temporary testing navigation
                            if(testPrograms[3*index+2].title == "Administration") {
                              Navigator.pushNamed(context, '/login');
                            } else {
                              Navigator.pushNamed(context, '/seekersHomePage');
                            }
                          },
                          child: Center(child: Text(testPrograms[3*index+2].title)),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: (testPrograms.length+2)~/3,
          ),
        )
      ),
    );
  }
}