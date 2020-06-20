import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:kanban/utils/margin.dart';
import 'package:kanban/utils/theme.dart';

import 'board.dart';
import 'job.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldkey,
      drawer: Drawer(),
      body: Container(
        child: Row(
          children: <Widget>[
            Container(
              color: white,
              child: Column(
                children: [
                  Expanded(
                    child: NavigationRail(
                      backgroundColor: white,
                      selectedIndex: _selectedIndex,
                      onDestinationSelected: (int index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      leading: Column(
                        children: [
                          const YMargin(30),
                          Container(
                            child: IconButton(
                              icon: Icon(
                                FeatherIcons.menu,
                                size: 19,
                                color: Colors.grey[800],
                              ),
                              onPressed: () {
                                _scaffoldkey.currentState.openDrawer();
                              },
                            ),
                            margin: EdgeInsets.only(bottom: 18),
                          ),
                        ],
                      ),
                      labelType: NavigationRailLabelType.none,
                      selectedIconTheme: IconThemeData(size: 19),
                      unselectedIconTheme: IconThemeData(
                        size: 19,
                        color: Colors.grey[500],
                      ),
                      destinations: [
                        NavigationRailDestination(
                          icon: Icon(
                            FeatherIcons.layout,
                          ),
                          label: Text(''),
                        ),
                        NavigationRailDestination(
                          icon: Icon(FeatherIcons.briefcase),
                          label: Text(''),
                        ),
                        NavigationRailDestination(
                          icon: Icon(FeatherIcons.bell),
                          label: Text(''),
                        ),
                        NavigationRailDestination(
                          icon: Icon(FeatherIcons.user),
                          label: Text(''),
                        ),
                        NavigationRailDestination(
                          icon: Icon(FeatherIcons.settings),
                          label: Text(''),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey[200],
                        borderRadius: BorderRadius.circular(3),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                'https://pbs.twimg.com/profile_images/1274197880635621376/ZCJygPAs_400x400.jpg'))),
                  ),
                  const YMargin(20),
                ],
              ),
            ),
            Flexible(
                flex: 0,
                child: Container(
                  width: 0.8,
                  color: grey.withOpacity(.2),
                )),
            Flexible(
              flex: 1,
              child: JobSection(),
            ),
            Flexible(
                flex: 0,
                child: Container(
                  width: 0.8,
                  color: grey.withOpacity(.2),
                )),
            Flexible(
              flex: 3,
              child: BoardSection(),
            ),
          ],
        ),
      ),
    );
  }
}

