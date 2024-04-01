import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:quote_app/headers.dart';
import 'dart:ui' as ui;

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  Color color = Colors.white;
  double opacity = 1;
  String fonts = AppFonts.dancingScript.name;
  bool _color = false;
  TextAlign left = TextAlign.center;
  bool bold = false;
  bool fontstyle = false;
  GlobalKey widgetKey = GlobalKey();

  Future<File> getFileFromWidget() async {
    RenderRepaintBoundary boundary =
        widgetKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage(
      pixelRatio: 15,
    );
    ByteData? data = await image.toByteData();
    Uint8List list = data!.buffer.asUint8List();

    Directory directory = await getTemporaryDirectory();
    File file = await File(
            "${directory.path}/QA${DateTime.now().millisecondsSinceEpoch}.png")
        .create();
    file.writeAsBytesSync(list);

    return file;
  }

  @override
  Widget build(BuildContext context) {
    Quote quote = ModalRoute.of(context)!.settings.arguments as Quote;

    return PopScope(
      canPop: false,
      onPopInvoked: (val) {
        if (val) {
          return;
        }
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Alert !!"),
            content: const Text("Are you sure to exit?"),
            actions: [
              ElevatedButton(
                onPressed: () {
                  // _canPop = true;
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text("Yes"),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("No"),
              ),
            ],
          ),
        );
      },
      // onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Detail Page"),
            actions: [
              IconButton(
                onPressed: () {
                  opacity = 1;
                  color = Colors.white;
                  fonts = AppFonts.dancingScript.name;
                  setState(() {});
                },
                icon: const Icon(Icons.refresh),
              ),
            ],
          ),
          body: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Spacer(),
                  //save
                  TextButton(
                    onPressed: () async {
                      ImageGallerySaver.saveFile(
                        (await getFileFromWidget()).path,
                        isReturnPathOfIOS: true,
                      ).then(
                        (value) => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Saved to gallery !!"),
                          ),
                        ),
                      );
                    },
                    child: const Icon(Icons.save_alt),
                    // label: const Text("Save to gallery"),
                  ),
                  //share
                  TextButton(
                    onPressed: () async {
                      ShareExtend.share(
                        (await getFileFromWidget()).path,
                        "image",
                      );
                    },
                    child: const Icon(Icons.share),
                  ),
                ],
              ),
              Expanded(
                //Widget identify =>  pixels/boundary =>  Image  =>  Uint8List  =>  File
                child: Stack(
                  children: [
                    RepaintBoundary(
                      key: widgetKey,
                      child: Container(
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          color: color.withOpacity(opacity),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Positioned(
                              top: 10,
                              bottom: 50,
                              child: SelectableText(
                                quote.quote,
                                textAlign: left,
                                style: TextStyle(
                                  fontWeight: bold
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  fontStyle: fontstyle
                                      ? FontStyle.italic
                                      : FontStyle.normal,
                                  fontSize: 25,
                                  fontFamily: fonts,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text("- ${quote.author}"),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 3,
                      top: 11,
                      child: TextButton(
                        onPressed: () {
                          Clipboard.setData(
                            ClipboardData(
                              text: "${quote.quote}\n\n-${quote.author}",
                            ),
                          ).then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Quote copied to clipboard !!"),
                              ),
                            );
                          });
                        },
                        child: const Icon(Icons.copy),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                //Column
                child: Visibility(
                  visible: _color,
                  child: Column(
                    children: [
                      const Text("Background color"),
                      //Row
                      SizedBox(
                        height: 50,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                            18,
                            (index) => Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: GestureDetector(
                                onTap: () {
                                  color = Colors.primaries[index];
                                  setState(() {});
                                },
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.primaries[index],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Slider(
                          value: opacity,
                          min: 0,
                          max: 1,
                          onChanged: (val) {
                            opacity = val;
                            setState(() {});
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: AppFonts.values
                            .map(
                              (e) => TextButton(
                                onPressed: () {
                                  fonts = e.name;
                                  setState(() {});
                                },
                                child: Text(
                                  "Abc",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: e.name,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      //TextAlign
                      Text("TextAlign"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              left = TextAlign.start;
                              setState(() {});
                            },
                            child: const Icon(CupertinoIcons.text_alignleft),
                          ),
                          TextButton(
                            onPressed: () {
                              left = TextAlign.center;
                              setState(() {});
                            },
                            child: const Icon(CupertinoIcons.text_aligncenter),
                          ),
                          TextButton(
                            onPressed: () {
                              left = TextAlign.end;
                              setState(() {});
                            },
                            child: const Icon(CupertinoIcons.text_alignright),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            onPressed: () {
                              bold = !bold;
                              setState(() {});
                            },
                            child: const Icon(CupertinoIcons.bold),
                          ),
                          TextButton(
                            onPressed: () {
                              fontstyle = !fontstyle;
                              setState(() {});
                            },
                            child: const Icon(CupertinoIcons.italic),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              _color = !_color;
              setState(() {});
            },
            label: const Text("Edit"),
            icon: const Icon(Icons.edit),
          )),
    );
  }
}
