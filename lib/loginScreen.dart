import 'package:flutter/material.dart';
import 'birthday_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff111328),
      body: SingleChildScrollView(
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Container(
                    height: 600,
                    width: 300,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://raw.githubusercontent.com/bhuvabhavik/MY-BUSINESS-CARD-APP/master/images/background.jpg'),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formkey,
                  child: TextFormField(
                    validator: (value) {
                      if (value == '800900')
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BirthdayPage()));
                      else
                        return 'Sorry, key cant match, kindly rectify it';
                    },
                    style: const TextStyle(color: Colors.white),
                    obscureText: true,
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.red,
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      iconColor: Colors.white,
                      label: Text('Enter Your Key'),
                      labelStyle: TextStyle(
                          color: Colors.white60,
                          fontSize: 20,
                          letterSpacing: 2),
                      helperText: 'Enter key here',
                      helperStyle: TextStyle(color: Colors.white54),
                      isCollapsed: false,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.lightGreenAccent),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusColor: Color(0xff312BADFF),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      prefixIcon: Icon(
                        Icons.vpn_key,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  validate();
                },
                child: Container(
                    color: Color(0xff1e1d33),
                    height: 70,
                    width: double.infinity,
                    child: const Center(
                      child: Text(
                        'Take me In',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void validate() {
    if (formkey.currentState!.validate()) {
      print('validated');
    } else {
      print('not validated');
    }
  }
}
