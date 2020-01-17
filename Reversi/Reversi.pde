Board board;
int stoneColor = 1; // 1:黒、-1:白とする

void setup() {
  size(400,400);  
  board = new Board();
  board.initGame();
} 

void draw() {  
  board.display();
}

void mouseClicked() {
  Cell cell = board.getCellAtXY(mouseX, mouseY); 
  ArrayList<Cell> cellsToFlip = board.cellsToFlipWith(cell, stoneColor);

  //引っ繰り返せるマスがある場合は石が置ける
  if(cellsToFlip.size() > 0){
    //石を置く
    cell.putStone(stoneColor);

    // それぞれひっくりかえす
    for(Cell c: cellsToFlip){
      c.flip();
    }
  } else {
    // ひっくりかえせるマスがない場合は何もしない
  }

  stoneColor *= -1; // 反転
}
