import controlP5.*;

ControlP5 cp5;
String state;

int vis;
float time;
boolean isColor;

Textfield timeField;

void setup() {  
  size(700,400);
  state = "menu";
  vis = 0;
  isColor = false;
  cp5 = new ControlP5(this);
  //PFont font = createFont("arial",150);
     
  int uiWidth = 300;
  int uiHeight = 100;
  Group ui = cp5.addGroup("ui")
                .setPosition(width/2-uiWidth/2,height/2-uiHeight/2)
                .setWidth(uiWidth)
                .activateEvent(true)
                .disableCollapse()
                .setBackgroundColor(color(255,80))
                .setBackgroundHeight(uiHeight)
                .setLabel("Choose Visualization")
                ;
  
  cp5.addCheckBox("check")
     .setPosition(80,10)
     .setSize(10,10)
     .setColorForeground(color(120))
     .setColorActive(color(255))
     .setColorLabel(color(255))
     .addItem("color", 0)
     .setGroup(ui)
     ;
     
  cp5.addTextfield("time")
     .setPosition(80,30)
     .setSize(50,20)
     .setAutoClear(false)
     .setColor(color(255,0,0))
     .setText("30")
     .setGroup(ui)
     ;

  cp5.addButton("startBtn")
     .setPosition(100,100)
     .setSize(200,19)
     .setCaptionLabel("Start")
     .setGroup(ui)
     ;
     
  cp5.addRadioButton("visRadio")
     .setPosition(10,10)
     .setSize(20,9)
     .addItem("Folding",0)
     .addItem("Numbers",1)
     .setGroup(ui)
     .activate(0)
     .setValue(0)
     ;
   
}

public void startBtn() {
  Textfield tf = (Textfield) cp5.getGroup("ui").getController("time");
  time = int(tf.getText());
  println("time: " + time);
  
  if (time == 0) {
    //TODO: indicate that textfield is empty
    
  } else {
    state = "start";
  }
}

public void visRadio(int val) {
  if(val == -1) {
     //Prevent toggle off
    RadioButton rb = (RadioButton) cp5.getGroup("visRadio");
    rb.activate(vis);
    rb.setValue(vis);
  } else {
    vis = val;  
  }
}

public void check(float[] a) {
  CheckBox cb = (CheckBox) cp5.getGroup("check");
  isColor = cb.getItem(0).getBooleanValue();
  println("check: " + isColor); 
}

void keyTyped() {
  Textfield tf = (Textfield) cp5.getGroup("ui").getController("time");
  if (tf.isFocus()) {
    String text = tf.getText();
    tf.setText(text.replaceAll("[^0-9]",""));
    println("text: " + tf.getText());
    if (tf.getText() == "" || tf.getText() == "0") {
      //tf.setColorBackground(color(3,4,4));  
    } else {
      //tf.setColorBackground(color(120));
    }
  }
  
  //DEBUG
  if (key == 'a') {
    printState(); 
  }
}

void draw() {
  background(0);
  
  if (state == "menu") {
    cp5.show();
  } else if (state == "start") {
    cp5.hide();
  }
}


void controlEvent(ControlEvent theEvent) {
  if(theEvent.isGroup()) {
    println("got an event from group "
            +theEvent.getGroup().getName()
            +", isOpen? "+theEvent.getGroup().isOpen()
            );        
  } else if (theEvent.isController()){
    println("got something from a controller "
            +theEvent.getController().getName()
            );
  }
}

//DEBUG
void printState() {
  println("state: " + state);
  println("vis: " + vis);
  println("time: " + time);
  println("color: " + isColor);
  state = "menu";
}
