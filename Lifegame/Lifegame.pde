boolean[][] board;      /* 現在の状態を保存する変数 */
boolean[][] temp_board; /* 次の状態を保存する変数 */
int N = 64;            /* 一辺の数 */


void setup() {
  size(512, 512);

  /* ボードの作成 */
  board = new boolean[N][N];
  temp_board = new boolean[N][N];
  for (int i = 0; i < N * N; i++ )
    board[i/N][i%N] = int(random(2)) == 0 ;

  frameRate(10);
}

void draw() {
  background(0);

  /* 四角形の幅を決める */
  int w = width/N;

  /* 生き死にを決める */
  step();
  /* マウスで状態を変える */
  edit_board();

  /* 色を指定 */
  fill(0, 255, 0);
  stroke(0, 255, 0);
  
  for (int i = 0; i < N; i++ ) {
    for (int j = 0; j < N; j++ ) {
      /* board[i][j]がtrueすなわち生きている場合描画 */
      if ( board[i][j] )
        rect(i*w, j*w, w, w);
    }
  }
}

/* 生き死にを決める関数 */
void step() {
  /* temp_boardにとりあえずその後の状態を保存 */
  for (int i = 0; i < N; i++ ) 
    for (int j = 0; j < N; j++ ) 
      temp_board[i][j] = is_alive(i, j);
      
  /* ボードをコピー */
  for (int i = 0; i < N; i++ ) 
    for (int j = 0; j < N; j++ ) 
      board[i][j] = temp_board[i][j];
}

boolean is_alive(int x, int y) {
  int count = 0;
  
  /* 周囲8マスを見る */
  for (int i = -1; i <= 1; i++ ) 
    for (int j = -1; j <= 1; j++ ) 
      if ( in_range(x+i, y+j) )
        if ( i != 0 || j != 0 )
          if ( board[x+i][y+j] )
            count++;

  
  if ( board[x][y] && ( count == 2 || count == 3 ) )
    return true;/* 生きていて周りに友達がいるから生き残れる */
  else if ( board[x][y] == false && count == 3 )
    return true;/* それなりに人がいるから新しい子供が生まれる */
  else 
    return false;/* それ以外は生き残れない */
}

boolean in_range(int x, int y) {
  if ( x < 0 || x >= N || y < 0 || y >= N )
    return false;
  return true;
}

void edit_board() {
  int x = mouseX * N / width;
  int y = mouseY * N / height;

  if ( in_range(x, y) )
    board[x][y] = !board[x][y];
}
