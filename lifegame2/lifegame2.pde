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
  
  randomSeed(0);
  for( int i = 0; i < size; i++ ){
    for( int j = 0; j < size; j++ ){
    field[i][j] = int(random(2)) == 0;//ランダムに初期配置
  }
  }
  frameRate(10);
}

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

//セルを配置
void mousePressed(){
  int side = width / size;
  int x = mouseX * size / width;
  int y = mouseY * size / height;
  if(Restriction(x,y)){
    fill(0,255,0);
    stroke(0,255,0);
    rect(mouseX,mouseY,side,side);
    field[x][y] = true;
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
  //生死の条件
  if(field[x][y] && (count == 2 ||count == 3)){
    return true;
  }else if(field[x][y] == false && count ==3){
    return true;
  }else{
    return false;
  }
}
