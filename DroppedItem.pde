class DroppedItem extends GameObject {
  int type;
  Weapon w;
  
  DroppedItem (float x, float y, int rx, int ry) {
    type = GUN;
    w = new ShotGun();
    hp=1;
    location = new PVector (x, y);
    velocity = new PVector (0, 0);
    size = 20;
    roomX = rx;
    roomY = ry;
    c = ipurple;
    
    
    
  }
  
  void show () {
    stroke (black);
    strokeWeight (2);
    fill(c);
    circle (location.x, location.y, size);
    
    
    
    
  }
  
  void act () {
   //do nothing, not evem get shot or move 
    
    
  }
  
  
}
