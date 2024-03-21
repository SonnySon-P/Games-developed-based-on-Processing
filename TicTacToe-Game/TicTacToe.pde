int[][] board = new int[3][3];

void setup()
{
  size(400, 400);
  initial();
}

void draw()
{
  background(189, 255, 189);
  drawRect();
  drawResult();
}

void initial()
{
  for (int i = 0; i < 3; i++) 
  {
    for (int j = 0; j < 3; j++)
    {
      board[i][j] = 0;
    }
  }
}

void drawRect()
{
  fill(255, 255, 255);
  rectMode(RADIUS);
  for (int i = 100; i < 400 - 50; i = i + 100) 
  {
    for (int j = 100; j < 400 - 50; j = j + 100)
    {
      rect(i, j, 50, 50);
    }
  }
}

void drawResult()
{
  textAlign(CENTER, CENTER);
  textSize(35);
  String string = "";
  for (int i = 0; i < 3; i++) 
  {
    for (int j = 0; j < 3; j++)
    {
        if (board[i][j] == 1)
        {
          fill(92, 173, 173);
          string = "X";
          text(string, i * 100 + 100, j * 100 + 100);
        }
        else if (board[i][j] == 2)
        {
          fill(255, 221, 51);
          string = "O";
          text(string, i * 100 + 100, j * 100 + 100);
        }      
    }
  }
}

int[] minMax(int[][] tempBoard, int[] nextCoordinates, int playerID, int type)
{
  int[] returnResult = new int[3];
  
  int[][] tempTempBoard = new int[3][3];
  for (int i = 0; i < 3; i++) 
  {
    for (int j = 0; j < 3; j++)
    {
        tempTempBoard[i][j] = tempBoard[i][j];
    }
  }
  
  if (type != 1)
  {
    returnResult[0] = nextCoordinates[0];
    returnResult[1] = nextCoordinates[1];
    tempTempBoard[nextCoordinates[0]][nextCoordinates[1]] = playerID;
    
    int count = 0;
    for (int i = 0; i < 3; i++) 
    {
      for (int j = 0; j < 3; j++)
      {
        if (tempTempBoard[i][j] != 0)
        {
          count = count + 1;
        }
      }
    }
    if (count == 9)
    {
      returnResult[2] = 0;
      return returnResult;
    }
    
    int WinConditionID = checkWinCondition(tempTempBoard, playerID);
    if (WinConditionID != 0 && playerID == 1) 
    {
      returnResult[2] = -10;
      return returnResult;
    } 
    else if (WinConditionID != 0 && playerID == 2) 
    {
      returnResult[2] = 10;
      return returnResult;
    }
  }
  if (playerID == 1)
  {
    returnResult[2] = 1000;
    for (int i = 0; i < 3; i++) 
    {
      for (int j = 0; j < 3; j++)
      {
        if (tempTempBoard[i][j] == 0)
        {
          nextCoordinates[0] = i;
          nextCoordinates[1] = j;  
          int[] tempReturnResult = new int[3];
          tempReturnResult = minMax(tempTempBoard, nextCoordinates, 2, 2);
          if (tempReturnResult[2] < returnResult[2])
          {
            returnResult[0] = tempReturnResult[0];
            returnResult[1] = tempReturnResult[1];
            returnResult[2] = tempReturnResult[2];
          }
          else
          {
            returnResult[0] = nextCoordinates[0];
            returnResult[1] = nextCoordinates[1];
            returnResult[2] = returnResult[2];
          }
        }
      }
    }
  }
  else
  {
    returnResult[2] = -1000;
    for (int i = 0; i < 3; i++) 
    {
      for (int j = 0; j < 3; j++)
      {
        if (tempTempBoard[i][j] == 0)
        {
          nextCoordinates[0] = i;
          nextCoordinates[1] = j;
          int[] tempReturnResult = new int[3];
          tempReturnResult = minMax(tempTempBoard, nextCoordinates, 1, 2);
          if (tempReturnResult[2] > returnResult[2])
          {
            returnResult[0] = tempReturnResult[0];
            returnResult[1] = tempReturnResult[1];
            returnResult[2] = tempReturnResult[2];
          }
          else
          {
            returnResult[0] = nextCoordinates[0];
            returnResult[1] = nextCoordinates[1];
            returnResult[2] = returnResult[2];
          }
        }
      }
    } 
  }

  return returnResult;
}

void ai()
{
  int[] returnResult = new int[3];
  int[] nextCoordinates = new int[2];
  nextCoordinates[0] = -1;
  nextCoordinates[1] = -1;
  returnResult = minMax(board, nextCoordinates, 2, 1);
  board[returnResult[0]][returnResult[1]] = 2;
  int tempValue = checkWin(board, 2);
  //println(returnResult);
}

void mousePressed()
{ 
  if (mouseButton == LEFT)
  {
    if (50 < mouseX && mouseX < 150 && 50 < mouseY && mouseY < 150)
    {
      board[0][0] = 1;
      if (checkWin(board, 1) == 0)
      {
        ai();
      }
    }
    else if (150 < mouseX && mouseX < 250 && 50 < mouseY && mouseY < 150)
    {
      board[1][0] = 1;
      if (checkWin(board, 1) == 0)
      {
        ai();
      }
    }
    else if (250 < mouseX && mouseX < 350 && 50 < mouseY && mouseY < 150)
    {
      board[2][0] = 1;
      if (checkWin(board, 1) == 0)
      {
        ai();
      }
    }
    else if (50 < mouseX && mouseX < 150 && 150 < mouseY && mouseY < 250)
    {
      board[0][1] = 1;
      if (checkWin(board, 1) == 0)
      {
        ai();
      }
    }
    else if (150 < mouseX && mouseX < 250 && 150 < mouseY && mouseY < 250)
    {
      board[1][1] = 1;
      if (checkWin(board, 1) == 0)
      {
        ai();
      }
    }
    else if (250 < mouseX && mouseX < 350 && 150 < mouseY && mouseY < 250)
    {
      board[2][1] = 1;
      if (checkWin(board, 1) == 0)
      {
        ai();
      }
    }
    else if (50 < mouseX && mouseX < 150 && 250 < mouseY && mouseY < 350)
    {
      board[0][2] = 1;
      if (checkWin(board, 1) == 0)
      {
        ai();
      }
    }
    else if (150 < mouseX && mouseX < 250 && 250 < mouseY && mouseY < 350)
    {
      board[1][2] = 1;
      if (checkWin(board, 1) == 0)
      {
        ai();
      }
    }
    else if (250 < mouseX && mouseX < 350 && 250 < mouseY && mouseY < 350)
    {
      board[2][2] = 1;
      if (checkWin(board, 1) == 0)
      {
        ai();
      }
    }
  }
}

int checkWin(int[][] tempBoard, int playerID)
{
  fill(255, 0, 0);
  size(400, 400);
  int WinConditionID = checkWinCondition(tempBoard, playerID);
  if (WinConditionID == 1)
  {
    drawResult();
    showLossOrWin(playerID);
    line(100, 70, 100, 330);
  }
  else if (WinConditionID == 2)
  {
    drawResult();
    showLossOrWin(playerID);
    line(200, 70, 200, 330);
  }
  else if (WinConditionID == 3)
  {
    drawResult();
    showLossOrWin(playerID);
    line(300, 70, 300, 330);
  }
  else if (WinConditionID == 4)
  {
    drawResult();
    showLossOrWin(playerID);
    line(70, 100, 330, 100);
  }
  else if (WinConditionID == 5)
  {
    drawResult();
    showLossOrWin(playerID);
    line(70, 200, 330, 200);
  }
  else if (WinConditionID == 6)
  {
    drawResult();
    showLossOrWin(playerID);
    line(70, 300, 330, 300);
  }
  else if (WinConditionID == 7)
  {
    drawResult();
    showLossOrWin(playerID);
    line(70, 70, 330, 330);
  }
  else if (WinConditionID == 8)
  {
    drawResult();
    showLossOrWin(playerID);
    line(70, 330, 330, 70);
  }
  return WinConditionID;
}

int checkWinCondition(int[][] tempBoard, int playerID)
{
  int WinConditionID = 0;
  if (tempBoard[0][0] == playerID && tempBoard[0][1] == playerID && tempBoard[0][2] == playerID)
  {
    WinConditionID = 1;
  }
  else if (tempBoard[1][0] == playerID && tempBoard[1][1] == playerID && tempBoard[1][2] == playerID)
  {
    WinConditionID = 2;
  }
  else if (tempBoard[2][0] == playerID && tempBoard[2][1] == playerID && tempBoard[2][2] == playerID)
  {
    WinConditionID = 3;
  }
  else if (tempBoard[0][0] == playerID && tempBoard[1][0] == playerID && tempBoard[2][0] == playerID)
  {
    WinConditionID = 4;
  }
  else if (tempBoard[0][1] == playerID && tempBoard[1][1] == playerID && tempBoard[2][1] == playerID)
  {
    WinConditionID = 5;
  }
  else if (tempBoard[0][2] == playerID && tempBoard[1][2] == playerID && tempBoard[2][2] == playerID)
  {
    WinConditionID = 6;
  }
  else if (tempBoard[0][0] == playerID && tempBoard[1][1] == playerID && tempBoard[2][2] == playerID)
  {
    WinConditionID = 7;
  }
  else if (tempBoard[0][2] == playerID && tempBoard[1][1] == playerID && tempBoard[2][0] == playerID)
  {
    WinConditionID = 8;
  }
  return WinConditionID;
}

void showLossOrWin(int playerID)
{
  noLoop();
  textAlign(CENTER, CENTER);
  String string = "";
  if (playerID == 1)
  {
    string = "You Win!";
  } else {
    string = "You Loss!";
  }
  fill(0, 102, 153);
  textSize(40);
  text(string, 200, 200);
}
