import cc.arduino.*;
import org.firmata.*;

import processing.serial.*;  //library
import net.java.games.input.*; //library
import org.gamecontrolplus.*; //library
import org.gamecontrolplus.gui.*; //library
import cc.arduino.*; //library
import org.firmata.*; //library
ControlDevice cont; //object from the class: ControlDevice
ControlIO control;  //object from the class: ControlIO
Arduino arduino;    //object from the class: Arduino
float data; //variable contains the values of analog variation from joystick
//the next line control pins of each motor driver
int m1_pwm=3,m1_dir=2,m2_pwm=5,m2_dir=4,m3_pwm=6,m3_dir=7,m4_pwm=9,m4_dir=8,m5_pwm=10,m5_dir=12,m6_pwm=11,m6_dir=13,gripp=14,m_fwd=1,m_bwd=0;
void forward(int speed)
{ // function to move forward takes the speed
  arduino.analogWrite(m1_pwm, speed); //access the arduino class and control using pwm
  arduino.digitalWrite(m1_dir, m_fwd); //access the arduino class and control using direction
  arduino.analogWrite(m2_pwm, speed);
  arduino.digitalWrite(m2_dir, m_fwd);
  arduino.analogWrite(m3_pwm, speed);
  arduino.digitalWrite(m3_dir, m_fwd);
  arduino.analogWrite(m4_pwm, speed);
  arduino.digitalWrite(m4_dir, m_bwd);
  arduino.analogWrite(m5_pwm, 0);
  arduino.digitalWrite(m5_dir, m_fwd);
  arduino.analogWrite(m6_pwm, 0);
  arduino.digitalWrite(m6_dir, m_fwd);
  println(speed);
  println("forward");
}
void backward(int speed)
{  // function to move backward takes the speed
  arduino.analogWrite(m1_pwm, speed);
  arduino.digitalWrite(m1_dir, m_bwd);
  arduino.analogWrite(m2_pwm, speed);
  arduino.digitalWrite(m2_dir, m_bwd);
  arduino.analogWrite(m3_pwm, speed);
  arduino.digitalWrite(m3_dir, m_bwd);
  arduino.analogWrite(m4_pwm, speed);
  arduino.digitalWrite(m4_dir, m_fwd);
  arduino.analogWrite(m5_pwm, 0);
  arduino.digitalWrite(m5_dir, m_fwd);
  arduino.analogWrite(m6_pwm, 0);
  arduino.digitalWrite(m6_dir, m_fwd);
   println(speed);
  println("backward");
}
void rotate_r(int speed)
{  // function to rotate right takes the speed
  arduino.analogWrite(m1_pwm, speed);
  arduino.digitalWrite(m1_dir, m_fwd);
  arduino.analogWrite(m2_pwm, speed);
  arduino.digitalWrite(m2_dir, m_bwd);
  arduino.analogWrite(m3_pwm, speed);
  arduino.digitalWrite(m3_dir, m_fwd);
  arduino.analogWrite(m4_pwm, speed);
  arduino.digitalWrite(m4_dir, m_fwd);
  arduino.analogWrite(m5_pwm, 0);
  arduino.digitalWrite(m5_dir, m_fwd);
  arduino.analogWrite(m6_pwm, 0);
  arduino.digitalWrite(m6_dir, m_fwd);
   println(speed);
  println("right");
}
void rotate_l(int speed)
{  // function to rotate left takes the speed
  arduino.analogWrite(m1_pwm, speed);
  arduino.digitalWrite(m1_dir, m_bwd);
  arduino.analogWrite(m2_pwm, speed);
  arduino.digitalWrite(m2_dir, m_fwd);
  arduino.analogWrite(m3_pwm, speed);
  arduino.digitalWrite(m3_dir, m_bwd);
  arduino.analogWrite(m4_pwm, speed);
  arduino.digitalWrite(m4_dir, m_bwd);
  arduino.analogWrite(m5_pwm, 0);
  arduino.digitalWrite(m5_dir, m_fwd);
  arduino.analogWrite(m6_pwm, 0);
  arduino.digitalWrite(m6_dir, m_fwd);
   println(speed);
  println("left");
}
void up()
{  // function to move Up with full speed
  arduino.analogWrite(m1_pwm, 0);
  arduino.digitalWrite(m1_dir, m_fwd);
  arduino.analogWrite(m2_pwm, 0);
  arduino.digitalWrite(m2_dir, m_fwd);
  arduino.analogWrite(m3_pwm, 0);
  arduino.digitalWrite(m3_dir, m_bwd);
  arduino.analogWrite(m4_pwm, 0);
  arduino.digitalWrite(m4_dir, m_bwd);
  arduino.analogWrite(m5_pwm, 255);
  arduino.digitalWrite(m5_dir, m_bwd);
  arduino.analogWrite(m6_pwm, 255);
  arduino.digitalWrite(m6_dir, m_fwd);
  println("up");
}
void down()
{  // function to move down with full speed
  arduino.analogWrite(m1_pwm, 0);
  arduino.digitalWrite(m1_dir, m_fwd);
  arduino.analogWrite(m2_pwm, 0);
  arduino.digitalWrite(m2_dir, m_fwd);
  arduino.analogWrite(m3_pwm, 0);
  arduino.digitalWrite(m3_dir, m_bwd);
  arduino.analogWrite(m4_pwm, 0);
  arduino.digitalWrite(m4_dir, m_bwd);
  arduino.analogWrite(m5_pwm, 255);
  arduino.digitalWrite(m5_dir, m_fwd);
  arduino.analogWrite(m6_pwm, 255);
  arduino.digitalWrite(m6_dir, m_bwd);
  println("down");
}
void break_it()
{  // function to stop
  arduino.analogWrite(m1_pwm, 0);
  arduino.digitalWrite(m1_dir, m_fwd);
  arduino.analogWrite(m2_pwm, 0);
  arduino.digitalWrite(m2_dir, m_fwd);
  arduino.analogWrite(m3_pwm, 0);
  arduino.digitalWrite(m3_dir, m_bwd);
  arduino.analogWrite(m4_pwm, 0);
  arduino.digitalWrite(m4_dir, m_bwd);
  arduino.analogWrite(m5_pwm, 0);
  arduino.digitalWrite(m5_dir, m_bwd);
  arduino.analogWrite(m6_pwm, 0);
  arduino.digitalWrite(m6_dir, m_bwd);
  println("break");
}
void motion(float speed,char dir)
{ // function to determine the direction and calculate the speed and send it to the moving functions
  speed =(speed*255)/5;
int v=(int) speed;
  if(dir=='f')
    forward(v);
  else if(dir=='b')
    backward(v);
  else if(dir=='r')
    rotate_r(v);
  else if(dir=='l')
    rotate_l(v);
  else if(dir=='u')
    up();
  else if(dir=='d')
    down();
  else
    break_it();

}

void setup() {
  //intialiation of the processing program
  size(360, 200);
  control = ControlIO.getInstance(this);
  cont = control.getMatchedDevice("RovLog"); //file that contains the configuration of joystick

  if (cont == null) {
    println("not today chump"); // write better exit statements than me
    System.exit(-1);
  }
  // println(Arduino.list());
  arduino = new Arduino(this, Arduino.list()[0], 57600); //determines the port of arduino
 //next lines initilaize pins as outputs
  arduino.pinMode(2, Arduino.OUTPUT);
  arduino.pinMode(3, Arduino.OUTPUT);
  arduino.pinMode(4, Arduino.OUTPUT);
  arduino.pinMode(5, Arduino.OUTPUT);
  arduino.pinMode(6, Arduino.OUTPUT);
  arduino.pinMode(7, Arduino.OUTPUT);
  arduino.pinMode(8, Arduino.OUTPUT);
  arduino.pinMode(9, Arduino.OUTPUT);
  arduino.pinMode(10, Arduino.OUTPUT);
  arduino.pinMode(11, Arduino.OUTPUT);
  arduino.pinMode(12, Arduino.OUTPUT);
  arduino.pinMode(13, Arduino.OUTPUT);
 arduino.pinMode(14, Arduino.OUTPUT);
 arduino.pinMode(15, Arduino.OUTPUT);
 arduino.pinMode(16, Arduino.OUTPUT);
 arduino.pinMode(17, Arduino.OUTPUT);
 arduino.pinMode(18, Arduino.OUTPUT);
 arduino.pinMode(19, Arduino.OUTPUT);
 
}
void draw() {
  //getUserInput();
  //background(thumb,100,255);
  //arduino.servoWrite(10, (int)thumb);
  
 /*arduino.analogWrite(14, 1023);
 arduino.digitalWrite(7, Arduino.HIGH);
  arduino.digitalWrite(15, 1);
   arduino.digitalWrite(16, 1);
    arduino.digitalWrite(17, 1);
     arduino.digitalWrite(18, 1);
      arduino.digitalWrite(19, 1);*/
 while(cont.getButton("Gripper").pressed() )
  { //get the value of gripper button and control gripper 
    arduino.digitalWrite(14, 1);
     println("grip on");
  }
  
  { //get the value of gripper button and control gripper 
    arduino.digitalWrite(14, 0);
     println("grip off");
  }
    //next getting values to determine the directions
 if(cont.getSlider("Move").getValue()>=2)
  {  
    data=cont.getSlider("Move").getValue();
    motion(data,'b');
  }
  else if(cont.getSlider("Move").getValue()<=-2)
  {  
    data=(cont.getSlider("Move").getValue())* -1;
    motion(data,'f');
  }
  else if(cont.getSlider("Rotate").getValue()>=2)
  {  
    data=(cont.getSlider("Rotate").getValue());
    motion(data,'r');
  }
  else if(cont.getSlider("Rotate").getValue()<=-2)
  {  
    data=(cont.getSlider("Rotate").getValue())* -1;
    motion(data,'l');
  }
  else if(cont.getHat("Hat").getY()==1)
  {  
    motion(255,'d');
  }
  else if(cont.getHat("Hat").getY()==-1)
  {  
    motion(255,'u');
  }
  else
    motion(0,'x');
  
 
    
}
