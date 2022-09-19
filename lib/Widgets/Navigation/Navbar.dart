import 'package:companywebapp/Widgets/Navigation/Drawer.dart';
import 'package:companywebapp/locator.dart';
import 'package:companywebapp/routing/Router.dart';
import 'package:companywebapp/services/Navigationservice.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../routing/route_names.dart';

class Navbar extends StatelessWidget {
  final Function openDrawer;
  const Navbar(this.openDrawer, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: MobilView(openDrawer),
      desktop: const Nvabarnormalview(),
      tablet: const Nvabarnormalview(),
    );
  }
}

class MobilView extends StatelessWidget {
  final Function openDrawer;
  const MobilView(this.openDrawer, {Key? key}) : super(key: key);
  _Header() {
    return Container(
        height: 50,
        color: const Color(0xff13142A),
        alignment: Alignment.centerLeft,
        child: IconButton(
            onPressed: () => openDrawer(),
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Header(),
        const Expanded(
          child:  Navigationhandler()
        ),
      ],
    );
  }
}
class Navigationhandler extends StatelessWidget {
  const Navigationhandler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: locator<Navigationservice>().navigatorkey,
      onGenerateRoute: generateroute,
      initialRoute: REPORTS,

    );
  }
}

class Nvabarnormalview extends StatelessWidget {
  const Nvabarnormalview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children:const  [
         CustomDrawer(),
        Expanded(
          child: Navigationhandler(),
        )
      ],
    );
  }
}
