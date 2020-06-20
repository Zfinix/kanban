import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kanban/models/job.dart';
import 'package:kanban/utils/margin.dart';
import 'package:kanban/utils/theme.dart';

class JobSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
          ),
          child: Column(
            children: [
              const YMargin(15),
              Row(
                children: [
                  const XMargin(30),
                  Text(
                    'Jobs',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.search,
                    size: 17,
                    color: Colors.black54,
                  ),
                  const XMargin(20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Material(
                      color: Colors.blueAccent,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          height: context.screenHeight(.04),
                          width: context.screenHeight(.04),
                          child: Icon(
                            Icons.add,
                            size: 17,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const XMargin(20),
                ],
              ),
            ],
          ),
        ),
        Flexible(
          flex: 0,
          child: Container(
            height: 0.8,
            color: grey.withOpacity(.2),
          ),
        ),
        Expanded(
          child: ListView(
            controller: ScrollController(),
            padding: EdgeInsets.all(0),
            children: [
              const YMargin(15),
              JobItem(
                job: Job(
                  title: 'Manger',
                  price: '2,000',
                ),
              ),
              JobItem(
                job: Job(
                  title: 'UI/UX Designer',
                  price: '3,500',
                ),
              ),
              JobItem(
                job: Job(
                  title: 'Cloud Engineer',
                  price: '5,000',
                  selected: true,
                ),
              ),
              JobItem(
                job: Job(
                  title: 'Account Manager',
                  price: '2,500 - 5000',
                ),
              ),
              JobItem(
                job: Job(
                  title: 'PHP Developer',
                  price: '2,500 - 7000',
                ),
              ),
              JobItem(
                job: Job(
                  title: 'Mobile Developer',
                  price: '3,500 - 7500',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class JobItem extends StatelessWidget {
  const JobItem({
    Key key,
    this.job,
  }) : super(key: key);
  final Job job;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: context.screenHeight(0.08),
        color: job.selected ? grey.withOpacity(0.1) : null,
        child: Row(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      job?.title ?? '',
                      style: TextStyle(
                          color: darkGrey.withOpacity(job.selected ? 1 : 0.5),
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                  const YMargin(5),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      '\$${job.price ?? '100'}',
                      style: GoogleFonts.ubuntu(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w100,
                          fontSize: 13,
                          color: Colors.grey[500],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            if (job.selected)
              Flexible(
                  flex: 0,
                  child: Container(
                    width: 3,
                    color: Color(0xff5d71e1),
                  ))
          ],
        ),
      ),
    );
  }
}
