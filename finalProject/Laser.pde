class Laser {
  PVector position;
  float speedX;

  boolean shouldDestroy;

  // Takes in initial x and y position of the object
  Laser(float x, float y) {
    position = new PVector(x, y);
    speedX = 10;

    shouldDestroy = false;
  }

  void draw() {
    image(laserImg, position.x, position.y);
    move();
    collisionCheck();
  }

  void move() {
    position.x += speedX;
  }

  // Check if the laser has hit anything or went out of screen
  void collisionCheck() {
    // If the laser has gone off the screen, destroy it
    if (position. x > width) {
      shouldDestroy = true;
    }

    for (Pipe pipe : pipes) {
      // If the pipe is not open
      if (!pipe.shouldOpen) {
        // If the laser hit the pipe target, open the pipe and destroy the laser
        if (position.x + laserImg.width - 30 >= pipe.target[0]
          && position.x + laserImg.width - 30 <= pipe.target[1]
          && position.y + laserImg.height / 2 >= pipe.target[2]
          && position.y + laserImg.height / 2 <= pipe.target[3]) {
          pipe.shouldOpen = true;
          shouldDestroy = true;
          break;
        }
        // If the laser hit anywhere else on pipe, just destroy the laser
        if (position.x + laserImg.width >= pipe.x + 20
          && position.x + laserImg.width <= pipe.x + pipeImgs[0].width - 20
          && (position.y + laserImg.height / 2 <= pipe.target[2]
          || position.y + laserImg.height / 2 >= pipe.target[3])) {
          shouldDestroy = true;
          break;
        }
      } else {
        // If the pipe is open and the laser hit the top or the bottom pipe, destroy the laser
        if (position.x + laserImg.width >= pipe.x + 20
          && position.x + laserImg.width <= pipe.x + pipeImgs[0].width - 20
          && (position.y + laserImg.height / 2 <= pipe.topY + pipeImgs[0].height - 120
          || position.y + laserImg.height / 2 >= pipe.bottomY + 120)) {
          shouldDestroy = true;
          break;
        }
      }
    }
  }
}
