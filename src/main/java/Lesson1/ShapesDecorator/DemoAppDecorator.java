package Lesson1.ShapesDecorator;

import Lesson1.ShapesDecorator.components.Circle;
import Lesson1.ShapesDecorator.components.Square;
import Lesson1.ShapesDecorator.components.Star;
import Lesson1.ShapesDecorator.components.Triangle;
import Lesson1.ShapesDecorator.decorators.BorderWidthDecorator;
import Lesson1.ShapesDecorator.decorators.ColorDecorator;

public class DemoAppDecorator {

    public static void main(String[] args) {

        System.out.println("\n===== Single Circle without decoration");
        new Circle(10,10,5, "Single Circle").draw();

        System.out.println("\n===== Yellow Square");
        new ColorDecorator(new Square(10, 10, 5, "Yellow Square"), "yellow").draw();

        System.out.println("\n===== Red star with border of 10px");
        new BorderWidthDecorator(new ColorDecorator(new Star(15, 15, 7, "Red Star"), "red"), 10).draw();

        System.out.println("\n===== Red star with border of 5px (change decoration order)");
        new ColorDecorator(new BorderWidthDecorator(new Star(15, 15, 7, "Red Star"), 5), "red").draw();

        System.out.println("\n===== Triangle with border of 3px");
        new BorderWidthDecorator(new Triangle(50, 50, 3, 4, 5, "Triangle"), 5).draw();
    }
}

/* РЕЗУЛЬТАТ (консоль):
===== Single Circle without decoration
Drawing Single Circle with center point at [10, 10] and radius of 5

===== Yellow Square
Drawing Yellow Square with center point at [10, 10] and side of 5
Color: yellow

===== Red star with border of 10px
Drawing Red Star with center point at [15, 15] and radius of 7
Color: red
Border width: 10px

===== Red star with border of 5px (change decoration order)
Drawing Red Star with center point at [15, 15] and radius of 7
Border width: 5px
Color: red

===== Triangle with border of 3px
Drawing Triangle with start point at [50, 50] and sides of 3, 4 and 5
Border width: 5px

*/