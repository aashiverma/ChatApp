import 'AddNewUser.dart';
import 'package:flutter/material.dart';
import 'chats.dart';

class FinalChatScreen extends StatefulWidget {
  @override
  _FinalChatScreenState createState() => _FinalChatScreenState();
}

class _FinalChatScreenState extends State<FinalChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
            child: Container(
              height: 5.0,
            ),
            preferredSize: Size(MediaQuery.of(context).size.width, 5.0)),
        backgroundColor: Colors.black,
        title: Row(
          children: [
            SizedBox(
              width: 8,
            ),
            Text(
              'Chats',
              style: TextStyle(fontSize: 25),
            ),
          ],
        ),
        actions: <Widget>[
          EaseInWidget(
            onTap: () {
              Navigator.of(context).pushNamed('/camera');
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(10.0),
              child: Icon(
                Icons.camera_alt,
                size: 20.0,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          EaseInWidget(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
              padding: EdgeInsets.all(10.0),
              child: Icon(
                Icons.person_add,
                size: 20,
              ),
            ),
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddNewUser())),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
              child: SearchWidget(),
              color: Colors.black,
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(child: Chats()),
            //   NewMessage(),
          ],
        ),
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/search');
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Color(0xffeeeeee),
            borderRadius: BorderRadius.circular(25.0)),
        padding: EdgeInsets.all(4.0),
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.search, size: 22.0, color: Colors.blueGrey),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0),
              child: Text(
                "Search",
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class EaseInWidget extends StatefulWidget {
  final Widget child;
  final Function onTap;
  const EaseInWidget({Key key, @required this.child, @required this.onTap})
      : super(key: key);
  @override
  State<StatefulWidget> createState() => _EaseInWidgetState();
}

class _EaseInWidgetState extends State<EaseInWidget>
    with TickerProviderStateMixin<EaseInWidget> {
  AnimationController controller;
  Animation<double> easeInAnimation;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 200,
        ),
        value: 1.0);
    easeInAnimation = Tween(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeIn,
      ),
    );
    controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.forward().then((val) {
          controller.reverse().then((val) {
            widget.onTap();
          });
        });
      },
      child: ScaleTransition(
        scale: easeInAnimation,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
