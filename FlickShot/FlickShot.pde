PImage target;
int x,y;
void setup(){
  frameRate(60);
  size(1000,1000);
   target = loadImage("target.png");
   x = ceil(random(width));
   y = ceil(random(height));
}

void draw(){
  background(0);
  ellipse(x, y, 4, 4);
  x += 1; // move right
  //image(target,random(100),random(100),random(1000),random(1000));
}
