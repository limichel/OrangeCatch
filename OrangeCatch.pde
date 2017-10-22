ArrayList <Orange> oranges;
Cat cat;
PImage catLeft;
PImage catRight;
int score = 0;
int lives = 0;
boolean gameOver = false;

void setup()
{
	size(700, 700);
	background(188, 242, 255);
	cat = new Cat(width/2, 475);
	catLeft = loadImage("kitty.png");
	catRight = loadImage("kitty2.png");
	oranges = new ArrayList<Orange>();
	for(int i = 0; i < 5; i++)
		oranges.add(new Orange((int)(Math.random() * 700), (int)(Math.random() * -150)));
}

void draw()
{
	background(188, 242, 255);
	stroke(108, 222, 120);
	strokeWeight(1);
	fill(116, 242, 128);
	for(int x = 0; x < 700; x += 20) //grass blades (long)
		triangle(x, 550, x + 10, 550, x + 5, 500);
	for(int x = 10; x < 700; x += 20) //grass blades (short)
		triangle(x, 550, x + 10, 550, x + 5, 520);
	noStroke();
	rect(0, 550, 700, 150); //grass area
	fill(108, 222, 120);
	rect(0, 690, 700, 10); //grass "shading"
	textSize(20);
	fill(255);
	text("Score: " + score, 25, 675); // display score
	cat.show();
	for(int i = 0; i < oranges.size(); i++)
	{
		oranges.get(i).show();
		if(get(oranges.get(i).getX() + 11, oranges.get(i).getY() + 11) == color(92, 52, 34))
		{
			score++;
			oranges.remove(i);
			oranges.add(new Orange((int)(Math.random() * 700), (int)(Math.random() * -150)));
		}
		if(!gameOver)
			oranges.get(i).fall();
	}
}

void keyPressed()
{
	if(keyCode == LEFT)
	{
		cat.changeDirection("left");
		cat.move();
	}
	else if(keyCode == RIGHT)
	{
		cat.changeDirection("right");
		cat.move();
	}
}

class Orange
{
	private int myX, myY, speed;
	public Orange(int x, int y)
	{
		myX = x;
		myY = y;
		speed = (int)(Math.random() * 3 + 1);
	}
	public void show()
	{
		noStroke();
		fill(255, 159, 48);
		ellipse(myX, myY, 20, 20);
		fill(255, 187, 108);
		ellipse(myX + 4, myY - 4, 4, 4);
		stroke(59, 199, 54);
		strokeWeight(3);
		point(myX, myY - 10);
	}
	public void fall()
	{
		myY += speed;
		if(myY > 710)
		{
			myX = (int)(Math.random() * 700);
			myY = -10;
			speed = (int)(Math.random() * 3 + 1);
		}
	}
	public int getX()
	{
		return myX;
	}
	public int getY()
	{
		return myY;
	}
}

class Cat
{
	private int myX, myY;
	private String direction;
	public Cat(int x, int y)
	{
		myX = x;
		myY = y;
		direction = "left";
	}
	public void show()
	{
		if(direction.equals("left"))
		{
			image(catLeft, myX, myY);
			fill(106, 57, 34); //basket
			ellipse(myX + 50, myY + 10, 60, 20);
			ellipse(myX + 50, myY + 15, 55, 20);
			ellipse(myX + 50, myY + 20, 50, 20);
			// ellipse(myX + 50, myY + 23, 45, 20);
			fill(92, 52, 34);
			ellipse(myX + 50, myY + 5, 70, 20);
		}
		else if(direction.equals("right"))
		{
			image(catRight, myX, myY);
			fill(106, 57, 34); //basket
			ellipse(myX + 85, myY + 10, 60, 20);
			ellipse(myX + 85, myY + 15, 55, 20);
			ellipse(myX + 85, myY + 20, 50, 20);
			ellipse(myX + 85, myY + 23, 45, 20);
			fill(92, 52, 34);
			ellipse(myX + 85, myY + 5, 70, 20);
		}
	}
	public void move()
	{
			if(direction.equals("left") && myX >= -50)
				myX -= 10;
			else if(direction.equals("right") && myX <= 650)
				myX += 10;
	}
	public void changeDirection(String dir)
	{
		if(dir == "left")
			direction = "left";
		else if(dir == "right")
			direction = "right";
	}
}