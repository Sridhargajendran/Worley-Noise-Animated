int x, y;
int res = 10;
PVector[] points = new PVector[20];
ArrayList<Rect> rects = new ArrayList<Rect>();

void setup() {
  size(600, 600);

  for (int i = 0; i < points.length; i++) {
    points[i] = new PVector(random(width), random(height));
  }

  y = height;

  //frameRate(20);
}

void draw() {
  background(0);

  float minDist = 1000;
  PVector closest = new PVector();
  float[] distances = new float[points.length];
  for (int i = 0; i < points.length; i++) {
    PVector point = points[i];

    float d = dist(point.x, point.y, x, y);
    distances[i] = d;
    if (d < minDist) {
      minDist = d;
      closest = point;
    }
  }

  float[] sorted = sort(distances);
  float col = map(sorted[0], 0, 100, 255, 0);

  rects.add(new Rect(x, y, col));

  for (Rect r : rects) {
    r.show();
  }

  stroke(255);
  strokeWeight(1);
  line(x, y, closest.x, closest.y);

  stroke(255);
  strokeWeight(res);
  point(x, y);

  for (PVector p : points) {
    stroke(255, 0, 0);
    strokeWeight(15);
    point(p.x, p.y);
  }

  x += res;

  if (x >= width + res) {
    x = 0;
    y -= res;
  }

  if (y <= -res) {
    noLoop();
  }
}

class Rect {
  float x;
  float y;
  float col;

  Rect(float x_, float y_, float col_) {
    x = x_;
    y = y_;
    col = col_;
  }

  void show() {
    noStroke();
    fill(col);
    rectMode(CENTER);
    rect(x, y, res, res);
  }
}
