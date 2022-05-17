package Lesson1.ShapesDecorator.decorators;

import Lesson1.ShapesDecorator.components.Shape;

public class ColorDecorator extends ShapeDecorator {

    String color;

    public ColorDecorator(Shape decoratedShape, String color) {
        super(decoratedShape);
        this.color = color;
    }

    @Override
    public void draw() {
        decoratedShape.draw();
        setColor(decoratedShape, color);
    }

    private void setColor(Shape decoratedShape, String color){
        System.out.println("Color: " + color);
    }
}
