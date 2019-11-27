OpenSimplexNoise noise, noise_inc;

enum TILE {
 DIRT, GRASS, STONE, WATER 
}

int scl = 10;
float i_min = 0.015, i_med = 0.16, i_max = 0.3;

int w = width * 3, h = height * 2;
float elevation_map[][];
TILE  tiles_map[][];

void setup() {
  size(640, 360, P3D);
  noise = new OpenSimplexNoise(millis());
  noise_inc = new OpenSimplexNoise(millis());
  
  elevation_map = new float[w][h];
  tiles_map = new TILE[w][h];
}

void draw() {
  scale(0.15);
  translate(width,height/5);
  rotateX(PI/12);
  
  background(164,164,164);
  fill(48,40,28);
  noStroke();
  ambientLight(200, 180, 160);
  directionalLight(128, 128, 128, PI/2, PI/2, 0);
  
  float dy = 0, dyy = 1000, dyyy= 10000;
  for (int y = 0; y < h; y++) {
    
    beginShape(QUAD_STRIP);
    
    float dx = 0, dxx = 1000, dxxx = 10000;
    for (int x = 0; x < w; x++) {
      
      float z = map((float)noise.eval(dx,dy),-1,1,-60,60);
      float zz = map((float)noise.eval(dx,dy+i_min),-1,1,-60,60);
      float z1 = map((float)noise.eval(dxx,dyy),-1,1,-10,10);
      float zz1 = map((float)noise.eval(dxx,dyy+i_med),-1,1,-10,10);
      float z2 = map((float)noise.eval(dxxx,dyyy),-1,1,-10,10);
      float zz2 = map((float)noise.eval(dxxx,dyyy+i_max),-1,1,-10,10);
      
      float el = z + z1 + z2;
      float elz = zz + zz1 + zz2;
      
      if (el < -10) { fill(64,80,200,142); el = -10; elz = -10; }
      else { 
        float red = map(abs(el),0,70,140,0);
        float green = map(abs((15-el) < 0 ? (15-el)*2 : (15-el)),0,110,142,40);
        float blue = map(abs(40-el),0,50,40,0);
        if (el > 42) { red = green = blue = 200; }
        else if (el > 27) { red = green = blue = 150 + el/12; }
        fill(red,green,blue); 
      }
      
      vertex(x*scl,y*scl,el);
      elevation_map[x][y] = el;
      
      vertex(x*scl,(y+1)*scl,elz);
      
      fill(48,40,28);
      
      dx+=i_min;
      dxx+=i_med;
      dxxx+=i_max;
    }
    dy+=i_min;
    dyy+=i_med;
    dyyy+=i_max;
    
    endShape();
  }
  noLoop();
}
