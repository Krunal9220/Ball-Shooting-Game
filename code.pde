ArrayList<Bullet> Bullets;
ArrayList<Enemy> Enemies;
float bulletVelocity=6;
float bulletRadius=10;
float gunRadius=40;
int time=0;
int score = 0;
int reloadTime=9;
int lastFired=-reloadTime;
int life = 5;
int enemiesOnBoard = 3;
void setup() {
  //fullScreen();
  size(900, 600);
  Bullets=new ArrayList<Bullet>();
  Enemies=new ArrayList<Enemy>();
}
void draw() {
  showStats(false);
  time++;
  drawBG();
  
  addEnemy();
  drawFireGun();
  drawNupdateBullets();
  drawNupdateEnemies();
  deleteExtras();

  collision();
  
  if (life <= 0) {
    endGame();
  }
}
void endGame() {
  background(0);
  showStats(true);
  exit();
}
void showStats(boolean over) {
  fill(255, 0, 0);
  textSize(20);
  text("Life : " + life, 20, 50);
  fill(0, 255, 0);
  text("Your score : "+score, 20, 80);
  if(over) {
    textSize(60);
    fill(255, 0, 0);
    text("Game over", width/3, height/2.5);
  }
}
void drawBG() {
  fill(0, 80);
  rect(0, 0, width, height);
  //background(0,10);
}
void collision() {
  for (int i=0; i<Enemies.size(); i++) {
    if (Enemies.get(i).attackedGun()) {
      Enemies.remove(i);
      --i;
      life--;
      break;
    }
    for (int j=0; j<Bullets.size(); j++) {
      if (Enemies.get(i).collide(Bullets.get(j))) {
        score++;
        if (Enemies.get(i).shouldDelete()) {
          Enemies.remove(i);
          --i;
        }
        Bullets.remove(j);
        --j;
        break;
      }
    }
  }
}
void addEnemy() {
  while (Enemies.size() < enemiesOnBoard) Enemies.add(new Enemy());
}
void drawFireGun() {
  fill(255);
  //if ((time-lastFired)<reloadTime) fill(180, 0, 0);
  ellipse((float)width/2, (float)height/2, gunRadius, gunRadius);
}
void drawNupdateBullets() {
  for (Bullet curr : Bullets) {
    curr.update();
  }
  for (Bullet curr : Bullets) {
    curr.display();
  }
}
void drawNupdateEnemies() {
  for (Enemy curr : Enemies) {
    curr.update();
  }
  for (Enemy curr : Enemies) {
    curr.display();
  }
}
void deleteExtras() {
  for (int i=0; i<Bullets.size(); i++) {
    if (Bullets.get(i).shouldDelete()) {
      Bullets.remove(i);
    }
  }
}
void mousePressed() {
  if ((time-lastFired)<reloadTime) return;
  Bullet newB=new Bullet(new PVector(mouseX, mouseY));
  Bullets.add(newB);
  lastFired=time;
}