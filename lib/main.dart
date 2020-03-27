import 'package:flutter/material.dart';

void main() {
  runApp(MyApps());
}

class MyApps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
        routes: {
          '/login': (_) => LoginPage(),
          '/welcome': (_) => WelcomePage(),
        });
  }
}

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.blue[300],
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Text('You are logged in!'),
          )),
    );
  }
}

Widget button(Function f, double width) {
  return SizedBox(
    width: width,
    height: 50,
    child: GestureDetector(
      onTap: f,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue[900],
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Text(
            'Log In',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.blue[300],
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: (mediaquery.height * 0.2),
              horizontal: (mediaquery.width * 0.2)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'HELLO',
                  style: Theme.of(context).textTheme.display1.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 70,
                      ),
                ),
              ),
              button(
                () => Navigator.of(context).pushNamed('/login'),
                mediaquery.width - 42,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController;
  TextEditingController _passController;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _emailController = TextEditingController();
    _passController = TextEditingController();
    super.initState();
  }

  Widget textItem({
    String label,
    bool isPassword = false,
    bool isEmail = false,
    TextEditingController ctrl,
  }) {
    return TextFormField(
      validator: (string) {
        if (string.length < 4) {
          return 'Value is too short!';
        }
        if (isEmail && !string.contains(new RegExp(r'(.+@.+\..+)'))) {
          return 'Invalid Email address!';
        }
        return null;
      },
      controller: ctrl,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        fillColor: Colors.grey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context).size;

    return Form(
      key: _formKey,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue[300],
                Colors.white,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: (mediaquery.height * 0.2),
                horizontal: (mediaquery.width * 0.2)),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20),
                  textItem(
                      isEmail: true, label: 'Email', ctrl: _emailController),
                  SizedBox(height: 30),
                  textItem(
                      isPassword: true,
                      label: 'Password',
                      ctrl: _passController),
                  SizedBox(height: 30),
                  button(
                    () {
                      if (!_formKey.currentState.validate()) return;
                      Navigator.of(context).pushReplacementNamed('/welcome');
                    },
                    mediaquery.width - 42,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
