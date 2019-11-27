OpenSimplexNoise noise, noise_inc;

enum TILE {
 DIRT, GRASS, STONE, WATER 
}

int scl = 10;
float inc = 0.1;
float elevation_map[][];
TILE  tiles_map[][];

void setup() {
  size(640, 360, P3D);
  noise = new OpenSimplexNoise(millis());
  noise_inc = new OpenSimplexNoise(millis());
}

void draw() {
  scale(0.2);
  translate(width,height);
  rotateX(PI/6);
  //translate();
  
  background(164,164,164);
  fill(48,40,28);
  noStroke();
  ambientLight(200, 180, 160);
  directionalLight(128, 128, 128, PI/2, PI/2, 0);
  
  float dy = 0, dyy = 100;
  for (int y = 0; y < height/scl*3; y++) {
    float dx = 0, dxx = 100;
    beginShape(QUAD_STRIP);
    for (int x = 0; x <= width/scl*3; x++) {
      float z = map((float)noise.eval(dx,dy),-1,1,-100,150);
      float zz = map((float)noise.eval(dx,dy+inc/4),-1,1,-100,150);
      float z1 = map((float)noise.eval(dxx,dyy),-1,1,-20,20);
      float zz1 = map((float)noise.eval(dxx,dyy+inc*2),-1,1,-20,20);
      float el = z + z1;
      float elz = zz + zz1;
      if (el < 0) { fill(64,80,185,128); el = 0; elz = 0; }
      else { fill(255/abs(el-40),255/abs(el-80),255/abs(el-120)); }
      vertex(x*scl,y*scl,el);
      vertex(x*scl,(y+1)*scl,elz);
      fill(48,40,28);
      dx+=inc/4;
      dxx+=inc*2;
    }
    dy+=inc/4;
    dyy+=inc*2;
    endShape();
  }
  if (dy > 0.1) noLoop();
}
