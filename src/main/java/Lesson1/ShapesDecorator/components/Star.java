package Lesson1.ShapesDecorator.components;

public class Star extends Shape {
    int x, y, radius;

    public Star(int x, int y, int radius, String title) {
        super.shapeTitle = title;
        this.x = x;
        this.y = y;
        this.radius = radius;
    }

    @Override
    public void draw() {
        System.out.println("Drawing " + shapeTitle + " with center point at [" + x + ", " + y + "] and radius of " + radius);
    }
}
