OpenSimplexNoise noise1,noise2;
float inc = 0.04;
float dinc = 0.1;
int cols,rows;
int scale = 5;

void setup() {
  size(640,360,P3D);
  noise1 = new OpenSimplexNoise();
  noise2 = new OpenSimplexNoise((long)random(Long.MAX_VALUE));
  cols = width / 3 * scale / 2;
  rows = height / (scale/2);
}

float dy = 0, dyy = 0;
void draw() {
  lights();
  directionalLight(180,100,100,PI/2,PI/4,-PI/4);
  background(128,128,255);
  fill(64,48,0); 
  noStroke();
  float dytemp = dy;
  float dyytemp = dyy;
  scale(0.5);
  translate(width/2,height/2);
  rotateX(PI/10);
  translate(-3*width/2,-height/3);
  
    for (int y = 0; y < rows; y++) {
    beginShape(TRIANGLE_STRIP);
    float dx = 0;
    for (int x = 0; x < cols; x++) {
      float z = map((float)noise1.eval(dx,dy),-1,1,-100,100);
      float zz = map((float)noise2.eval(dx,dyy),-1,1,-20,20);
      float z1 = map((float)noise1.eval(dx,dy+inc),-1,1,-100,100);
      float zz1 = map((float)noise2.eval(dx,dyy+dinc),-1,1,-20,20);
      vertex(x*scale,y*scale,z+zz);
      vertex(x*scale,(y+1)*scale,z1+zz1);
      dx += inc;
    }
    endShape();
    dy+=inc;
    dyy+=dinc;
  }
  
  dy=dytemp-inc;
  dyy=dyytemp-dinc;
  //noLoop();
}
