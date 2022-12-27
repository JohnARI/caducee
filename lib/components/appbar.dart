import 'package:caducee/common/const.dart';
import 'package:caducee/screens/home/drugs/category_list.dart';
import 'package:caducee/screens/home/user_list.dart';
import 'package:flutter/material.dart';
import 'package:caducee/screens/home/drugs/drug_list.dart';

class MyAppBar extends StatefulWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 3, vsync: this);


    return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: 20,
                top: 50,
                right: 20,
              ),
              child: Row(
                children: [
                  const Icon(Icons.menu, size: 30, color: myGreen),
                  Expanded(child: Container()),
                  const SizedBox(
                    child: Icon(
                          Icons.school_outlined,
                          color: myGreen,
                          size: 30,
                        ),
                      ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
                padding: const EdgeInsets.only(left: 20.0),
                height: 50,
                child: Image.asset('assets/images/textLogo.png')),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                  controller: tabController,
                  isScrollable: true,
                  labelPadding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.black54,
                  indicator:
                      const CircleTabIndicator(color: myDarkGreen, radius: 3),
                  unselectedLabelStyle: const TextStyle(fontSize: 16),
                  labelStyle:
                      const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  tabs: const [
                    Tab(
                      text: 'Médicaments',
                    ),
                    Tab(
                      text: 'Catégories',
                    ),
                    Tab(
                      text: 'Favoris',
                    ),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: SizedBox(
                width: double.maxFinite,
                height: 620,
                child: TabBarView(
                  controller: tabController,
                  children: const [
                    DrugList(
                    ),
                    CategoryList(
                    ),
                    UserList(
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  final double radius;

  const CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final double radius;
  late Color color;
  _CirclePainter({required this.color, required this.radius});
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    late Paint paint;
    paint = Paint()..color = color;
    paint = paint..isAntiAlias = true;
    final Offset circleOffset =
        offset + Offset(cfg.size!.width / 2, cfg.size!.height - radius);
    canvas.drawCircle(circleOffset, radius, paint);
  }
}