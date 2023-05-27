class Pipe {
  float x, topY, bottomY, speedX;
  float[] target = new float[4];

  boolean shouldDestroy;
  boolean shouldOpen;
  boolean scored;

  Pipe(float x, float y, float speed, boolean open) {
    this.x = x;
    topY = y;
    bottomY = y + pipeImgs[0].height;
    speedX = speed;

    shouldDestroy = false;
    shouldOpen = open;
    scored = false;

    // Area for the target to get hit by the laser in order to open up the pipe
    target[0] = x - 10;
    target[1] = x + 10;
    target[2] = y + pipeImgs[0].height - 45;
    target[3] = y + pipeImgs[0].height + 45;
  }

  void draw() {
    if (shouldOpen) {
      image(pipeImgs[0], x, topY - 120);
      image(pipeImgs[1], x, bottomY + 120);
    } else {
      image(pipeImgs[0], x, topY);
      image(pipeImgs[1], x, bottomY);

      // Target area
      pushMatrix();
      noStroke();
      fill(255, 0, 0, 128);
      rect(target[0], target[2], target[1] - target[0], target[3] - target[2]);
      popMatrix();
    }
    move();
    collisionCheck();
  }

  void move() {
    if (gameState == 3) {
      x -= 0;
    } else {
      x -= speedX;
      target[0] -= speedX;
      target[1] -= speedX;
    }
  }

  void collisionCheck() {
    // If the pipe has gone off the screen, destroy it
    if (x + pipeImgs[0].width < 0) {
      shouldDestroy = true;
    }
  }
}
