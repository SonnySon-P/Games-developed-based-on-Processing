import java.util.ArrayList;

int Berry_X = 400;
int Berry_Y = 300;
Integer[][] Snake_Position = new Integer[2][200];
Integer[][] Temp_Snake_Position = new Integer[2][200];
int Count = 3;
char Direction_of_Movement = 'L';
int Starting_Time;

void setup()
{
  size(800, 600);
  Snake_Position[0][0] = 500;
  Snake_Position[1][0] = 300;
  Snake_Position[0][1] = 520;
  Snake_Position[1][1] = 300;
  Snake_Position[0][2] = 540;
  Snake_Position[1][2] = 300;
  Snake_Position[0][3] = 560;
  Snake_Position[1][3] = 300;
  Starting_Time = millis();
}

void draw()
{
  background(255, 255, 148);
  KeyPressed();
  for (int i = 0; i <= Count; i++) 
  {
      DrawSnake(Snake_Position[0][i], Snake_Position[1][i]);
  }
  DrawBerry(Berry_X, Berry_Y);
  Collision();
  Eat();
  ShowText_Time();
  delay(200);
}

void DrawSnake(int Snake_X, int Snake_Y)
{
  fill(255, 255, 255);
  rectMode(RADIUS);
  rect(Snake_X, Snake_Y, 10, 10);
}

void DrawBerry(int Berry_X, int Berry_Y)
{
    fill(255, 99, 71);
    ellipse(Berry_X, Berry_Y, 10, 10);
}

void KeyPressed()
{
  Updata_Position();
  boolean IsPressed = false;
  if (keyPressed) 
  {
    if (key == 'w' && Direction_of_Movement != 'T') 
    {
      Snake_Position[1][0] = Snake_Position[1][0] - 20;
      Movement();
      Direction_of_Movement = 'T';
      IsPressed = true;
    }
    else if (key == 'd' && Direction_of_Movement != 'R')
    {
      Snake_Position[0][0] = Snake_Position[0][0] + 20;
      Movement();
      Direction_of_Movement = 'R';
      IsPressed = true;
    }
    else if (key == 's' && Direction_of_Movement != 'B') 
    {
      Snake_Position[1][0] = Snake_Position[1][0] + 20;
      Movement();
      Direction_of_Movement = 'B';
      IsPressed = true;
    }
    else if (key == 'a' && Direction_of_Movement != 'L') 
    {
      Snake_Position[0][0] = Snake_Position[0][0] - 20;
      Movement();
      Direction_of_Movement = 'L';
      IsPressed = true;
    }
  }
  if (IsPressed == false)
  {
    if (Direction_of_Movement == 'T')
    {
      Snake_Position[1][0] = Snake_Position[1][0] - 20;
      Movement();
    }
    else if (Direction_of_Movement == 'R')
    {
      Snake_Position[0][0] = Snake_Position[0][0] + 20;
      Movement();
    }
    else if (Direction_of_Movement == 'B')
    {
      Snake_Position[1][0] = Snake_Position[1][0] + 20;
      Movement();
    }
    else if (Direction_of_Movement == 'L')
    {
      Snake_Position[0][0] = Snake_Position[0][0] - 20;
      Movement();
    }
  }
}

void Updata_Position()
{
  for (int i = 0; i <= Count; i++) 
  { 
    Temp_Snake_Position[0][i] = Snake_Position[0][i];
    Temp_Snake_Position[1][i] = Snake_Position[1][i];
  }
}

void Movement()
{
  for (int i = 1; i <= Count; i++) 
  {      
    Snake_Position[0][i] = Temp_Snake_Position[0][i-1];
    Snake_Position[1][i] = Temp_Snake_Position[1][i-1];
  }
}

void Collision()
{
  if (Snake_Position[0][0] <= 10 || Snake_Position[0][0] >= 790 || Snake_Position[1][0] <= 10 || Snake_Position[1][0] >= 590)
  {
    ShowText_End();
  }
  for (int i = 1; i <= Count; i++) 
  {      
    if (Snake_Position[0][0] == Snake_Position[0][i] && Snake_Position[1][0] == Snake_Position[1][i])
    {
      ShowText_End();
    }
  }
}

void Eat()
{
  if (Snake_Position[0][0] == Berry_X && Snake_Position[1][0] == Berry_Y)
  {
    Count = Count + 1;
    Snake_Position[0][Count] = Temp_Snake_Position[0][Count - 1];
    Snake_Position[1][Count] = Temp_Snake_Position[1][Count - 1];
    Berry_X = (int)((Math.random() * 0.8 + 0.1) * 40) * 20;
    Berry_Y = (int)((Math.random() * 0.8 + 0.1) * 30) * 20;
  }
}

void ShowText_Time()
{
  textAlign(CENTER, CENTER);
  int New_Time = millis();
  String string = "Elapsed Time: " + Integer.toString((New_Time - Starting_Time) / 1000) + " Sec" + "      " + "Score: " + Integer.toString(Count - 3);
  fill(0, 0, 0);
  textSize(20);
  text(string, 400, 10);
}

void ShowText_End()
{
  noLoop();
  textAlign(CENTER, CENTER);
  String string = "Game Over";
  fill(0, 102, 153);
  textSize(40);
  text(string, 400, 300);
}
