class Score {
  private int score;

  SoundFile scoreSound;

  Score() {
    score = 0;
    scoreSound = new SoundFile(Main.this, "score.wav");
  }

  void reset() {
    score = 0;
  }

  void add() {
    score++;
    scoreSound.play();
  }

  void display() {
    fill(0);
    text(score, 263, 143);
    fill(255);
    text(score, 260, 140);
  }
}
