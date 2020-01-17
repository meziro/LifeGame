import controlP5.*;

boolean field[][];//フィールドの2次元配列
boolean tmp_field[][];//次の状態を入れとく配列

int size = 100;

Toggle toggle;

boolean switchState;
void setup(){
  size(1000,1000);
  field = new boolean[size][size];
  tmp_field = new boolean[size][size];
  //リセット処理
  ControlP5 reset = new ControlP5(this);
  reset.addButton("Reset")
  .setPosition(0,10)
  .setSize(100,30)
  .setColorActive(color(128))
  .setColorBackground(color(255))
  .setColorCaptionLabel(color(0));
  
  //ストップ機能
  /*ControlP5 stop = new ControlP5(this);
  stop.addButton("Stop")
  .setSize(100,30)
  .setPosition(0,50)
  .setColorCaptionLabel(color(0))
  .setColorActive(color(128))
  .setColorBackground(color(255));*/
  //スタート 
  /*ControlP5 start = new ControlP5(this);
  start.addButton("Start")
  .setSize(100,30)
  .setPosition(0,70)
  .setColorCaptionLabel(color(0))
  .setColorActive(color(128))
  .setColorBackground(color(255));
  */

   /*ControlP5 stop = new ControlP5(this);
   stop.addToggle("stop")
  .setLabel("stop")
  .setSize(100,30)
  .setPosition(0,80)
  .setValue(false)
  .setColorCaptionLabel(color(0))
  .setColorActive(color(128))
  .setColorBackground(color(255));*/
  
  //toggle = stop.addToggle
  
  for( int i = 0; i < size; i++ ){
    for( int j = 0; j < size; j++ ){
    field[i][j] = int(random(2)) == 0;//ランダムに初期配置
  }
  }
  frameRate(10);
}
/*void Stop(){
  if(stop.getBooleanValue()){
    noLoop();
  }else{
    loop();
  }
}*/
/*
void controlEvent(ControlEvent theEvent){
  if(theEvent.getController().getName() == "Reset"){
    Reset();
}else if(theEvent.getController().getName() == "Stop"){
  noLoop();
}else if(theEvent.getController().getName() == "Start"){
  loop();
}
}
*/
/*
void Stop(){
  noLoop();
}*/
void Reset(){
  for(int i = 0; i < size; i++ ){
    for(int j = 0; j < size; j++ ){
      field[i][j] = false;
    }
  }
  for( int i = 0; i < size * size; i++ ){
    field[i/size][i%size] = int(random(2)) == 0;
}
}
void draw(){
  background(0);
  int side = width/size;
  Change();
  fill(0,255,0);
  stroke(0,255,0);
  
  for( int i = 0; i < size; i++ ){
    for( int j = 0; j <size; j++ ){
      if(field[i][j])
      rect(i * side,j * side,side ,side);
    }
  }
  
}

//次の状態を計算する
void Change(){
  for( int i = 0; i < size; i++ ){
    for( int j = 0; j < size; j++ ){
      tmp_field[i][j] = Check(i,j);
    }
  }
  for( int i = 0; i < size; i++ ){
    for( int j = 0; j < size; j++ ){
      field[i][j] = tmp_field[i][j];
    }
  }
}
      
  
//あるセルの周囲８マスがsizeを超えないように制限
boolean Restriction(int x, int y){
  if( x < 0 || x >= size || y < 0 || y >= size ){
    return false;
  }else{
    return true;
}
}
//次にどういう変化をするかチェック
boolean Check(int x, int y){
  int count = 0;//周囲のセルを数える
  for(int i = -1; i < 2; i++ ){
    for(int j = -1;j < 2; j++ ){
      if(Restriction(x+i,y+j))
      if( i != 0 || j != 0 )
      if(field[x+i][y+j])
      count++;
    }
  }
  
  if(field[x][y] && (count == 2 ||count == 3)){
    return true;
  }else if(field[x][y] == false && count ==3){
    return true;
  }else{
    return false;
  }
}
