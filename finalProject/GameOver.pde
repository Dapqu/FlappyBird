class GameOver {
  PVector gameOverPosition;

  boolean okHovered;
  boolean shareHovered;

  GameOver(float x, float y) {
    gameOverPosition = new PVector(x, y);
    
    okHovered = false;
    shareHovered = false;
  }

  void draw() {
    mouseUpdate();
    
    // Game-over text
    image(gameOverImgs[0], gameOverPosition.x, gameOverPosition.y);
    // Score board
    //image(gameOverImgs[1], gameOverPosition.x - 35, gameOverPosition.y + 90);
    // OK button
    image(gameOverImgs[2], gameOverPosition.x - 19, gameOverPosition.y + 415);
    // Share button
    image(gameOverImgs[3], gameOverPosition.x + 221, gameOverPosition.y + 415);
  }

  // Check mouse interaction
  void mouseUpdate() {
    if (hoveringOK(gameOverPosition.x - 19, gameOverPosition.y + 415, 150, 53)) {
      okHovered = true;
      shareHovered = false;
    } else if (hoveringShare(gameOverPosition.x + 221, gameOverPosition.y + 415, 150, 53)) {
      shareHovered = true;
      okHovered = false;
    } else {
      okHovered = false;
      shareHovered = false;
    }
  }

  // If the mouse is hovering over OK button, return true.
  boolean hoveringOK(float x, float y, int width, int height) {
    if (mouseX >= x && mouseX <= x + width &&
      mouseY >= y && mouseY <= y + height) {
      return true;
    } else {
      return false;
    }
  }

  // If the mouse is hovering over Share button, return true.
  boolean hoveringShare(float x, float y, int width, int height) {
    if (mouseX >= x && mouseX <= x + width &&
      mouseY >= y && mouseY <= y + height) {
      return true;
    } else {
      return false;
    }
  }
}
