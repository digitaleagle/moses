import 'package:flutter/material.dart';
import 'themeData.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool isError = false;
  bool hidePass = true;
  String message = 'Either your user name or password is incorrect';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
          //backgroundColor: ThemeColors().primary,
        ),

        body: Center(
            child: Column(
              children: [
                Visibility(
                  visible: isError,
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                      child: Text(message, style: const TextStyle(
                          color: Colors.red, fontSize: 14),
                      )
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                  child: TextField(
                    cursorColor: ThemeColors().secondary,
                    obscureText: false,
                    controller: user,
                    decoration: InputDecoration(
                      floatingLabelStyle: TextStyle(color: ThemeColors().secondary),
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: ThemeColors().secondary)
                      ),
                      labelText: 'User Name',
                    ),
                    onChanged: (newValue) {
                      setState(() {});
                      isError = false;
                    },
                    onSubmitted: (value) {
                      authorization();
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Row(
                    children: [
                      Flexible(
                        child: TextField(
                          cursorColor: ThemeColors().secondary,
                          obscureText: hidePass,
                          controller: pass,
                          decoration: InputDecoration(
                            floatingLabelStyle: TextStyle(color: ThemeColors().secondary),
                            border: const OutlineInputBorder(),
                             focusedBorder: OutlineInputBorder(
                                 borderSide: BorderSide(color: ThemeColors().secondary)
                             ),
                            labelText: 'Password',
                          ),
                          onChanged: (newValue) {
                            setState(() {});
                            isError = false;
                          },
                          onSubmitted: (value) {
                            authorization();
                          },
                        ),
                      ),
                      const SizedBox(width: 5,),
                      IconButton(
                        icon: Icon(hidePass ? Icons.visibility: Icons.visibility_off, color: ThemeColors().primary,),
                        onPressed: () {
                          setState(() {
                            if(hidePass) {
                              hidePass = false;
                            } else {
                              hidePass = true;
                            }
                          });
                        },
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 30, 10, 30),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: ThemeColors().primary),
                    onPressed: authorization,
                    child: const Text('Submit'),
                  ),
                ),
              ],
            )
        )
    );
  }

  void authorization() {

    //Needs to contact API for real validation.
    String testUser = 'user';
    String testPass = 'password';


    if(user.text == testUser && pass.text == testPass) {
      Navigator.pushNamed(context, '/homePage').then((value) => setState(() {user.text = ''; pass.text = '';}));
    } else {
      setState(() {
        isError = true;
      });
    }
  }
}