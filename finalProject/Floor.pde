class Floor {
  float x, speedX;

  Floor(float speed) {
    speedX = speed;
  }

  // Draw two copies of the floor image, one after the other
  // to achieve the illusion of endless movement
  void draw() {
    image(floorImg, x, height - floorImg.height);
    image(floorImg, x + floorImg.width, height - floorImg.height);

    // Move the floor images to the left according to the speed
    if (gameState == 3) {
      x -= 0;
    } else {
      x -= speedX;
    }

    // When the left image goes out of the screen, reset its position
    if (x < -floorImg.width) {
      x = 0;
    }
  }
}
