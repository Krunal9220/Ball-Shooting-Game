class Enemy {
  PVector pos, vel;
  float radius;
  float r, g, b;
  Enemy() {
    float prob=random(100);
    if (prob<25) { //up
      pos=new PVector(random(0, width), -50);
    } else if (prob<50) { //down
      pos=new PVector(random(0, width), height+50);
    } else if (prob<75) { //right
      pos=new PVector(width+50, random(0, height));
    } else { //left
      pos=new PVector(-50, random(0, height));
    }
    radius=20+random(30); // {20-50}
    float mag=1.5+radius/50;
    vel=new PVector(width/2-pos.x, height/2-pos.y);
    vel.setMag(mag);
    r=random(255);
    g=random(255);
    b=random(255);
  }
  void update() {
    pos.add(vel);
  }
  void display() {
    fill(r, g, b);
    noStroke();
    ellipse(pos.x, pos.y, radius, radius);
  }
  boolean collide(Bullet b) {
    if (dist(pos.x, pos.y, b.pos.x, b.pos.y)<=(radius+bulletRadius)/2) 
      return true;
    return false;
  }
  boolean shouldDelete() {
    radius/=1.5;
    if (radius<20) return true;
    return false;
  }
  boolean attackedGun() {
    if (dist(pos.x, pos.y, width/2, height/2) <= gunRadius/2 + radius/2) return true;
    return false;
  }
}
