import java.util.ArrayList;
int xUser = 500;
int yUser = 300;
ArrayList <Integer>xObstacle = new ArrayList();
ArrayList <Integer>yObstacle = new ArrayList();
int Time = 0;
int Count = 0;
int i = 0;
int Temp = -1;
int Move = 0;

void setup()
{
  size(1000, 600);
}

void draw()
{
  background(255, 255, 148);
  DrawRect(xUser, yUser + Move, 0);
  Termination();
  KeyPressed();
  if (Math.random() > 0.5 && Time % 20 == 0)
  {
    xObstacle.add(1000);
    yObstacle.add((int)((Math.random() - 0.5) * 200) + 300);
  }
  Temp = -1;
  for (int i = 0; i < xObstacle.size(); i++) 
  {
    if (xObstacle.get(i) + 5 <= 0) {
      Temp = i;
    } else {
      xObstacle.set(i, xObstacle.get(i) - 5);
    }
  }
  if (Temp != -1)
  {
    xObstacle.remove(Temp);
    yObstacle.remove(Temp);
  }
  DrawObstacle();
  ShowText(0);
  Time = Time + 1;
  delay(100);
}

void DrawRect(int DxUser, int DyUser, int Cor)
{
  if (Cor == 0)
  {
    fill(255, 255, 255);
    rectMode(RADIUS);
    rect(DxUser, DyUser, 5, 20);
    rect(DxUser, DyUser + 80, 20, 1);
    fill(0, 0, 0);
    rect(DxUser - 100, DyUser - 100, 20, 1);
    rect(DxUser + 100, DyUser - 100, 20, 1);
    fill(255, 255, 255);
    rect(DxUser - 90, DyUser - 70, 10, 10);
    rect(DxUser + 110, DyUser - 70, 10, 10);
    fill(0, 0, 0);
    rect(DxUser - 87.5, DyUser - 67.5, 5, 5);
    rect(DxUser + 112.5, DyUser - 67.5, 5, 5);
  } else if (Cor == 1){
    fill(0, 102, 153);
    rectMode(RADIUS);
    rect(DxUser, DyUser + 80, 30, 30);
  }
}

void DrawObstacle()
{
  for (int i = 0; i < xObstacle.size(); i++) 
  {
    fill(0, 0, 0);
    rectMode(RADIUS);
    rect(xObstacle.get(i), yObstacle.get(i) + 80, 10, 10);
  }
}

void Termination()
{
  if (Time >= 600 && Count == 0)
  {
    noLoop();
    ShowText(2);
  } else if (Time <= 1200 && Count == 10){
    noLoop();
    ShowText(1);
  }
}

void KeyPressed()
{
  if (keyPressed) 
  {
    if (key == 'w') 
    {
      i = 0;
      Temp = -1;
      for (int i = 0; i < xObstacle.size(); i++) 
      {
        if ((xUser - 15 <= xObstacle.get(i) - 5) && (xUser + 15 >= xObstacle.get(i) - 5))
        {      
          if (((yUser + Move - 15 <= yObstacle.get(i) - 5) && (yUser + Move + 15 >= yObstacle.get(i) - 5))  || ((yUser + Move - 15 <= yObstacle.get(i) + 5) && (yUser + Move + 15 >= yObstacle.get(i) + 5)))
          {   
            Temp = xObstacle.indexOf(xObstacle.get(i));
            Count = Count + 1;
            ShowText(0);
          }
        }
        if ((xUser - 15 <= xObstacle.get(i) + 5) && (xUser + 15 >= xObstacle.get(i) + 5))
        {      
          if (((yUser + Move - 15 <= yObstacle.get(i) - 5) && (yUser + Move + 15 >= yObstacle.get(i) - 5))  || ((yUser + Move - 15 <= yObstacle.get(i) + 5) && (yUser + Move + 15 >= yObstacle.get(i) + 5)))
          {   
            Temp = xObstacle.indexOf(xObstacle.get(i));
            Count = Count + 1;
            ShowText(0);
          }
        }
      }
      if (Temp != -1) 
      {
        xObstacle.remove(Temp);
        yObstacle.remove(Temp);
      }
      DrawRect(xUser, yUser + Move, 1);
    }
    if (key == 'o') 
    {
      Move = Move - 5;
      DrawRect(xUser, yUser + Move, 0);
    }
    if (key == 'l') 
    {
      Move = Move + 5;
      DrawRect(xUser, yUser + Move, 0);
    }
  } 
}

void ShowText(int Typle)
{
  textAlign(CENTER, CENTER);
  if (Typle == 0)
  {   
    String string = "Time: " + str(Time / 10) + " Sec   Fraction: " + str(Count);
    fill(0, 0, 0);
    textSize(15);
    text(string, 500, 20);
  } else if (Typle == 1){
    String string = "Pass";
    fill(0, 102, 153);
    textSize(30);
    text(string, 500, 300);
  } else if (Typle == 2){
    String string = "Game Over";
    fill(0, 102, 153);
    textSize(30);
    text(string, 500, 300);
  }
}
