import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsApp',
      debugShowCheckedModeBanner: false,
      home: FirstPage(),
      routes: {
        SettingScreen.routeName: (_) => SettingScreen(),
        ProfileScreen.routeName: (_) => ProfileScreen(),
      },
      theme: ThemeData.light().copyWith(
        backgroundColor: Colors.white,
        accentColor: Color(0xFF53CD41),
        iconTheme: IconThemeData(
          color: Color(0xFF60BBA7),
        ),
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
    List<String> menuItems = const [
      'New Group',
      'New Broadcast',
      'WhatsApp Web',
      'Starred Messages',
      'Settings'
    ];
    return Scaffold(
      floatingActionButton: myFAB,
      body: new NestedScrollView(
        headerSliverBuilder: (ctx, isScrolled) => [
          SliverAppBar(
            title: Text('WhatsApp'),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.search), onPressed: () {}),
              PopupMenuButton(
                  icon: Icon(Icons.more_vert),
                  onSelected: (s) => s == 'Settings'
                      ? Navigator.of(context).pushNamed(SettingScreen.routeName)
                      : null,
                  itemBuilder: (ctx) => menuItems
                      .map((s) => PopupMenuItem(
                          value: s,
                          child: Text(s,
                              style: TextStyle(
                                  color: s != 'Settings'
                                      ? Colors.grey
                                      : Colors.black))))
                      .toList()),
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

class StatusPage extends StatefulWidget {
  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  List<Widget> unreadStatuses;
  List<Widget> readStatuses;
  @override
  void initState() {
    unreadStatuses = statusGenerator(
      false,
    );
    readStatuses = statusGenerator(true);
    super.initState();
  }

  Widget myListTile(Widget leading, String title, String subtitle) => Container(
      color: Colors.white,
      child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
              leading: leading,
              title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(subtitle))));
  final imgUrl =
      'https://raw.githubusercontent.com/lordvidex/ThirtyDaysOfCode/master/assets/images1.jpg';
  Widget spacer(String text) => Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
        ),
      );
  //dummy status items used for this task serving as server data
  List<Widget> statusGenerator(bool read) => List<Widget>.generate(5, (i) {
        var imageUrl = read
            ? 'https://image.spreadshirtmedia.com/image-server/v1/mp/compositions/T1196A2MPA3058PT17X15Y13D1016302346FS1822/views/1,width=550,height=550,appearanceId=2,backgroundColor=000000,noPt=true,version=1567586010/money-heist-la-casa-de-papel-womens-5050-t-shirt.jpg'
            : 'https://upload.wikimedia.org/wikipedia/en/b/b0/OMG_%28featuring_Quavo%29_%28Official_Single_Cover%29_by_Camila_Cabello.png';
        return myListTile(
            CircleAvatar(
              backgroundColor: !read ? Color(0xFF105E55) : Colors.grey,
              radius: 30,
              child: Container(
                margin: EdgeInsets.all(2),
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                  radius: 25,
                ),
              ),
            ),
            read ? 'The Professor ${i + 1}' : 'Camila Cabello ${i + 1}',
            read ? 'Today 5:4$i PM' : '${(i + 1) * 5} minutes ago');
      });

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.grey[200],
        child: ListView.builder(
          padding: EdgeInsets.all(0),
          itemBuilder: (ctx, index) => index == 0
              ? myListTile(
                  Stack(children: <Widget>[
                    CircleAvatar(
                        radius: 30, backgroundImage: NetworkImage(imgUrl)),
                    Positioned(
                        child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Theme.of(context).accentColor,
                            ),
                            child: Center(
                                child: Icon(Icons.add,
                                    color: Colors.white, size: 15)),
                            alignment: Alignment.center,
                            height: 20,
                            width: 20),
                        bottom: 0,
                        right: 1.0)
                  ]),
                  'My status',
                  'Tap to add status update',
                )
              : index == 1
                  ? spacer('Recent updates')
                  : index >= 2 && index < 2 + unreadStatuses.length
                      ? unreadStatuses[index - 2]
                      : index == 2 + unreadStatuses.length
                          ? spacer('Viewed updates')
                          : readStatuses[index - 3 - unreadStatuses.length],
          itemCount: unreadStatuses.length + readStatuses.length + 3,
        ),
      );
}

class CallsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container();
}

Color iconColor = const Color(0xFF60BBA7);
NetworkImage profileImage = NetworkImage(
    'https://raw.githubusercontent.com/lordvidex/ThirtyDaysOfCode/master/assets/images1.jpg');
String displayName = 'Don', status = 'Only the true alpha...';

class SettingScreen extends StatelessWidget {
  static const routeName = '/settings';
  Widget mySettingListItem(Widget leading, String title,
          {Function f, String subtitle}) =>
      ListTile(
          leading: leading,
          onTap: f,
          title: Text(title),
          subtitle: subtitle != null
              ? Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey),
                )
              : null);
  @override
  Widget build(BuildContext context) {
    List<Widget> settingItems = [
      mySettingListItem(
          CircleAvatar(
            radius: 30,
            backgroundImage: profileImage,
          ),
          displayName,
          f: () => Navigator.of(context).pushNamed(ProfileScreen.routeName),
          subtitle: status),
      Divider(),
      mySettingListItem(Icon(Icons.vpn_key, color: iconColor), 'Account',
          subtitle: 'Privacy, security, change number'),
      mySettingListItem(Icon(Icons.chat, color: iconColor), 'Chats',
          subtitle: 'Theme, wallpapers, chat history'),
      mySettingListItem(
          Icon(Icons.notifications, color: iconColor), 'Notification',
          subtitle: 'Message, group and call tones'),
      mySettingListItem(
          Icon(Icons.data_usage, color: iconColor), 'Data and storage usage',
          subtitle: 'Network usage, auto-download'),
      mySettingListItem(Icon(Icons.help_outline, color: iconColor), 'Help',
          subtitle: 'FAQ, contact us, privacy policy'),
      mySettingListItem(
          Icon(Icons.people, color: iconColor), 'Invite a friend'),
      Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('from'),
              SizedBox(height: 10),
              Text('E   C   X', style: TextStyle(fontWeight: FontWeight.bold))
            ],
          ))
    ];
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView.builder(
        itemBuilder: (ctx, i) => settingItems[i],
        itemCount: settingItems.length,
        padding: const EdgeInsets.all(0),
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class UpdaterWidget extends StatefulWidget {
  final bool isDisplayName;
  final BuildContext context;
  const UpdaterWidget(this.context, this.isDisplayName);
  @override
  _UpdaterWidgetState createState() => _UpdaterWidgetState();
}

class _UpdaterWidgetState extends State<UpdaterWidget> {
  TextEditingController inputController;
  initState() {
    inputController = TextEditingController();
    inputController.text = widget.isDisplayName ? displayName : status;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final x = MediaQuery.of(context).viewInsets.bottom;
    return Container(
        padding: EdgeInsets.only(top: 20,bottom:x+20, left: 8,right:8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                    widget.isDisplayName ? 'Enter your name' : 'Edit About',
                    style: TextStyle(fontWeight: FontWeight.bold))),
            TextFormField(
              controller: inputController,
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.tag_faces, color: Colors.grey)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                    child: Text('CANCEL',style:TextStyle(fontWeight: FontWeight.bold)),
                  textColor: Theme.of(context).primaryColor,
                    onPressed: () => Navigator.of(widget.context).pop()),
                FlatButton(
                    child: Text('SAVE',style:TextStyle(fontWeight: FontWeight.bold)),
                  textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (widget.isDisplayName)
                        displayName = inputController.text;
                      else
                        status = inputController.text;
                      Navigator.of(widget.context).pop();
                    }),
              ],
            )
          ],
        ));
  }
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context);
    void update(isDisplayName) {
      showModalBottomSheet(isScrollControlled: true,
          context: context,
          builder: (ctx) => UpdaterWidget(context, isDisplayName));
      setState(() {});
    }

    Widget myProfileListItem(
            {Widget leading,
            String title,
            bool noIcon = false,
            String subtitle,
            Function onPressed}) =>
        ListTile(
            onTap: onPressed,
            leading: leading,
            trailing: !noIcon ? Icon(Icons.edit, color: Colors.grey) : null,
            title:
                Text(title, style: TextStyle(fontSize: 12, color: Colors.grey))
            ,subtitle: Text(subtitle, style: TextStyle(color: Colors.black)));
    List<Widget> items = [
      Stack(alignment: Alignment.center, children: [
        CircleAvatar(
          minRadius: 40,
          maxRadius: mediaquery.size.width * 0.2,
          backgroundImage: profileImage,
        ),
        Positioned(
            right: mediaquery.size.width * 0.3,
            bottom: 0,
            child: FloatingActionButton(
                mini: true,
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(
                  Icons.camera_alt,
                  //color: Colors.white
                ),
                onPressed: () {}))
      ]),
      myProfileListItem(
          leading: Icon(Icons.person),
          title: 'Name',
          subtitle: displayName,
          onPressed: () => update(true)),
      myProfileListItem(
          leading: Icon(Icons.info_outline),
          title: 'About',
          subtitle: status,
          onPressed: () => update(false)),
      myProfileListItem(
          leading: Icon(Icons.call),
          title: 'Phone',
          noIcon: true,
          subtitle: '+7 953 998 5320'),
    ];
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: ListView.separated(
          itemBuilder: (ctx, i) => items[i],
          separatorBuilder: (ctx, i) =>
              (i == 1 || i == 2) ? Divider() : Container(),
          itemCount: items.length),
    );
  }
}
