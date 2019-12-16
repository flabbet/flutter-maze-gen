import 'dart:math';

import 'package:flutter/cupertino.dart';

import 'package:maze_gen/maze_generator_base.dart';

class MazeGenerator extends MazeGeneratorBase{
  List<int> grid;
  int attemptsLeft = 5;

  MazeGenerator(height, width) : super(height, width){
      this.grid = List<int>();
  }

  void generate(){
    populateGird();
    for(int i = 0; i < 50; i++) {
      generateMaze();
    }
  }

    List<Offset> getDrawPoints(){
      List<Offset> offsets = List<Offset>();
      for(int y = 0; y < height; y++){
        for(int x = 0; x < width; x++){
            if(getCell(x, y) == 1){
              offsets.add(Offset(x.toDouble(),y.toDouble()));
            }
          }
        }
      return offsets;
    }



  void populateGird(){
    grid = List<int>.generate(width * height, (i) => 1);
    grid[height ~/ 2] = 0;
  }

  void generateMaze(){
    var pCount = 0;
    for(int y = 0; y < height; y++){
        for(int x = 0; x < width; x++){
          if(getCell(x, y) == 0){
            pCount += makePassage(x,y, -1,0)
              + makePassage(x,y,  1,0)
              + makePassage(x,y, 0,-1)
              + makePassage(x,y, 0, 1);
          }
        }
      }
    if(pCount == 0){
      attemptsLeft--;
      if(attemptsLeft > 0){
        for(int x = 0; x < width; x++){
          if(getCell(x, height-2) == 0){
            setCell(x, height-1, 0);
            break;
          }
        }
      }
    }
  }

  int makePassage(int x,int y, int i, int j){
    //Checking neighbor cells
    if(    getCell(x+i, y+j) == 1
        && getCell( x+i+j, y+j+i ) == 1
   		  && getCell( x+i-j, y+j-i ) == 1){

      if(getCell(x+i+j, y+j+j) == 1
        && getCell( x+i+i+j, y+j+j+i ) == 1
   		  && getCell( x+i+i -j, y+j+j -i ) == 1) {

        if (Random().nextDouble() > 0.5) {
          setCell(x + i, y + j, 0);
          return 1;
        }
      }
    }
    return 0;
  }

  int getCell(int x, int y){
    return (x>= 0 && y>=0 && x<width && y < height) ? grid[x+y * width] : -1;
  }

  void setCell(int x, int y, int state) {
    if(x>=0 && y>=0 && x<width && y<height)
    {
  	  grid[x + y*width] = state;
    }
  }

  }