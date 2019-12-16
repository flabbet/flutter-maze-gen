import 'dart:ui';

abstract class MazeGeneratorBase{
  int height;
  int width;
  void generate();
  List<Offset> getDrawPoints();
  MazeGeneratorBase(this.height, this.width);
}