import processing.sound.*;

// Images
PImage backgroundImg;
PImage floorImg;
PImage[] menuImgs = new PImage[3];
PImage[] birdImgs = new PImage[4];
PImage laserImg;
PImage[] readyImgs = new PImage[3];
PImage[] gameOverImgs = new PImage[4];
PImage[] pipeImgs = new PImage[2];

// Objects
Floor floor;
Menu menu;
Bird bird;
Ready readyScreen;
GameOver gameOver;
ArrayList<Pipe> pipes;
Score score;

// New pipe every 1000 ms
int pipeDelay = 3000;
// Time when last pipe was created
int lastPipeTime = 0;

// Font
PFont pixelFont;

// Game state values:
// 0 = Menu
// 1 = Pre-game
// 2 = Game
// 3 = Post-game
int gameState;

// Easy or Hard mode boolean
boolean easy;

void setup() {
  size(540, 960);
  backgroundImg = loadImage("Background.png");

  floorImg = loadImage("Floor.png");

  menuImgs[0] = loadImage("Flappy Bird.png");
  menuImgs[1] = loadImage("Easy.png");
  menuImgs[2] = loadImage("Hard.png");

  for (int i = 0; i < 4; i++) {
    birdImgs[i] = loadImage("Bird" + i + ".png");
  }

  laserImg = loadImage("Laser.png");

  readyImgs[0] = loadImage("Get Ready.png");
  readyImgs[1] = loadImage("Tap.png");
  readyImgs[2] = loadImage("Spacebar.png");

  gameOverImgs[0] = loadImage("Game Over.png");
  gameOverImgs[1] = loadImage("Score Board.png");
  gameOverImgs[2] = loadImage("OK.png");
  gameOverImgs[3] = loadImage("Share.png");

  pipeImgs[0] = loadImage("Top Pipe.png");
  pipeImgs[1] = loadImage("Bottom Pipe.png");

  floor = new Floor(4);
  menu = new Menu(50, 258);
  bird = new Bird(140, 440);
  readyScreen = new Ready();
  gameOver = new GameOver(94, 258);
  pipes = new ArrayList<Pipe>();
  score = new Score();

  pixelFont = createFont("Minecraft.ttf", 64);
  textFont(pixelFont);
  
  gameState = 0;
  easy = false;
}

void draw() {
  background(backgroundImg);

  // Menu
  if (gameState == 0) {
    menu.draw();
  }

  // Pre-game
  if (gameState == 1) {
    bird.idle();
    readyScreen.draw();
  }

  // Game
  if (gameState == 2) {
    bird.gravity();
    // Pipes moving left
    if (millis() - lastPipeTime > pipeDelay) {
      // Assign randomY position for the new pipe
      float randomY = random((height - floorImg.height) / 2 - pipeImgs[0].height - 230,
        (height - floorImg.height) / 2 - pipeImgs[0].height + 230);
      pipes.add(new Pipe(width + pipeImgs[0].width, randomY, 2, easy));
      lastPipeTime = millis();
    }
    // Pipe logic for display and deletion
    for (Pipe pipe : pipes) {
      pipe.draw();
    }
    // Removing pipes that are out of bound
    for (int i = pipes.size() - 1; i >= 0; i--) {
      if (pipes.get(i).shouldDestroy) {
        pipes.remove(pipes.get(i));
      }
    }
    bird.draw();
    score.display();
  }

  // Post-game
  if (gameState == 3) {
    bird.gravity();
    // Pipe logic for display and deletion
    for (Pipe pipe : pipes) {
      pipe.draw();
    }
    // Removing pipes that are out of bound
    for (int i = pipes.size() - 1; i >= 0; i--) {
      if (pipes.get(i).shouldDestroy) {
        pipes.remove(pipes.get(i));
      }
    }
    bird.draw();
    score.display();
    gameOver.draw();
  }
  floor.draw();
}

void mouseClicked() {
  // Menu mousePressed logics
  if (gameState == 0) {
    if (menu.easyHovered) {
      easy = true;
      gameState = 1;
    }
    if (menu.hardHovered) {
      easy = false;
      gameState = 1;
    }
  }

  // Post-game mousePressed logics
  if (gameState == 3) {
    if (gameOver.okHovered) {
      gameState = 0;
      bird.reset();
      score.reset();
      pipes.clear();
    }
    if (gameOver.shareHovered) {
      println("Work in Progress");
    }
  }
}

void mousePressed() {
  if (gameState == 1) {
    gameState = 2;
    bird.jump();
  } else if (gameState == 2) {
    bird.jump();
  }
}

void keyPressed() {
  if (gameState == 2) {
    if (key == ' ' && !easy) {
      bird.shoot();
    }
  }
}
