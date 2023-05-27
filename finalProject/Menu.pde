class Menu {
  PVector titlePosition;
  Bird menuBird;

  // Properties for idle movement (Flappy Bird Title)
  float idleY;
  float angle;

  // Start and Score button's hovering status
  boolean easyHovered;
  boolean hardHovered;

  // Takes in initial x and y position of the title text
  Menu(float x, float y) {
    menuBird = new Bird(430, 270);
    titlePosition = new PVector(x, y);
    
    easyHovered = false;
    hardHovered = false;
  }

  void draw() {
    mouseUpdate();

    // Calculate idle Y position using a sine wave
    idleY = titlePosition.y + (12 * sin(radians(angle)));
    // Display the bouncing title text
    image(menuImgs[0], titlePosition.x, idleY);
    // Increase the angle for the next frame of animation
    angle += 7;

    // Display Start and Score button
    image(menuImgs[1], titlePosition.x + 25, titlePosition.y + 415);
    image(menuImgs[2], titlePosition.x + 265, titlePosition.y + 415);

    // Display idle bird next to title text
    menuBird.idle();
  }

  // Check mouse interaction
  void mouseUpdate() {
    if (hoveringStart(titlePosition.x + 25, titlePosition.y + 415, 150, 53)) {
      easyHovered = true;
      hardHovered = false;
    } else if (hoveringScore(titlePosition.x + 265, titlePosition.y + 415, 150, 53)) {
      hardHovered = true;
      easyHovered = false;
    } else {
      easyHovered = false;
      hardHovered = false;
    }
  }

  // If the mouse is hovering over Start button, return true.
  boolean hoveringStart(float x, float y, int width, int height) {
    if (mouseX >= x && mouseX <= x + width &&
      mouseY >= y && mouseY <= y + height) {
      return true;
    } else {
      return false;
    }
  }

  // If the mouse is hovering over Score button, return true.
  boolean hoveringScore(float x, float y, int width, int height) {
    if (mouseX >= x && mouseX <= x + width &&
      mouseY >= y && mouseY <= y + height) {
      return true;
    } else {
      return false;
    }
  }
}
