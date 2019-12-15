import 'dart:io';
import 'dart:math';

class MazeGenerator{

  int width;
  int height;
  int seed;
  List<List<int>> grid;

  final int N = 1;
  final int S = 2;
  final int E = 4;
  final int W = 8;

  MazeGenerator(this.height, this.width){
      this.grid = List<List<int>>();
  }

  void generate(){
    this.seed = Random().nextInt(9999);
    populateGird();
    carvePassagesFrom(0, 0, this.grid);
    var mazeStr = generateAsciiMaze();
    print(mazeStr);
  }

  String generateAsciiMaze(){
    String finalStr = "";
    finalStr += " ";
        for(int i =0; i < width; i++){
          finalStr += " _";
        }
        finalStr += "\n";

        for (int y = 0; y < height; y++){
          finalStr += " |";
          for(int x = 0; x < width; x++){
            var cell = grid[y][x] & S != 0 ? " " : "_";
            finalStr += cell;
            cell = grid[y][x] & E != 0 ? " " : "|";
            finalStr += cell;
          }
          finalStr += "\n";
        }
        return finalStr;
  }

  void populateGird(){
    grid = List<List<int>>.generate(
      width, (i) => List<int>.generate(height, (j) => 0));
  }

  void carvePassagesFrom(int cx, int cy, List<List<int>> grid){
  List<int> directions = shuffle([N,S,E,W]);

  for (var direction in directions) {
    var nx = cx + getDirectionXOffset(direction);
    var ny = cy + getDirectionYOffset(direction);

    if(isOutOfBounds(nx,ny,grid)){
      continue;
    }

    if(grid[ny][nx] != 0){
      continue;
    }
        grid[cy][cx] |= direction;
        grid[ny][nx] |= getOppositeDirection(direction);
        carvePassagesFrom(nx, ny, grid);
  }

  }

  bool isOutOfBounds(int x,int y, List<List<int>> grid){
    return (x < 0 || x > width - 1) || (y < 0 || y > width - 1);
  }

  List<int> shuffle(List<int> items){
    var random = new Random();
    for(var i = items.length - 1; i > 0; i--){
      var n = random.nextInt(i+1);
      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }
    return items;
  }

  int getDirectionXOffset(int direction){
    if(direction == 4) return 1;
    else if(direction == 8) return -1;
    else return 0;
  }

  int getDirectionYOffset(int direction){
    if(direction == 1) return -1;
    else if(direction == 2) return 1;
    else return 0;
  }

  int getOppositeDirection(int direction){
    if(direction == 4) return 8;
    if(direction == 8) return 4;
    if(direction == 1) return 2;
    if(direction == 2) return 1;
    return null;
  }}