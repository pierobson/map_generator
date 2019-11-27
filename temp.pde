//OpenSimplexNoise noise, noise1, noise2;
//float inc = 0.04;
//float linc = 0.001;
//float dinc = 0.14;
//int cols, rows;
//int scale = 5;

//void setup() {
//  size(640, 360, P3D);
//  noise = new OpenSimplexNoise((long)random(Long.MAX_VALUE));
//  noise1 = new OpenSimplexNoise();
//  noise2 = new OpenSimplexNoise((long)random(Long.MAX_VALUE));
//  cols = width;
//  rows = height;
//}

//float dy = 0, dyy = 0,reey = 0;
//void draw() {
//  ambientLight(200, 180, 160);
//  directionalLight(128, 128, 128, PI/2, PI/2, 0);
//  background(128, 128, 255);
//  fill(50, 50, 50); 
//  noStroke();
//  float dytemp = dy;
//  float dyytemp = dyy;
//  float yeet = linc + 12000;
//  scale(0.2);
//  translate(-width/8, -100);
//  rotateX(PI/4);

//  for (int y = 0; y < rows; y++) {
//    beginShape(TRIANGLE_STRIP);
//    float dx = 0;
//    for (int x = 0; x < cols; x++) {
//      float ree = map((float)noise.eval(dx, reey), -1, 1, -200, 200);
//      float z = map((float)noise1.eval(dx, dy), -1, 1, -100, 100);
//      float zz = map((float)noise2.eval(dx, dyy), -1, 1, -20, 20);
//      float reez = map((float)noise1.eval(dx, reey+linc), -1, 1, -200, 200);
//      float z1 = map((float)noise.eval(dx, dy+inc), -1, 1, -100, 100);
//      float zz1 = map((float)noise2.eval(dx, dyy+dinc), -1, 1, -20, 20);
//      float c = map(z+zz, -120, 120, 20, 80);
//      fill(c, c, c);
//      vertex(x*scale, y*scale, z+zz+ree);
//      vertex(x*scale, (y+1)*scale, z1+zz1+reez);
//      dx += inc;
//    }
//    endShape();
//    dy+=inc;
//    dyy+=dinc;
//    reey+=linc;
//  }

//  dy=dytemp-inc;
//  dyy=dyytemp-dinc;
//  reey=yeet-linc;
//  //noLoop();
//}
