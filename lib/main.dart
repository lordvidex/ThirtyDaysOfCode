import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsApp',
      debugShowCheckedModeBanner: false,
      home: FirstPage(),
      theme: ThemeData.light().copyWith(
        backgroundColor: Colors.white,
        accentColor: Color(0xFF53CD41),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF53CD41),
        ),
        primaryColor: Color(0xFF105E55),
      ),
    );
  }
}

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> with TickerProviderStateMixin {
  TabController tabController;
  @override
  void initState() {
    tabController = TabController(initialIndex: 1, length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(
            Icons.chat,
            color: Colors.white,
          )),
      body: new NestedScrollView(
        headerSliverBuilder: (ctx, isScrolled) => [
          SliverAppBar(
            title: Text('WhatsApp'),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.search), onPressed: () {}),
              IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
            ],
            floating: true,
            pinned: true,
            forceElevated: isScrolled,
            bottom: TabBar(
              controller: tabController,
              indicatorWeight: 4.0,
              indicatorColor: Colors.white,
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
              tabs: <Widget>[
                Tab(icon: Icon(Icons.camera_alt)),
                Tab(text: 'CHATS'),
                Tab(text: 'STATUS'),
                Tab(text: 'CALLS'),
              ],
            ),
          ),
        ],
        body: TabBarView(
          controller: tabController,
          children: <Widget>[
            CameraPage(),
            ChatPage(),
            StatusPage(),
            CallsPage(),
          ],
        ),
      ),
    );
  }
}

class CameraPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(child: Icon(Icons.camera_alt));
}

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ListView.separated(
    itemCount: 50,
    separatorBuilder: (_,__)=>Divider(),
      itemBuilder: (ctx, i) => ListTile(
            leading: CircleAvatar(
                //backgroundImage: NetworkImage(''),

                ),
            title: Text('Friend ${i + 1}',
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle:
                Text('Call me at 9:00', style: TextStyle(color: Colors.grey)),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('2:30PM', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ));
}

class StatusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container();
}

class CallsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container();
}
