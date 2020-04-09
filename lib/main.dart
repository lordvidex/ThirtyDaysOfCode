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
  Widget myFAB;
  Widget statusFAB;
  Widget fabCode(IconData icon) => FloatingActionButton(
      onPressed: () {},
      child: Icon(
        icon,
        color: Colors.white,
      ));

  @override
  void initState() {
    statusFAB = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FloatingActionButton(
          onPressed: () {},
          heroTag: 1,
          mini: true,
          child: Icon(Icons.edit, color: Color(0xFF105E55)),
          backgroundColor: Colors.grey[100],
        ),
        SizedBox(height: 10),
        FloatingActionButton(
          onPressed: () {},
          heroTag: 2,
          child: Icon(
            Icons.camera_alt,
            color: Colors.white,
          ),
        ),
      ],
    );

    myFAB = statusFAB;
    tabController = TabController(initialIndex: 2, length: 4, vsync: this)
      ..addListener(() {
        setState(() {
          switch (tabController.index) {
            case 0:
              myFAB = null;
              break;
            case 1:
              myFAB = fabCode(Icons.chat);
              break;
            case 2:
              myFAB = statusFAB;
              break;
            case 3:
              myFAB = fabCode(Icons.add_call);
              break;
            default:
              myFAB = null;
          }
        });
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: myFAB,
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
  final imgUrl =
      'https://raw.githubusercontent.com/lordvidex/ThirtyDaysOfCode/master/assets/images1.jpg';
  @override
  Widget build(BuildContext context) => ListView.separated(
      itemCount: 50,
      separatorBuilder: (_, __) => Divider(),
      itemBuilder: (ctx, i) => ListTile(
            leading: GestureDetector(
              onTap: () => showDialog(
                  barrierDismissible: true,
                  context: context,
                  builder: (ctx) => SimpleDialog(
                        title: Text('Friend ${i + 1}'),
                        children: <Widget>[
                          Hero(
                            tag: 'allTheseBonusMarks',
                            child: Image.network(imgUrl),
                          ),
                        ],
                      )),
              child: Hero(
                tag: 'allTheseBonusMarks',
                child: CircleAvatar(
                  backgroundImage: NetworkImage(imgUrl),
                ),
              ),
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
  final imgUrl =
      'https://raw.githubusercontent.com/lordvidex/ThirtyDaysOfCode/master/assets/images1.jpg';
  @override
  Widget build(BuildContext context) => Container(
        color: Colors.grey[300],
        child: ListView.builder(
          padding: EdgeInsets.all(0),
          itemBuilder: (ctx, index) => index == 0
              ? Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: ListTile(
                      leading: Stack(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(imgUrl),
                          ),
                          Positioned(
                            child: Container(
                              alignment: Alignment.center,
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).accentColor,
                              ),
                              child: Center(
                                  child: Icon(Icons.add,
                                      color: Colors.white, size: 15)),
                            ),
                            bottom: 0,
                            right: 1.0,
                          ),
                        ],
                      ),
                      title: Text(
                        'My status',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Tap to add status update',
                        //style: TextStyle(color: Colors.grey)
                      ),
                    ),
                  ),
                )
              : index == 1
                  ? Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        'Recent updates',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                    )
                  : index >= 2 && index < 2 + unreadStatuses.length
                      ? unreadStatuses[index - 2]
                      : Container(),
          itemCount: 8,
        ),
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: <Widget>[
        //     Container(
        //       color: Colors.white,
        //       child: Padding(
        //         padding: const EdgeInsets.all(8),
        //         child: ListTile(
        //           leading: Stack(
        //             children: <Widget>[
        //               CircleAvatar(
        //                 radius: 30,
        //                 backgroundImage: NetworkImage(imgUrl),
        //               ),
        //               Positioned(
        //                 child: Container(alignment: Alignment.center,
        //                   height: 20,
        //                   width: 20,
        //                   decoration: BoxDecoration(
        //                     shape: BoxShape.circle,
        //                     color: Theme.of(context).accentColor,
        //                   ),
        //                   child: Center(child:Icon(Icons.add, color: Colors.white,size: 15)),
        //                 ),
        //                 bottom: 0,
        //                 right: 1.0,
        //               ),
        //             ],
        //           ),
        //           title: Text(
        //             'My status',
        //             style: TextStyle(
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //           subtitle: Text(
        //             'Tap to add status update',
        //             //style: TextStyle(color: Colors.grey)
        //           ),
        //         ),
        //       ),
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.all(8),
        //       child: Text(
        //         'Recent updates',
        //         style:
        //             TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
        //       ),
        //     ),
        //   ],
        // ),
      );
}

//dummy status items used for this task serving as server data
var unreadStatuses = List<Widget>.generate(5, (i) {
  var imageUrl = '';
  return Container(
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Color(0xFF105E55), width: 2),
          ),
          child: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
            radius: 30,
          ),
        ),
        title: Text(
          'Camila Cabello ${i + 1}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          '${(i + 1) * 5} minutes ago',
          //style: TextStyle(color: Colors.grey)
        ),
      ),
    ),
  );
});

class CallsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container();
}
