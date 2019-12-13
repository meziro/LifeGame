void setup(){
  size(1000,1000,P3D);
  int rad;
  //float [][][]rot = {{1,0,0},{0,cos(rad),-sin(rad)},{0,sin(rad),cos(rad)}};
}

void draw(){
   background(200);

  PVector eye = new PVector();   // 視点1の目ん玉の位置
  PVector right = new PVector(); // 視点1の右方向を示す点
  PVector down = new PVector();  // 視点1の下方向を示す点

  pushMatrix(); 
    camera( 170, -100, 100, 0, 0, 0, 0, 1, 0 );  // 視点1
    PMatrix3D mat = (PMatrix3D)getMatrix();      // モデルビュー行列の取得
    mat.invert(); // 逆行列
    mat.mult( new PVector( 0, 0, 0 ), eye );     // カメラ座標系の(0,0,0)をワールド座標系の座標値に変換
    mat.mult( new PVector( 100, 0, 0 ), right ); // カメラ座標系の(100,0,0)をワールド座標系の座標値に変換
    mat.mult( new PVector( 0, 100, 0 ), down );  // カメラ座標系の(0,100,0)をワールド座標系の座標値に変換
  popMatrix();

  // マウスクリックで視点切り替え
  if ( mousePressed ) {
    camera( 170, -100, 100, 0, 0, 0, 0, 1, 0 );  // 視点1
  } else {
    camera( 220, -100, 520, 0, 0, 0, 0, 1, 0 );  // 視点2
  }

  strokeWeight(3);
  noFill();

  // 注視点(0,0,0)に立方体を置く
  stroke(0);
  box(100);

  // 視点1の右方向を示す線（赤）
  stroke(255, 0, 0);
  line( eye.x, eye.y, eye.z, right.x, right.y, right.z );

  // 視点1の下方向を示す線（緑）
  stroke(0, 255, 0);
  line( eye.x, eye.y, eye.z, down.x, down.y, down.z );

  // 視点1の視線方向を示す線（青）
  stroke(0, 0, 255);
  line( eye.x, eye.y, eye.z, 0, 0, 0);
}
