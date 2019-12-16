void setup(){
  size(1000,1000,P3D);
}

void draw(){
  background(200);
  PVector eye = new PVector();
  pushMatrix();
  PMatrix3D mat =(PMatrix3D)getMatrix();
  mat.invert();
  mat.mult( new PVector( 0, 0, 0 ), eye );
  
  
  
}
void keyPressed(){
  if(keyCode == RIGHT){
    camera(170,-100,100,0,0,0,0,1,0);
  }
}
