class Ready {
  Ready() {
  }

  void draw() {
    imageMode(CENTER);
    image(readyImgs[0], width/2, 300);
    image(readyImgs[1], width/2 + 35, 500);
    if (!easy) {
      image(readyImgs[2], width/2, 700);
    }
    imageMode(CORNER);
  }
}
