OpenSimplexNoise noise, noise_inc;

enum TILE {
 DIRT, GRASS, STONE, WATER 
}

int scl = 10;
float inc = 0.13;
float elevation_map[][];
TILE  tiles_map[][];

float get_inc(float x,float y) {
 return map((float)noise_inc.eval(x,y),-1,1,0.0001,0.05); 
}


void setup() {
  size(640, 360, P3D);
  noise = new OpenSimplexNoise();
  noise_inc = new OpenSimplexNoise();
}

void draw() {
  scale(0.2);
  translate(width,height);
  //rotateX(PI/4);
  //translate();
  
  background(164,164,164);
  fill(48,40,28);
  noStroke();
  ambientLight(200, 180, 160);
  directionalLight(128, 128, 128, PI/2, PI/2, 0);
  
  float dy = 0, dyy = 100;
  for (int y = 0; y < height/scl*3; y++) {
    float dx = 0, dxx = 100;
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x <= width/scl*3; x++) {
      float z = map((float)noise.eval(dx,dy),-1,1,-100,150);
      float zz = map((float)noise.eval(dx,dy+(get_inc(0,dy))),-1,1,-100,150);
      float z1 = map((float)noise.eval(dxx,dyy),-1,1,-20,20);
      float zz1 = map((float)noise.eval(dxx,dyy+inc),-1,1,-20,20);
      float el = z + z1;
      float elz = zz + zz1;
      if (el <= -20) { fill(64,80,185,128); el = -20; elz = -20; }
      vertex(x*scl,y*scl,el);
      vertex(x*scl,(y+1)*scl,elz);
      fill(48,40,28);
      if (x==0 && (y < 2)) {
        float i = get_inc(dx,dy);
        println("dy = " + dy + ", inc = " + i);
      }
      dx+=inc;
      dxx+=inc*2;
    }
    dy+=get_inc(0,dy);
    dyy+=inc;
    endShape();
  }
  if (dy > 0.1) noLoop();
}
