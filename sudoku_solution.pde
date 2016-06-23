
boolean available[][][] = new boolean[3][10][10];
boolean solution[][][] = new boolean[10][10][10];
int solution_count[][] = new int[10][10];
boolean need_to_solve=true;
int solve_count=0;

void setup() {
  size(400, 400);
  pixelDensity(displayDensity());
  textSize(48);
  textAlign(TOP, LEFT);
  colorMode(HSB, 255);

  while (need_to_solve) {
    println("solve_count=", solve_count);
    need_to_solve = set_state_martrix(solve_count);
    solve_sudoku(solve_count);
    //print_state();
    solve_count+=1;
  }
  save("result.png");
}

void draw() {
}

boolean set_state_martrix(int solve_count) {
  boolean _need_to_solve=false;
  if (solve_count==0) background(205);

  for (int i = 0; i <= 8; i++) {
    if (i%3==0) strokeWeight(5);
    if (solve_count==0) line(0, height*i/9, width, height*i/9);
    for (int j = 0; j <= 8; j++) {
      strokeWeight(0.5);
      if (j%3==0) strokeWeight(5);
      if (solve_count==0) line(width*j/9, 0, width*j/9, height);

      if (sudo[i*9+j]!=0) {
        fill(255);
        if (solve_count==0) text(sudo[i*9+j], width*(j)/9, height*(i+1)/9);
        available[0][i+1][sudo[i*9+j]] = true;
        available[1][j+1][sudo[i*9+j]] = true;
        available[2][(i/3)*3+(j/3)+1][sudo[i*9+j]] = true;
      } else _need_to_solve=true;
    }
  }
  return _need_to_solve;
}

void solve_sudoku(int solve_count) {
  for (int i=0; i<=9; i++)  for (int j=0; j<=9; j++)  solution_count[i][j] = 0;   

  for (int i=1; i<=9; i++) {
    for (int j=1; j<=9; j++) {
      if (sudo[(i-1)*9+j-1] == 0) {
        int temp=0;
        for (int k=1; k<=9; k++) {
          if (available[0][i][k]==available[1][j][k] && available[2][((i-1)/3)*3+(j-1)/3+1][k]==available[0][i][k] && available[1][j][k] == false) {
            solution[i][j][k]=true;
            temp = k;
            solution_count[i][j]+=1;
          }
        }
        if (solution_count[i][j]==1) sudo[(i-1)*9+j-1] = temp;
        if (sudo[(i-1)*9+j-1]!=0) {
          color fill_color = color(solve_count*45, 255, 255);
          fill(fill_color);
          text(sudo[(i-1)*9+j-1], width*(j-1)/9, height*(i)/9);
          available[0][i][temp] = true;
          available[1][j][temp] = true;
          available[2][((i-1)/3)*3+(j-1)/3+1][temp] = true;
        }
      }
    }
  }
}
void print_state() {
  for (int i=0; i<=9; i++) {
    for (int k=0; k<=2; k++) {
      for (int j=0; j<=9; j++) {
        if (i==0 && j==0) print("   ");
        else if (i==0) print(j);
        else if (j==0) print(i, ' ');
        else print(available[k][i][j]?1:0);
      }
      print(' ');
    }
    println();
  }
  println();
  for (int i=0; i<=9; i++) {
    for (int j=0; j<=9; j++) {
      if (i==0 && j==0) print("   ");
      else if (i==0) print(j);
      else if (j==0) print(i, ' ');
      else print(solution_count[i][j]);
    }
    println();
  }
  println();
}