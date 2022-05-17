package Lesson1.ShapesDecorator.decorators;

import Lesson1.ShapesDecorator.components.Shape;

public class BorderWidthDecorator extends ShapeDecorator {

    int width;

    public BorderWidthDecorator(Shape decoratedShape, int width) {
        super(decoratedShape);
        this.width = width;
    }

    @Override
    public void draw() {
        decoratedShape.draw();
        setBorder(decoratedShape, width);
    }

    private void setBorder(Shape decoratedShape, int width){
        System.out.println("Border width: " + width + "px");
    }
}
