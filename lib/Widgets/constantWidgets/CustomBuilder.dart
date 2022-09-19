import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Constants/ConstantColors.dart';

class CustomBuilder extends StatefulWidget {
  final Map element;
  const CustomBuilder(this.element, {Key? key}) : super(key: key);

  @override
  State<CustomBuilder> createState() => _CustomBuilderState();
}

class _CustomBuilderState extends State<CustomBuilder> {
  final GlobalKey _globalkey = GlobalKey();
  bool _hovered = false;
  double x = 0.0;
  double y = 0.0;
  void _updateLocation(PointerEvent details) {
    RenderBox temp = _globalkey.currentContext?.findRenderObject() as RenderBox;
    Offset position = temp.localToGlobal(Offset.zero);
    final Size sizetemp = temp.size; // or _widgetKey.currentContext?.size

    final Size center = Size(
        position.dx + sizetemp.width / 2, position.dy + sizetemp.height / 2);

    setState(() {
      x = (details.position.dx - center.width) / (sizetemp.width / 2);
      y = (details.position.dy - center.height) / (sizetemp.height / 2);

      _hovered = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>widget.element['page']));
      },
      child: MouseRegion(
        onHover: (details) => _updateLocation(details),
        onExit: (detail) {
          setState(() {
            _hovered = false;
          });
        },
        child: Card(
          key: _globalkey,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
          ),
          elevation: 10,
          // shadowColor: customGrey,

          // margin:const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            // duration: const Duration(microseconds: 10),
              decoration: BoxDecoration(
                color: customSelection,
                gradient: _hovered
                    ? RadialGradient(
                    center: Alignment(x, y),
                    colors: const [customGrey, customSelection])
                    : null,
              ),
              child: Content(element: widget.element)
          ),
        ),
      ),
    );
  }
}
class Content extends StatelessWidget {
  final element;
  const Content({Key? key, this.element,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: ListTile(
              leading: element["icon"],
              title: Text(element["title"],
                style: const TextStyle(fontSize: 25.0),overflow:TextOverflow.ellipsis,maxLines: 3,),
              subtitle: Text(element["description"],
                  style: const TextStyle(fontSize: 20.0),overflow:TextOverflow.ellipsis,maxLines: 4),
            ),
          )
        ],
      ),
    );
  }
}

