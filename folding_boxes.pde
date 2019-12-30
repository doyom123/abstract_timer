import controlP5.*;

ControlP5 cp5;
Accordion accordion;

FoldingBox fb;

void setup() {
  size(500, 500);
  gui();

  
  fb = new FoldingBox(10, 10, 200, 200);
}

void draw() {
  background(150);
  ellipse(300, 200, 50, 50);
  
  fb.fold();
}

void gui() {
  cp5 = new ControlP5(this);
  Group g1 = cp5.addGroup("foldingBoxGroup")
                .setBackgroundColor(color(0, 64))
                .setBackgroundHeight(150);
  cp5.addRadioButton("radio")
     .setPosition(10,20)
     .setItemWidth(20)
     .setItemHeight(20)
     .addItem("black", 0)
     .addItem("red", 1)
     .setColorLabel(color(255))
     .activate(2)
     .moveTo(g1);
  
}

class FoldingBox {
  float _x1;
  float _y1;
  float _x2;
  float _y2;
  FoldingTri t1;
  FoldingTri t2;
  FoldingTri t3;
  
  FoldingBox(float x1, float y1, float x2, float y2) {
    _x1 = x1;
    _y1 = y1;
    _x2 = x2;
  _y2 = y2;
    t1 = new FoldingTri(_x1, _y2, _x1, _y1, _x2, _y1,#525252);
    t2 = new FoldingTri(_x1, _y2, _x1, _y1, _x2, _y1, #323232);
    t3 = new FoldingTri(_x1, _y2, _x2, _y2, _x2, _y1, #C8C8C8);
  }
  void fold() {
    t2.draw();
    t3.draw();
    t1.update();
    

  }
}

class FoldingTri {
  float _x1;
  float _x2;
  float _x3;
  float _y1;
  float _y2;
  float _y3;
  float speed;
  float acc;
  int _rgb;
  
  
  FoldingTri(float x1, float y1, float x2, float y2, float x3, float y3, int rgb) {
    _x1 = x1;
    _x2 = x2;
    _x3 = x3;
    _y1 = y1;
    _y2 = y2;
    _y3 = y3;
    speed = .00000001;
    acc = .3;
    _rgb = rgb;
  }
  
  void draw() {
    noStroke();
    fill(_rgb);
    triangle(_x1, _y1, _x2, _y2, _x3, _y3);
  }
  void update() {
    noStroke();
    fill(_rgb);
    float newSpeed = (speed * acc) + speed;
    float newX2 = _x2 + newSpeed;
    if(newX2 < _x3) {
      _x2 = newX2;
    } else {
      _x2 = _x3; 
    }
    
    float newY2 = _y2 + newSpeed;
    if(newY2 < _y1) {
      _y2 = newY2;
      speed = newSpeed;
    } else {
      _y2 = _y1; 
    }
    triangle(_x1, _y1, _x2, _y2, _x3, _y3);
  }
}
