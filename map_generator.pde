OpenSimplexNoise noise, noise_inc;

enum TILE {
 DIRT, GRASS, STONE, WATER 
}

int scl = 10;
float inc = 0.1;
float elevation_map[][];
TILE  tiles_map[][];
float mx=0,my=0,pa=0;

void setup() {
  size(640, 360, P3D);
  noise = new OpenSimplexNoise(millis());
  noise_inc = new OpenSimplexNoise(millis());
  mx=mouseX;
  my=mouseY;
  pa=PI/6;
}

void draw() {
  scale(0.2);
  translate(width,height);
  //translate();
  pa += (mx - mouseX)/4;
  //rotateX(PI/6);
  rotateZ(pa);

  //rotateZ(mouseY-my);
  mx=mouseX;
  my=mouseY;
  
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
      if (el < -20) { fill(64,80,185,128); el = -20; elz = -20; }
      else if (el<40) { fill((abs(el-50)/el)*64,(abs(el-40)/el)*64,(abs(el-20)/el)*64); }
      else if (el<60) { fill(abs(128),abs(128),abs(128)); }
      else if (el<80) { fill(abs(64),abs(64),abs(64)); }
      else { fill(24,24,24); }
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
  //if (dy > 0.1) noLoop();
}
