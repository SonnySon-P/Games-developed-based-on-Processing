Integer[][][] BombPosition = new Integer[10][10][2];

void setup()
{
  size(640, 640);
  SpawnBombs();
}

void draw()
{
  background(189, 255, 189);
  DrawRect();
  ShowRectAndText();
  delay(100);
}

void DrawRect()
{
  fill(255, 255, 255);
  rectMode(RADIUS);
  for (int i = 50; i < 640 - 40; i = i + 60) 
  {
    for (int j = 50; j < 640 - 40; j = j + 60)
    {
      rect(i, j, 30, 30);
    }
  }
}

void SpawnBombs()
{
  for (int i = 0; i < 10; i++) 
  {
    for (int j = 0; j < 10; j++)
    {
       BombPosition[i][j][0] = 0;
       BombPosition[i][j][1] = 0;
    }
  }
  for (int i = 0; i < 10; i++) 
  {
    int BombX = (int)(Math.random() * 10);
    int BombY = (int)(Math.random() * 10);
    BombPosition[BombX][BombY][0] = -1;
  }
  for (int i = 0; i < 10; i++) 
  {
    for (int j = 0; j < 10; j++)
    {
      if (BombPosition[i][j][0] != -1) 
      {
        int Count = 0;
        for (int a = -1; a <= 1; a++)
        {
          for (int b = -1; b <= 1; b++)
          {
            if (i + a >= 0 && i + a <= 9 && j + b >= 0 && j + b <= 9)
            {
              if (BombPosition[i + a][j + b][0] == -1)
              {
                Count = Count + 1;
              }
            }
          }
        }
        BombPosition[i][j][0] = Count;
      }
    }
  }
}

void ShowRectAndText()
{
  for (int i = 0; i < 10; i++) 
  {
    for (int j = 0; j < 10; j++)
    {
      String string = "";
      if (BombPosition[i][j][1] == 1)
      {
        fill(189, 255, 189);
        rectMode(RADIUS);
        rect(i * 60 + 50, j * 60 + 50, 30, 30);
        textAlign(CENTER, CENTER);
        textSize(15);
        fill(0, 0, 0);
        string = str(BombPosition[i][j][0]);
        text(string, i * 60 + 50, j * 60 + 50);
      }
      else if (BombPosition[i][j][1] == 2)
      {
        fill(194, 223, 255);
        rectMode(RADIUS);
        rect(i * 60 + 50, j * 60 + 50, 30, 30);
        textAlign(CENTER, CENTER);
        textSize(15);
        fill(255, 0, 0);
        string = "X";
        text(string, i * 60 + 50, j * 60 + 50);
      }
    }
  }
}

void mousePressed( )
{ 
  if (mouseButton == LEFT)
  {
    String string = "";
    BombPosition[(mouseX - 20) / 60][(mouseY - 20) / 60][1] = 1; 
    if (BombPosition[(mouseX - 20) / 60][(mouseY - 20) / 60][0] == -1)
    {
      noLoop();
      for (int i = 0; i < 10; i++) 
      {
        for (int j = 0; j < 10; j++)
        {
          if (BombPosition[i][j][0] == -1 && ((mouseX - 20) / 60 != i && (mouseY - 20) / 60 != j))
          {
            fill(255, 248, 214);
            rectMode(RADIUS);
            rect(i * 60 + 50, j * 60 + 50, 30, 30);
            textAlign(CENTER, CENTER);
            textSize(15);
            fill(255, 0, 0);
            string = "X"; 
            text(string, i * 60 + 50, j * 60 + 50);
          }
        }
      }
      fill(148, 255, 148);
      rectMode(RADIUS);
      rect((mouseX - 20) / 60 * 60 + 50, (mouseX - 20) / 60 * 60 + 50, 30, 30);
      textAlign(CENTER, CENTER);
      textSize(15);
      fill(255, 0, 0);
      string = "X"; 
      text(string, (mouseX - 20) / 60 * 60 + 50, (mouseY - 20) / 60 * 60 + 50);
      string = "Game Over";
      fill(0, 102, 153);
      textSize(30);
      text(string, 320, 320);
    }
  }
  else if (mouseButton == RIGHT)
  {
    if (BombPosition[(mouseX - 20) / 60][(mouseY - 20) / 60][1] == 0)
    {
      BombPosition[(mouseX - 20) / 60][(mouseY - 20) / 60][1] = 2;
    }
    else if (BombPosition[(mouseX - 20) / 60][(mouseY - 20) / 60][1] == 2)
    {
      BombPosition[(mouseX - 20) / 60][(mouseY - 20) / 60][1] = 0; 
    }   
  }
}
