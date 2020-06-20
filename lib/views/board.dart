import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kanban/models/people.dart';
import 'package:kanban/utils/fa_progress.dart';
import 'package:kanban/utils/margin.dart';
import 'package:kanban/utils/theme.dart';

class BoardSection extends StatefulWidget {
  @override
  _BoardSectionState createState() => _BoardSectionState();
}

class _BoardSectionState extends State<BoardSection> {
  List<People> people1;
  List<People> people2;
  var people = [
    People(
        name: 'Greta Abbott',
        job: 'Cloud Engineer',
        lang: ['AWS', 'Cloudinary', 'Engineer']),
    People(
        name: 'Lou Stanton',
        job: 'Senior Cloud Engineer',
        m: true,
        lang: ['Java', 'Swift', 'Developer']),
    People(
        name: 'Kellie Brekke',
        job: 'Cloud Team Lead',
        lang: ['AWS', 'Engineer', 'Azure']),
    People(
        name: 'Arnold Bergstrom',
        job: 'Junior Cloud Engineer',
        m: true,
        lang: ['AWS', 'Azure', 'Cloud']),
    People(
        name: 'John Doe',
        job: 'Senior Cloud Engineer',
        m: true,
        lang: ['Azure', 'AWS', 'GCP']),
    People(
        name: 'Kyra Lang',
        job: 'Cloud Team Lead',
        lang: ['Engineer', 'GCP', 'Azure']),
  ];
  @override
  void initState() {
    setState(() {
      people.shuffle();
      people1 = people.sublist(0, 3);
      people.shuffle();
      people2 = people.sublist(0, 2);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const YMargin(40),
        Row(
          children: [
            const XMargin(30),
            Text(
              'Cloud Engineering',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
          ],
        ),
        const YMargin(10),
        Row(
          children: [
            const XMargin(30),
            Text(
              'Your Kanban',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: darkGrey.withOpacity(0.3),
                fontSize: 13,
              ),
            ),
          ],
        ),
        const YMargin(26),
        Flexible(
          flex: 0,
          child: Container(
            height: 0.8,
            color: grey.withOpacity(.2),
          ),
        ),
        Expanded(
          child: Row(
            children: [
              BoardItem(
                list: people,
                color: Color(0xff7387eb),
                icon: FeatherIcons.star,
                title: 'New',
              ),
              BoardItem(
                list: people1,
                color: Color(0xfffe7e22),
                icon: FeatherIcons.checkSquare,
                title: 'Shortlisted',
              ),
              BoardItem(
                list: people2,
                color: Color(0xff48d0d0),
                icon: FeatherIcons.userCheck,
                title: 'Approved',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BoardItem extends StatefulWidget {
  const BoardItem({
    Key key,
    @required this.list,
    @required this.color,
    @required this.title,
    @required this.icon,
  }) : super(key: key);

  final List<People> list;
  final Color color;
  final String title;
  final IconData icon;

  @override
  _BoardItemState createState() => _BoardItemState(this.list);
}

class _BoardItemState extends State<BoardItem> {
  _BoardItemState(this.list);
  List<People> list;

  void _onReorder(int oldIndex, int newIndex) {
    setState(
      () {
        if (newIndex > oldIndex) {
          newIndex -= 1;
        }
        final People item = list.removeAt(oldIndex);
        list.insert(newIndex, item);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Spacer(),
        Container(
          height: 40,
          margin: EdgeInsets.only(left: 30),
          width: context.screenWidth(.2),
          child: FAProgressBar(
            direction: Axis.horizontal,
            currentValue: 45.nextMax(100).floor(),
            displayWidget: Row(
              children: [
                const XMargin(10),
                Icon(
                  widget.icon,
                  color: white,
                  size: 17,
                ),
                const XMargin(10),
                Text(
                  widget?.title ?? '',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.ubuntu(
                      textStyle: TextStyle(
                          color: white,
                          fontWeight: FontWeight.w600,
                          fontSize: 11)),
                )
              ],
            ),
            progressColor: widget.color,
            backgroundColor: widget.color.withOpacity(0.2),
          ),
        ),
        Row(
          // scrollDirection: Axis.horizontal,
          children: [
            Container(
              height: context.screenHeight(.75),
              width: context.screenWidth(.2),
              margin: EdgeInsets.fromLTRB(30, 30, 0, 0),
              decoration: BoxDecoration(
                color: Color(0xfff0f2f5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: ReorderableListView(
                onReorder: _onReorder,
                scrollController: ScrollController(),
                // buildDraggableFeedback: (a, b, c) => Container(),
                children: List.generate(
                  widget.list.length,
                  (index) {
                    return ListViewCard(
                      widget.list[index],
                      index,
                      Key('$index'),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ListViewCard extends StatefulWidget {
  final int index;
  final Key key;
  final People person;

  ListViewCard(this.person, this.index, this.key);

  @override
  _ListViewCard createState() => _ListViewCard();
}

class _ListViewCard extends State<ListViewCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 18, 15, 0),
      padding: EdgeInsets.all(16),
      width: context.screenWidth(.3),
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(9),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.2),
              blurRadius: 10,
            )
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: context.screenWidth(.03),
                height: context.screenWidth(.03),
                decoration: BoxDecoration(
                    color: Colors.blueGrey[200],
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://randomuser.me/api/portraits/${widget.person.m ? 'men' : 'women'}/${widget.index}.jpg'))),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 9),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: context.screenWidth(.082),
                      child: Text(
                        widget?.person?.name ?? '',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.ubuntu(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 12)),
                      ),
                    ),
                    const YMargin(5),
                    Container(
                      width: context.screenWidth(.06),
                      child: Text(widget?.person?.job ?? '',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 10,
                            color: Colors.grey[400],
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const YMargin(15),
          Container(
            height: 20,
            width: 200,
            child: ListView(
              padding: EdgeInsets.all(0),
              scrollDirection: Axis.horizontal,
              children: [
                for (var min in widget?.person?.lang ?? [])
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                    margin: EdgeInsets.only(right: 6),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(min ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 10,
                            color: Colors.grey[400],
                          )),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

extension Num on num {
  double nextMax(num max) {
    return this + (max - this) * Random().nextDouble();
  }
}
