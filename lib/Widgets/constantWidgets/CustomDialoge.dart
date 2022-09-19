import 'package:companywebapp/Widgets/Constants/ConstantColors.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class CustomDialoge extends StatelessWidget {
  final String title;
  final List<Map> content;
  final Function save;
  const CustomDialoge({Key? key, required this.title, required this.content, required this.save})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        backgroundColor: customBtengan,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0)), //this right here
        child: ScreenTypeLayout(
          mobile: DialogeMobile(
            title: title,
            content: content,
            save: save,
          ),
          desktop: DialogeDesktop(
            title: title,
            content: content,
            save: save,
          ),
        ));
  }
}

class DialogeMobile extends StatelessWidget {
  final String title;
  final List<Map> content;
  final Function save;
  const DialogeMobile({Key? key, required this.title, required this.content, required this.save})
      : super(key: key);

  BuildContent() {
    return Column(
      children: content.map<Widget>((e) => onerowcontent(e)).toList(),
    );
  }

  onerowcontent(Map e) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                e["title"],
                textAlign: TextAlign.start,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: e['widget']),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      width: 300.0,
      child: Stack(
        children: [
          Container(
            height: 550,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                      title,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
                  ),
                  BuildContent(),
                ],
              ),
            ),
          ),
           SaveAndCancel(
            fontsize: 18,
            save: save,
          ),
        ],
      ),
    );
  }
}

class DialogeDesktop extends StatelessWidget {
  final String title;
  final List<Map> content;
  final Function save;
  const DialogeDesktop({Key? key, required this.title, required this.content, required this.save})
      : super(key: key);
  BuildContent() {
    return Column(children: [
      Wrap(
        children:content.map<Widget>((e) => onerowcontent(e)).toList(),
      )
    ]);
  }

  onerowcontent(Map e) {
    print("here");
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 25),
        child: Column(
          children: [
            SizedBox(
            width: 200,
              child: Text(
                e["title"],
                textAlign: TextAlign.start,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              width: 200,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: e['widget']),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          SizedBox(
            height: 270,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Text(
                          title,
                          style: const TextStyle(fontSize: 20, color: Colors.white),
                        )),
                  ),
                  BuildContent(),
                ],
              ),
            ),
          ),
           SaveAndCancel(
            fontsize: 24,
            save: save,
          ),
        ],
      ),
    );
  }
}

class SaveAndCancel extends StatelessWidget {
  final double fontsize;
  final Function save;
  const SaveAndCancel({Key? key, required this.fontsize, required this.save}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () {
                    save();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'save',
                    style: TextStyle(color: Colors.white, fontSize: fontsize),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white, fontSize: fontsize),
                  )),
            ],
          ),
        ));
  }
}
