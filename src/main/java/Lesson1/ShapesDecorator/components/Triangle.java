package Lesson1.ShapesDecorator.components;

public class Triangle extends Shape {
    int x, y;
    int sideA, sideB, sideC;

    public Triangle(int x, int y, int sideA, int sideB, int sideC, String title) {
        super.shapeTitle = title;
        this.x = x;
        this.y = y;
        this.sideA = sideA;
        this.sideB = sideB;
        this.sideC = sideC;
    }

    @Override
    public void draw() {
        System.out.println("Drawing " + shapeTitle + " with start point at [" + x + ", " + y + "] and sides of " + sideA + ", " + sideB + " and " + sideC);
    }
}
