class Hero extends GameObject {

  float speed;
  Weapon myWeapon;
  AnimatedGIF currentAction;
  boolean immunity;
  int immunitytimer = 0;
  color c;

  Hero () {
    super();
    speed = 5;
    roomX = 1;
    roomY = 1;
    size = 40;
    hp = 70;
    immunity =false;
    myWeapon = new AutoPistol();
    currentAction = zombieDown;
  }
  void show () {
    fill (blue);
    stroke (black);
    strokeWeight (2);  
    circle (location.x, location.y, size);
    currentAction.show (location.x, location.y, size/1.5, size);
  }

  void act() {
    super.act();

    if (immunity) {
      immunitytimer++;
    }

    if (immunitytimer >100) {
      immunity = false;
      immunitytimer =0;
      c = dark;
    }
    if (wkey) velocity.y =-speed;
    if (akey) velocity.x =-speed;
    if (skey) velocity.y =speed;
    if (dkey) velocity.x = speed;

    if (velocity.mag () >speed)
      velocity.setMag(speed);

    if (!wkey && !skey) velocity.y =velocity.y* 0.8;
    if (!akey && !dkey) velocity.x =velocity.x* 0.8;


    //check exits
    if (abs(velocity.y) >abs (velocity.x)) {
      if (velocity.y >0) currentAction = zombieDown;
      else currentAction = zombieUp;
    } else {
      if (velocity.x >0) currentAction = zombieRight;
      else currentAction = zombieLeft;
    }



    //north
    if (northRoom != #FFFFFF && location.y == height *0.1 && location.x >= width/2-50 && location.x <= width/2+50) {
      roomY--;
      location = new PVector(width/2, height *0.9-10);
    }
    if (southRoom != #FFFFFF && location.y == height *0.9 && location.x >= width/2-50 && location.x <= width/2+50) {
      roomY++;
      location = new PVector(width/2, height *0.1+10);
    }
    if (eastRoom != #FFFFFF && location.x == width *0.9 && location.y >= height/2-50 && location.y <= height/2+50) {
      println("??");
      roomX++;
      location = new PVector(width*0.1+10, height/2);
    }
    if (westRoom != #FFFFFF && location.x == width *0.1 && location.y >= height/2-50 && location.x <= height/2+50) {
      roomX--;
      location = new PVector(width*0.9-10, height/2);
    }
    myWeapon.update();
    if (spacekey) {
      println("blah");
      myWeapon.shoot();
    }

    int i =0;
    while (i <myObjects.size()) {
      GameObject obj = myObjects.get(i);
      if (obj instanceof Enemy && isCollidingWith(obj)) {
        hp = hp - int (obj.velocity.mag());
        obj.hp = 0;
      }
      if (obj instanceof DroppedItem && isCollidingWith(obj)) {
        DroppedItem item = (DroppedItem) obj;
        if (item.type == GUN) {
          myWeapon = item.w;
          item.hp=0;
        }
      }
      i++;
    }
  }
}
