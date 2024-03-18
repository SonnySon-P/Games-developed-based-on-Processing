import java.util.ArrayList;

int[] Ball_Position = new int[2];
double Angle = 315;
int Moving_Distance = 20;
int Board_X_Position = 300;
int Starting_Time;

void setup()
{
  size(600, 800);
  Ball_Position[0] = 300;
  Ball_Position[1] = 735;
  Starting_Time = millis();
}

void draw()
{
  background(48, 80, 80);
  rectMode(RADIUS);
  Draw_GameZone();
  Loss();
  Collision();
  KeyPressed();
  Draw_Board();
  Draw_Ball();
  ShowText_Time();
  delay(100);
}

void Draw_GameZone()
{
  fill(255, 255, 148);
  rect(300, 410, 280, 370);
}

void Draw_Board()
{
  fill(0, 0, 0);
  rect(Board_X_Position, 725, 40, 5);
}

void Draw_Ball()
{
  Ball_Position();
  fill(255, 99, 71);
  ellipse(Ball_Position[0], Ball_Position[1], 10, 10);
}

void KeyPressed()
{
  if (keyPressed == true) 
  {
    if (key == 'a' || key == 'A')
    {
      if (Board_X_Position >= 70)
      {
        Board_X_Position = Board_X_Position - 20;
      }
    }
    else if (key == 'd' || key == 'D') 
    {
      if (Board_X_Position <= 530)
      {
        Board_X_Position = Board_X_Position + 20;
      }
    }
  }
}

void Collision()
{
  if (Ball_Position[0] >= 570 && 270 <= Angle && Angle < 360)
  {
    Angle = Angle - 90; 
  }
  else if (Ball_Position[0] >= 570 && 0 <= Angle && Angle <= 90)
  {
    Angle = Angle + 90; 
  }
  else if (Ball_Position[1] <= 60 && 180 <= Angle && Angle < 270)
  {
    Angle = Angle - 90; 
  }
  else if (Ball_Position[1] <= 60 && 270 <= Angle && Angle <= 360)
  {
    Angle = (Angle + 90) - 360; 
  }
  else if (Ball_Position[0] <= 30 && 90 <= Angle && Angle < 180)
  {
    Angle = Angle - 90; 
  }
  if (Ball_Position[0] <= 30 && 180 <= Angle && Angle <= 270)
  {
    Angle = Angle + 90; 
  }
  else if (Board_X_Position - 40 <= Ball_Position[0] && Ball_Position[0] <= Board_X_Position + 40 && Ball_Position[1] >= 710 && 0 <= Angle && Angle < 90)
  {
    Angle = 360 + (Angle - 90); 
  }
  else if (Board_X_Position - 40 <= Ball_Position[0] && Ball_Position[0] <= Board_X_Position + 40 && Ball_Position[1] >= 710 && 90 <= Angle && Angle <= 180)
  {
    Angle = Angle + 90; 
  }
}

void Ball_Position()
{
  Ball_Position[0] = (int)(Ball_Position[0] + Moving_Distance * Math.cos(Math.toRadians(Angle)));
  Ball_Position[1] = (int)(Ball_Position[1] + Moving_Distance * Math.sin(Math.toRadians(Angle)));
}

void Loss()
{
  if (Ball_Position[1] >= 780)
  {
    ShowText_End();
  }
}


void ShowText_Time()
{
  textAlign(CENTER, CENTER);
  int New_Time = millis();
  String string = "Elapsed Time: " + Integer.toString((New_Time - Starting_Time) / 1000);
  fill(255, 255, 255);
  textSize(20);
  text(string, 300, 15);
}

void ShowText_End()
{
  noLoop();
  textAlign(CENTER, CENTER);
  String string = "Game Over";
  fill(0, 102, 153);
  textSize(40);
  text(string, 300, 410);
}
