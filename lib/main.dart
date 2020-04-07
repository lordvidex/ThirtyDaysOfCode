import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Press Me na',
      debugShowCheckedModeBanner: false,
      home: FirstPage(),
    );
  }
}
class FirstPage extends StatefulWidget{
  _FirstPageState createState()=>_FirstPageState();
}
class _FirstPageState extends State<FirstPage>{
  var x = 0;
   List<Color> colors = const [
                 Color(0xFF0D47A1),
                 Color(0xFF1976D2),
                 Color(0xFF42A5F5),
      ];
  List<Color> reverse,color;
  initState(){
    color = colors;
    reverse = colors.reversed.toList();
    super.initState();
  }
  @override
  Widget build(BuildContext context){
    Widget myButton(){
      return InkWell(
        borderRadius: BorderRadius.circular(30),
           onHover: (yes)=>setState((){
             color = yes?reverse:colors;
           
           }),
           onTap: (){
            //visual app feedback
          setState((){x++;});
            //Output to console
        print('Button Pressed $x times');
      },
          child: Container(
        padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: color),
          borderRadius: BorderRadius.circular(30),
        ),
         child:Text('Press Me'),
         ),    
     );
    }
    return Scaffold(
      appBar: AppBar(title:Text('Simple Presser'),),
      body:Center(child: SingleChildScrollView(child: Column(children:[
        Text('Button Pressed $x times'),
        SizedBox(height: 20),
        myButton(),
      ])),
    ));
  }
}