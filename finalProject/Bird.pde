class Bird {
  PVector position;
  float speedY;

  // The collision radius for the bird
  float circleR;

  // Properties for idle movement
  float idleY;
  float angle;

  // Flapping animation properties
  int numFrames = 4;
  int currentFrame = 0;
  // Delay between frames
  int frameDelay = 100;
  // Time of last frame update
  int lastFrame = millis();

  ArrayList<Laser> lasers;

  // Time of last shot
  int lastTimeShot = millis();

  boolean hitTheGround;

  SoundFile flap;
  SoundFile shoot;
  SoundFile crash;
  SoundFile die;

  Bird(float x, float y) {
    position = new PVector(x, y);
    lasers = new ArrayList<Laser>();
    flap = new SoundFile(Main.this, "flap.wav");
    shoot = new SoundFile(Main.this, "shoot.wav");
    crash = new SoundFile(Main.this, "crash.wav");
    die = new SoundFile(Main.this, "die.wav");

    circleR = 21;

    hitTheGround = false;
  }

  void draw() {
    if (gameState != 3) {
      flapping();
    }

    position.y += speedY;

    laserLogic();

    image(birdImgs[currentFrame], position.x, position.y);

    collisionCheck();
  }

  void shoot() {
    // Player can only shoot every half a sec
    if (millis() - lastTimeShot > 1000) {
      lasers.add(new Laser(bird.position.x + 40, bird.position.y + 13));
      shoot.play();
      lastTimeShot = millis();
    }
  }

  void laserLogic() {
    // Shooting logic
    for (Laser laser : lasers) {
      laser.draw();
    }
    // Removing lasers that are either out of bound or hit
    for (int i = lasers.size() - 1; i >= 0; i--) {
      if (lasers.get(i).shouldDestroy) {
        lasers.remove(lasers.get(i));
      }
    }
  }

  // Moves the bird up and down in loop
  void idle() {
    // Calculate idle Y position using a sine wave
    idleY = position.y + (12 * sin(radians(angle)));
    // Display the current bird image
    image(birdImgs[currentFrame], position.x, idleY);

    flapping();

    // Increase the angle for the next frame of animation
    angle += 7;
  }

  void jump() {
    speedY = -10;
    flap.play();
  }

  void gravity() {
    float floorY = height - floorImg.height;
    // Floor collision check
    if (position.y + 45 > floorY) {
      position.y = floorY - 45;
      gameState = 3;
      speedY = 0;
    } else {
      // Gravity value
      speedY += 0.4;
    }

    if (!hitTheGround && gameState == 3 && position.y + 45 > floorY - 45) {
      die.play();
      hitTheGround = true;
    }
  }

  void collisionCheck() {
    for (Pipe pipe : pipes) {
      // If the pipe is not open
      if (!pipe.shouldOpen) {
        // Find the closes point on the pipe to the bird
        float closestX = constrain(position.x + birdImgs[0].width / 2,
          pipe.x, pipe.x + pipeImgs[0].width);
        // Calculate distance between closest point and the bird
        float distance = dist(position.x + birdImgs[0].width / 2,
          position.y + birdImgs[0].height / 2, closestX,
          position.y + birdImgs[0].height / 2);

        if (distance < circleR && gameState != 3) {
          crash.play();
          gameState = 3;
        }
      } else {
        // Find the closes point on the pipe to the bird
        float closestX = constrain(position.x + birdImgs[0].width / 2,
          pipe.x, pipe.x + pipeImgs[0].width);
        // Find the closes point on the top pipe to the bird
        float closestY1 = constrain(position.y + birdImgs[0].height / 2,
          pipe.topY - 120, pipe.topY + pipeImgs[0].height - 120);
        // Find the closes point on the bottom pipe to the bird
        float closestY2 = constrain(position.y + birdImgs[0].height / 2,
          pipe.bottomY + 120, pipe.bottomY + pipeImgs[0].height + 120);
        // Calculate distance between closest top pipe point and the bird
        float distance1 = dist(position.x + birdImgs[0].width / 2,
          position.y + birdImgs[0].height / 2, closestX, closestY1);
        // Calculate distance between closest bottom pipe point and the bird
        float distance2 = dist(position.x + birdImgs[0].width / 2,
          position.y + birdImgs[0].height / 2, closestX, closestY2);

        if ((distance1 < circleR || distance2 < circleR) && gameState != 3) {
          crash.play();
          gameState = 3;
        }
      }

      // Score check
      if (position.x + birdImgs[0].width / 2 > pipe.x + pipeImgs[0].width / 2 && !pipe.scored) {
        pipe.scored = true;
        score.add();
      }
    }
  }

  void flapping() {
    // Update the bird animation frame rate
    if (millis() - lastFrame > frameDelay) {
      // Increment the current frame index and wrap around
      currentFrame = (currentFrame + 1) % numFrames;
      // Update the time of the last frame
      lastFrame = millis();
    }
  }

  void reset() {
    position.x = 140;
    position.y = 440;
    hitTheGround = false;
  }
}
