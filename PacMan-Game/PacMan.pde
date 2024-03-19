import java.util.ArrayList;

int[][] Route = new int[800][600];
int[][] Star = new int[800][600];
int[] Pacman_Coordinate = new int[2];
int[][] Halloween_Coordinate = new int[5][3];
int[] Temp_Array = new int[2];
int Starting_Time;
int Score = 0;
String Pacman_Direction = "r";

void setup()
{
  size(800, 600);
  Starting_Time = millis();
}

void draw()
{
  background(122, 122, 122);
  rectMode(RADIUS);
  Draw_Route();
  Draw_Turf();
  Setup_Route();
  if (millis() - Starting_Time <= 100)
  {
    Setup_Star();
    Pacman_Coordinate = Random_Coordinates();
    for (int i = 0; i <= 4; i++) 
    {
      Temp_Array = Random_Coordinates();
      for (int j = 0; j <= 1; j++) 
      {
        Halloween_Coordinate[i][j] = Temp_Array[j];
      }
      Halloween_Coordinate[i][2] = (int)(Math.random() * 4) + 1;
    }
  }
  else if (Score == 130)
  {
    Show_Win_Text();
  }
  else
  {  
    for (int i = 0; i <= 4; i++)
    {
      if (Halloween_Coordinate[i][0] == Pacman_Coordinate[0] && Halloween_Coordinate[i][1] == Pacman_Coordinate[1])
      {
        Show_Loss_Text();
      }
    }
    KeyPressed();
    Draw_Star();
    Eat();
    Show_Pacman(Pacman_Coordinate[0], Pacman_Coordinate[1], Pacman_Direction);
    Draw_Halloween();
  }
  delay(50);
}

void Draw_Route()
{
  fill(0, 0, 0);
  for (int i = 50; i <= 550; i = i + 100) 
  {
      rect(400, i, 350, 20);
  }
  for (int i = 50; i <= 750; i = i + 100) 
  {
      rect(i, 300, 20, 250);
  }
  rect(50, 50, 20, 20);
  rect(750, 50, 20, 20);
  rect(50, 550, 20, 20);
  rect(750, 550, 20, 20);
}

void Draw_Turf()
{
  fill(51, 102, 102);
  rect(200, 400, 30, 30);
  rect(400, 100, 30, 30);
}

void Setup_Route()
{
  for (int i = 0; i < 800; i++) 
  {
    for (int j = 0; j < 600; j++)
    {
      Route[i][j] = 0;
    }
  }
  for (int j = 49; j <= 549; j = j + 100) 
  {
    for (int i = 49; i <= 749; i++)
    {
      Route[i][j] = 1;
    }
  }
  for (int i = 49; i <= 749; i = i + 100) 
  {
    for (int j = 49; j <= 549; j++)
    {
      Route[i][j] = 1;
    }
  }
}

void Setup_Star()
{
  for (int i = 0; i < 800; i++) 
  {
    for (int j = 0; j < 600; j++)
    {
      Star[i][j] = 0;
    }
  }
  for (int j = 49; j <= 549; j = j + 100) 
  {
    for (int i = 49; i <= 749; i = i + 50)
    {
      Star[i][j] = 1;
    }
  }
  for (int i = 49; i <= 749; i = i + 100) 
  {
    for (int j = 49; j <= 549; j = j + 50)
    {
      Star[i][j] = 1;
    }
  }
}

void Show_Pacman(int x, int y, String c)
{
  PImage img;
  if (c == "t")
  {
    img = loadImage("pacman_t.png");
  }
  else if (c == "b")
  {
    img = loadImage("pacman_b.png");
  }
  else if (c == "l")
  {
    img = loadImage("pacman_l.png");
  }
  else
  {
    img = loadImage("pacman_r.png");
  }
  image(img, x - 17, y - 17, 34, 34);
}

void Show_Halloween(int x, int y)
{
  PImage img;
  img = loadImage("halloween.png");
  image(img, x - 17, y - 17, 34, 34);
}

int[] Random_Coordinates()
{
  int[] Array = new int[2];
  Array[0] = 0;
  Array[1] = 0;
  while (Array[0] == 0 && Array[1] == 0) 
  {
    int rx = (int)(Math.random() * 799) + 1;
    int ry = (int)(Math.random() * 599) + 1;
    if (Star[rx - 1][ry - 1] == 1)
    {
      Array[0] = rx;
      Array[1] = ry;
    }
  }
  return Array;
}

void Show_Win_Text()
{
  noLoop();
  textAlign(CENTER, CENTER);
  String string = "You Win";
  fill(0, 102, 153);
  textSize(40);
  text(string, 400, 300);
}

void Show_Loss_Text()
{
  noLoop();
  textAlign(CENTER, CENTER);
  String string = "Game Over";
  fill(0, 102, 153);
  textSize(40);
  text(string, 400, 300);
}

void KeyPressed()
{
  if (keyPressed == true) 
  {
    if (key == 'w') 
    {
      if (Check_Route_1(Pacman_Coordinate[0], Pacman_Coordinate[1], 1) == 1)
      {
        Pacman_Coordinate[1] = Pacman_Coordinate[1] - 10;
        Pacman_Direction = "t";
      }
    }
    else if (key == 'd')
    {
      if (Check_Route_1(Pacman_Coordinate[0], Pacman_Coordinate[1], 2) == 1)
      {
        Pacman_Coordinate[0] = Pacman_Coordinate[0] + 10;
        Pacman_Direction = "r";
      }
    }
    else if (key == 's') 
    {
      if (Check_Route_1(Pacman_Coordinate[0], Pacman_Coordinate[1], 3) == 1)
      {
        Pacman_Coordinate[1] = Pacman_Coordinate[1] + 10;
        Pacman_Direction = "b";
      }
    }
    else if (key == 'a') 
    {
      if (Check_Route_1(Pacman_Coordinate[0], Pacman_Coordinate[1], 4) == 1)
      {
        Pacman_Coordinate[0] = Pacman_Coordinate[0] - 10;
        Pacman_Direction = "l";
      }
    }
  }
}

void Eat()
{
  if (Star[Pacman_Coordinate[0] - 1][Pacman_Coordinate[1] - 1] == 1) 
  {
    Star[Pacman_Coordinate[0] - 1][Pacman_Coordinate[1] - 1] = 0;
    Score = Score + 1;
  }
}

void Draw_Star()
{
  fill(255, 186, 117);
  for (int i = 0; i < 800; i++) 
  {
    for (int j = 0; j < 600; j++)
    {
      if (Star[i][j] == 1) 
      {
        ellipse(i, j, 8, 8);
      }
    }
  }
}

int Check_Route_1(int x, int y, int d)
{
  int result = 0;
  if (d == 1) 
  {
    if (Route[x - 1][y - 10 - 1] == 1 && y - 10 - 1 >= 0)
    {
      result = 1;
    }
  }
  else if (d == 2)
  {
    if (Route[x + 10 - 1][y - 1] == 1 && x + 10 - 1 <= 799)
    {
      result = 1;
    }
  }
  else if (d == 3) 
  {
    if (Route[x - 1][y + 10 - 1] == 1 && y + 10 - 1 <= 599)
    {
      result = 1;
    }
  }
  else if (d == 4) 
  {
    if (Route[x - 10 - 1][y - 1] == 1 && x - 10 - 1 >= 0)
    {
      result = 1;
    }
  }
  return result;
}

int Check_Route_2(int x, int y, int d)
{
  int result = 0;
  if (d == 1) 
  {
    if (Route[x - 1][y - 25 - 1] == 1)
    {
      result = 1;
    }
  }
  else if (d == 2)
  {
    if (Route[x + 25 - 1][y - 1] == 1)
    {
      result = 1;
    }
  }
  else if (d == 3) 
  {
    if (Route[x - 1][y + 25 - 1] == 1)
    {
      result = 1;
    }
  }
  else if (d == 4) 
  {
    if (Route[x - 25 - 1][y - 1] == 1)
    {
      result = 1;
    }
  }
  return result;
}

void Draw_Halloween()
{
  for (int i = 0; i <= 4; i++) 
  {
    ArrayList<Integer> Check_List = new ArrayList<Integer>();
    if (Check_Route_1(Halloween_Coordinate[i][0], Halloween_Coordinate[i][1], 1) == 1 && Halloween_Coordinate[i][2] != 3)
    {
      Check_List.add(1);
    }
    if (Check_Route_1(Halloween_Coordinate[i][0], Halloween_Coordinate[i][1], 2) == 1 && Halloween_Coordinate[i][2] != 4)
    {
      Check_List.add(2);
    }
    if (Check_Route_1(Halloween_Coordinate[i][0], Halloween_Coordinate[i][1], 3) == 1 && Halloween_Coordinate[i][2] != 1)
    {
      Check_List.add(3);
    }
    if (Check_Route_1(Halloween_Coordinate[i][0], Halloween_Coordinate[i][1], 4) == 1 && Halloween_Coordinate[i][2] != 2)
    {
      Check_List.add(4);
    }
    int Index = (int)(Math.random() * Check_List.size());
    int d = Check_List.get(Index); 
    Halloween_Coordinate[i][2] = d;    
    if (d == 1) 
    {
      Halloween_Coordinate[i][1] = Halloween_Coordinate[i][1] - 10;
    }
    else if (d == 2)
    {
      Halloween_Coordinate[i][0] = Halloween_Coordinate[i][0] + 10;
    }
    else if (d == 3) 
    {
      Halloween_Coordinate[i][1] = Halloween_Coordinate[i][1] + 10;
    }
    else if (d == 4) 
    {
      Halloween_Coordinate[i][0] = Halloween_Coordinate[i][0] - 10;
    }
    Show_Halloween(Halloween_Coordinate[i][0], Halloween_Coordinate[i][1]);
  }
}
