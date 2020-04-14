import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ECX',
      debugShowCheckedModeBanner: false,
      home: FirstPage(),
      routes:{
        NewPage.routeName:(_)=>NewPage(),
      },
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(color: Colors.blue),
        backgroundColor: Colors.blue[300],
        accentColor: Colors.red[300],
        scaffoldBackgroundColor: Colors.blue[300],
        primaryColor: Colors.yellow[300],
      ),
    );
  }
}

List tracks = [
  'Android Development',
  'Web FrontEnd',
  'Web BackEnd',
  'Python Development',
  'UI/UX Design',
  'Engineering Design',
  'Soft Skills',
];

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  String selectedTrack;
  String date;
  GlobalKey<FormState> _formKey;

  initState() {
    _formKey = GlobalKey<FormState>();
    selectedTrack = tracks[0];
    var x = DateTime.now();
    date = '${x.hour}:${x.minute}:${x.second} ${x.day}/${x.month}/${x.year}';
    super.initState();
  }

  void validateForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    Navigator.of(context).pushNamed(NewPage.routeName);
  }

  Widget myTextField(
      {String label, bool isDropDown = false, Function(String) valid}) {
    return Row(children: <Widget>[
      Expanded(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
              child: isDropDown
                  ? InputDecorator(
                      child: DropdownButton(
                        isExpanded: true,
                        value: selectedTrack,
                        items: tracks
                            .map((x) => DropdownMenuItem<String>(
                                child: Text(x), value: x))
                            .toList(),
                        onChanged: (x) => setState(() {
                          selectedTrack = x;
                        }),
                      ),
                      decoration: InputDecoration(
                        hintText: label,
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                    )
                  : TextFormField(
                      validator: valid,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        labelText: label,
                        labelStyle: TextStyle(color: Colors.blue[200]),
                        filled: true,
                        alignLabelWithHint: true,
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.yellow[200], width: 5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ))))
    ]);
  }

  Widget myButton(String text, Function validator) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: GestureDetector(
                  onTap: validator,
                  //borderRadius: BorderRadius.circular(20),
                  child: Container(
                    alignment: Alignment.center,
                    constraints: BoxConstraints(minHeight: 50),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.red[300]),
                    child: Text(text,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold)),
                  ))),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(children: <Widget>[
        Container(
            height: mediaquery.height * 0.3,
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: 'E ', style: TextStyle(color: Colors.blue[200])),
                    TextSpan(
                        text: 'C ',
                        style: TextStyle(color: Colors.yellow[200])),
                    TextSpan(
                        text: 'X', style: TextStyle(color: Colors.red[200])),
                  ]),
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(90)))),
        Expanded(
            child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: SingleChildScrollView(
                    child: Form(
                  key: _formKey,
                  child: Column(children: <Widget>[
                    myTextField(
                        label: 'Enter your Email address',
                        valid: (s) {
                          if (RegExp(r'\S+@+\S+\.+\S+').stringMatch(s) != s)
                            return 'Invalid Email address';
                          return null;
                        }),
                    SizedBox(height: 20),
                    myTextField(
                        label: 'Enter Matric No',
                        valid: (s) {
                          if (s.length != 9 || s.contains(new RegExp(r'\D')))
                            return 'Invalid Matric number';
                          return null;
                        }),
                    SizedBox(height: 20),
                    myTextField(label: 'Select Track', isDropDown: true),
                    SizedBox(height: 20),
                    Row(children: <Widget>[
                      Expanded(
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              child: InputDecorator(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                ),
                                child: Text('Date Submitted: $date',
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      color: Colors.red[200],
                                    )),
                              )))
                    ]),
                    SizedBox(height: 20),
                    myButton('Submit Attendance', validateForm),
                  ]),
                )))),
      ]),
    );
  }
}
class NewPage extends StatelessWidget{
  static const routeName = '/new';
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(title: Text('Confirmation Page')
      ),
      body: Center(child: Text('Attendance Submitted!',style: Theme.of(context).textTheme.headline2))
    );
  }
}