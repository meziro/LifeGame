boolean[][] field;
boolean[][] temp_field;

int size = 100;

void setup(){
  size(1000,1000);
  field = new boolean[size][size];
  temp_field = new boolean[size][size];
  
  for(int i = 0; i < size * size; i++ ){
    field[i/size][i%size] = int(random(2)) == 0;
  }
    frameRate(20);
}

void draw(){
  background(0);
  
  int side = width/size;
  step();
  
  edit_field();
  
  fill(0,255,0);
  stroke(0,255,0);
  
  for(int i = 0; i < size; i++ ){
    for(int j = 0; j < size; j++ ){
      if( field[i][j] ){
        rect(i * side, j * side, side , side);
      }
    }
  }
}
  
  void step(){
    for(int i = 0; i < size; i++ ){
      for(int j = 0; j < size; j++ ){
        temp_field[i][j] = is_alive(i, j);
      }
    }
    for(int i = 0; i < size; i++ ){
      for(int j = 0; j < size; j++ ){
        field[i][j] = temp_field[i][j];
      }
    }
  }
  
  boolean is_alive(int x, int y){
    int count = 0;
    
    for(int i = -1; i <= 1; i++ ){
      for(int j = -1; j <= 1; j++ ){
        if( in_range(x+i, y+j) )
          if( i != 0 || j != 0)
            if( field[x + i][y + j])
              count++;
      }
    }
     
    
    if( field[x][y] && (count == 2 || count == 3))
    return true;
    else if(field[x][y] == false && count == 3)
    return true;
    else
    return false;
      }
      
    boolean in_range(int x, int y){
      if(x < 0 || x >= size || y < 0 || y >= size)
      return false;
     return true;
    }
    
    void edit_field(){
      int x = mouseX * size /width;
      int y = mouseY * size /height;
      
      if(in_range(x, y))
      field[x][y] = !field[x][y];
    }
        
     
     
     
     
