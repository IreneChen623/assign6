/*class GameState
{
	static final int START = 0;
	static final int PLAYING = 1;
	static final int END = 2;
}
class Direction
{
	static final int LEFT = 0;
	static final int RIGHT = 1;
	static final int UP = 2;
	static final int DOWN = 3;
}
class EnemysShowingType
{
	static final int STRAIGHT = 0;
	static final int SLOPE = 1;
	static final int DIAMOND = 2;
	static final int STRONGLINE = 3;
}
class FlightType
{
	static final int FIGHTER = 0;
	static final int ENEMY = 1;
	static final int ENEMYSTRONG = 2;
}

int state = GameState.START;
int currentType = EnemysShowingType.STRAIGHT;
int enemyCount = 8;
Enemy[] enemys = new Enemy[enemyCount];
Fighter fighter;
Background bg;
FlameMgr flameMgr;
Treasure treasure;
HPDisplay hpDisplay;

boolean isMovingUp;
boolean isMovingDown;
boolean isMovingLeft;
boolean isMovingRight;

int time;
int wait = 4000;



void setup () {
	size(640, 480);
	flameMgr = new FlameMgr();
	bg = new Background();
	treasure = new Treasure();
	hpDisplay = new HPDisplay();
	fighter = new Fighter(20);
}

void draw()
{
	if (state == GameState.START) {
		bg.draw();	
	}
	else if (state == GameState.PLAYING) {
		bg.draw();
		treasure.draw();
		flameMgr.draw();
		fighter.draw();

		//enemys
		if(millis() - time >= wait){
			addEnemy(currentType++);
			currentType = currentType%4;
		}		

		for (int i = 0; i < enemyCount; ++i) {
			if (enemys[i]!= null) {
				enemys[i].move();
				enemys[i].draw();
				if (enemys[i].isCollideWithFighter()) {
					fighter.hpValueChange(-20);
					flameMgr.addFlame(enemys[i].x, enemys[i].y);
					enemys[i]=null;
				}
				else if (enemys[i].isOutOfBorder()) {
					enemys[i]=null;
				}
			}
		}
		// 這地方應該加入Fighter 血量顯示UI
		
	}
	else if (state == GameState.END) {
		bg.draw();
	}
}
boolean isHit(int ax, int ay, int aw, int ah, int bx, int by, int bw, int bh)
{
	// Collision x-axis?
    boolean collisionX = (ax + aw >= bx) && (bx + bw >= ax);
    // Collision y-axis?
    boolean collisionY = (ay + ah >= by) && (by + bh >= ay);
    return collisionX && collisionY;
}

void keyPressed(){
  switch(keyCode){
    case UP : isMovingUp = true ;break ;
    case DOWN : isMovingDown = true ; break ;
    case LEFT : isMovingLeft = true ; break ;
    case RIGHT : isMovingRight = true ; break ;
    default :break ;
  }
}
void keyReleased(){
  switch(keyCode){
	case UP : isMovingUp = false ;break ;
    case DOWN : isMovingDown = false ; break ;
    case LEFT : isMovingLeft = false ; break ;
    case RIGHT : isMovingRight = false ; break ;
    default :break ;
  }
  if (key == ' ') {
  	if (state == GameState.PLAYING) {
		fighter.shoot();
	}
  }
  if (key == ENTER) {
    switch(state) {
      case GameState.START:
      case GameState.END:
        state = GameState.PLAYING;
		enemys = new Enemy[enemyCount];
		flameMgr = new FlameMgr();
		treasure = new Treasure();
		fighter = new Fighter(20);
      default : break ;
    }
  }
}*/

PImage bg1,bg2;
PImage start1,start2;
PImage end1,end2;
PImage fighter;
PImage enemy;
PImage boss;
PImage hp;
PImage treasure;
PImage shoot;
PImage []flames= new PImage[5];
PFont scoreText;

int bg;
int blood;
int fighterX,fighterY;
int speed=5;
int treasureX,treasureY;
int score=0;

//shoot bullets
boolean shooting=true;
int []shootX = {-20,-40,-60,-80,-100,-120};
int []shootY = {-10,-10,-10,-10,-10,-10};

//all for enemy
int enemyState;
final int enemyTeam1=1;
final int enemyTeam2=2;
final int enemyTeam3=3;
int [] enemyDefTeam1X={-10,-90,-170,-250,-330};
int [] enemyDefTeam1Y={0,0,0,0,0};
int [] enemyTeam1X={-10,-90,-170,-250,-330};
int [] enemyTeam1Y={0,0,0,0,0};
int enemyTeam1Yrandom=floor(random(40,400));
int [] enemyDefTeam2X={-10,-90,-170,-250,-330};
int [] enemyDefTeam2Y={20,60,100,140,180};
int [] enemyTeam2X={-10,-90,-170,-250,-330};
int [] enemyTeam2Y={20,60,100,140,180};
int enemyTeam2Yrandom=floor(random(100,150));
int [] enemyDefTeam3X={-10,-90,-170,-250,-250,-170,-90,-330};
int [] enemyDefTeam3Y={200,120,40,120,280,340,280,200};
int [] enemyTeam3X={-10,-90,-170,-250,-250,-170,-90,-330};
int [] enemyTeam3Y={200,120,40,120,280,340,280,200};
int enemyTeam3Yrandom=floor(random(0,100));
int ix=-10;
//all for enemy

boolean isHit(int ax,int ay,int aw,int ah,int bx,int by,int bw,int bh)
{
  if(bx > ax-aw && bx < ax+aw && by > ay-ah && by < ay+ah){
    return (true);
  }
  else
    return(false);
}

int gameState;
final int gameStart=1;
final int gameRun=2;
final int gameOver=3;

boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

void setup(){
  size(640,480);

  bg1 = loadImage("img/bg1.png");
  bg2 = loadImage("img/bg2.png");
  hp = loadImage("img/hp.png");
  fighter = loadImage("img/fighter.png");
  enemy = loadImage("img/enemy.png");
  boss = loadImage("img/enemy2.png");
  treasure = loadImage("img/treasure.png");
  start1 = loadImage("img/start1.png");
  start2 = loadImage("img/start2.png");
  end1 = loadImage("img/end1.png");
  end2 = loadImage("img/end2.png");
  shoot = loadImage("img/shoot.png");
  for(int i=0; i<5; i++){
    flames[i] = loadImage ("img/flame"+(i+1)+".png");
  }
  scoreText = createFont("Arial",20);

  blood=80;
  fighterX=width-50;
  fighterY=height/2;
  treasureX=floor(random(100,500));
  treasureY=floor(random(80,400));
  
  gameState=1;
  enemyState=1;
}

void draw(){
  
  switch(gameState){
    
    case gameStart:
      image(start1,0,0);
      if(mouseX>200 && mouseX<450){
        if(mouseY>380 && mouseY<420){
          if(mousePressed){
          gameState=2;
      }else{
        image(start2,0,0);
          }
        }
      }
      break;
      
    case gameRun:
    
     //background
     image(bg2,bg,0);
     image(bg1,bg-640,0);
     image(bg2,bg-1280,0);
     bg++;
     bg%=1280;
     
     //hp
     fill(#FF0000);
     rect(20,15,blood,15);
     image(hp,10,10);
     
     //score
     textFont(scoreText,30);
     textAlign(LEFT);
     fill(255);
     text("Score:" + score ,10,450);
      
     //fighter
     image(fighter,fighterX,fighterY);
     
     //shoot bullets     
     for(int i=0;i<5;i++){
       image(shoot,shootX[i],shootY[i]);
       shootX[i]-=10;
     }
     
     if(keyPressed && key ==' '){
       if(shooting==true){
         for(int i=0;i<5;i++){
           if(shootX[i]<0){
             shootX[i]=fighterX;
             shootY[i]=fighterY;
           }
         }
       }
     }
     
       //fighter moving
       if (upPressed) {
         fighterY -= speed;
       }
       if (downPressed) {
         fighterY += speed;
       }
       if (leftPressed) {
         fighterX -= speed;
       }
       if (rightPressed) {
         fighterX += speed;
       }
   
       //fighter boundary detection
       if (fighterX > width-50) {
         fighterX = width-50;
       }
       if (fighterX < 0) {
         fighterX = 0;
       }
       if (fighterY > height-50) {
         fighterY = height-50;
       }
       if (fighterY < 0) {
         fighterY = 0;
       }
     
     //treasure
     image(treasure,treasureX,treasureY);
     if(isHit(treasureX,treasureY,treasure.width,treasure.height,fighterX,fighterY,fighter.width,fighter.height)==true){
        blood += 20;
        if(blood>=200){
          blood=200;
        }
        treasureX=floor(random(100,500));
        treasureY=floor(random(80,400));
      }
      
  
    switch(enemyState){
      case enemyTeam1:      
      
      for(int i=0; i<enemyTeam1X.length; i++){
        image(boss,enemyTeam1X[i],enemyTeam1Y[i]+enemyTeam1Yrandom);
        enemyTeam1X[i]+=5;
        if(enemyTeam1X[enemyTeam1X.length-1]>width+330){
          enemyTeam1Yrandom=floor(random(40,400));
          for (int j=0;j<enemyTeam1X.length;j++){
            enemyTeam1X[j]=enemyDefTeam1X[j];     
            enemyTeam1Y[j]=enemyDefTeam1Y[j];
            enemyState=2;
          }
          
        }
        if(isHit(fighterX,fighterY,fighter.width,fighter.height,enemyTeam1X[i],enemyTeam1Y[i]+enemyTeam1Yrandom,enemy.width,enemy.height)==true){          
          image(flames[i],enemyTeam1X[i],enemyTeam1Y[i]+enemyTeam1Yrandom);
          enemyTeam1X[i]=700;
          enemyTeam1Y[i]=700;
          blood -= 50;    
        }
        if(isHit(shootX[i],shootY[i],shoot.width,shoot.height,enemyTeam1X[i],enemyTeam1Y[i]+enemyTeam1Yrandom,enemy.width,enemy.height)==true){
          image(flames[i],enemyTeam1X[i],enemyTeam1Y[i]+enemyTeam1Yrandom);
          enemyTeam1X[i]=700;
          enemyTeam1Y[i]=700;
          shootX[i]=-800;
          shootY[i]=-800;
          score += 20;
        }
        
        if(blood<=0){
          gameState=3;
        }
      }
      break;
      
      case enemyTeam2:
      
      for(int j=0; j<enemyTeam2X.length; j++){
        image(enemy,enemyTeam2X[j],enemyTeam2Y[j]+enemyTeam2Yrandom);
        enemyTeam2X[j]+=5;
        
        if(enemyTeam2X[enemyTeam2X.length-1]>width+330){
          enemyTeam2Yrandom=floor(random(100,150));
          for (int k=0;k<enemyTeam1X.length;k++){
            enemyTeam2X[k]=enemyDefTeam2X[k];     
            enemyTeam2Y[k]=enemyDefTeam2Y[k];
            enemyState=3;
          }
        }
        
        if(isHit(fighterX,fighterY,fighter.width,fighter.height,enemyTeam2X[j],enemyTeam2Y[j]+enemyTeam2Yrandom,enemy.width,enemy.height)==true){
          image(flames[j],enemyTeam2X[j],enemyTeam2Y[j]+enemyTeam2Yrandom);
          enemyTeam2X[j]=700;
          enemyTeam2Y[j]=700;
          blood -= 20;
          }
        if(isHit(shootX[j],shootY[j],shoot.width,shoot.height,enemyTeam2X[j],enemyTeam2Y[j]+enemyTeam2Yrandom,enemy.width,enemy.height)==true){
          image(flames[j],enemyTeam2X[j],enemyTeam2Y[j]+enemyTeam2Yrandom);
          enemyTeam2X[j]=700;
          enemyTeam2Y[j]=700;
          shootX[j]=700;
          shootY[j]=700;
          score += 20;
        }
        if(blood<=0){
          gameState=3;
        }
      }
      break;
      
      case enemyTeam3:
      
      for(int k=0; k<enemyTeam3X.length; k++){
        image(enemy,enemyTeam3X[k],enemyTeam3Y[k]+enemyTeam3Yrandom);
        enemyTeam3X[k]+=5;
        
        if(enemyTeam3X[enemyTeam3X.length-1]>width+330){
          enemyTeam3Yrandom=floor(random(0,100));
          for (int l=0;l<enemyTeam3X.length;l++){
            enemyTeam3X[l]=enemyDefTeam3X[l];     
            enemyTeam3Y[l]=enemyDefTeam3Y[l];
            enemyState=1;
          }
        }
        
        if(isHit(fighterX,fighterY,fighter.width,fighter.height,enemyTeam3X[k],enemyTeam3Y[k]+enemyTeam3Yrandom,enemy.width,enemy.height)==true){
          if(k<5){
            image(flames[k],enemyTeam3X[k],enemyTeam3Y[k]+enemyTeam3Yrandom);
            shootX[k]=700;
            shootY[k]=700;
          }
          enemyTeam3X[k]=700;
          enemyTeam3Y[k]=700;
          blood -= 20;
        }
        if(k<5){
        if(isHit(shootX[k],shootY[k],shoot.width,shoot.height,enemyTeam3X[k],enemyTeam3Y[k]+enemyTeam3Yrandom,enemy.width,enemy.height)==true){  
          image(flames[k],enemyTeam3X[k],enemyTeam3Y[k]+enemyTeam3Yrandom);
            enemyTeam3X[k]=700;
            enemyTeam3Y[k]=700;
          }
        }
        if(blood<=0){
          gameState=3;
        }
      }
      break;
    }
    
    break;
    
    case gameOver:
     
       image(end1,0,0);
       if(mouseX>200 && mouseX<450){
        if(mouseY>300 && mouseY<340){
          if(mousePressed){
            gameState=2;
            enemyState=1;
            score=0;
            blood=80;
            fighterX=width-50;
            fighterY=height/2;            
        }else{
          image(end2,0,0);
            }
          }
        }
       break;
  }
}

void keyPressed() {
  if (key == CODED) { // detect special keys 
    switch (keyCode) {
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
    }
  }
}

void keyReleased() {
  if (key == CODED) {
    switch (keyCode) {
      case UP:
        upPressed = false;
        break;
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }
  }
}
