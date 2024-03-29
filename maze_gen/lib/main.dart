import 'package:flutter/material.dart';
import 'package:maze_gen/maze_generator.dart';
import 'package:maze_gen/maze_generator_base.dart';
import 'package:maze_gen/open_paint.dart';

void main() => runApp(MazeGeneratorApp());

class MazeGeneratorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maze Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(title: 'Generator Page'),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  MazeGeneratorBase generator = MazeGenerator(30,30);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            RaisedButton(
              onPressed: generator.generate,
            child: Text("Generate")),
            Container(
              margin: EdgeInsets.only(right: 150),
              child: CustomPaint(
                size: Size(30,30),
                painter: OpenPainter(generator)
              ),
            )
          ],
        ),
      ),
    );
  }
}
