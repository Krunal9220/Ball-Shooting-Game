class Bullet {
  PVector pos, vel;
  Bullet(PVector click) {
    pos=new PVector(width/2, height/2);
    vel=new PVector(click.x-width/2, click.y-height/2);
    vel.setMag(bulletVelocity);
  }
  void update() {
    pos.add(vel);
  }
  void display() {
    fill(255);
    noStroke();
    ellipse(pos.x, pos.y, bulletRadius, bulletRadius);
  }
  boolean shouldDelete() {
    if (dist(pos.x, pos.y, width/2, height/2)>max(width, height)) return true;
    return false;
  }
}