package Lesson1.CarsCodeReview;

// не реализован класс Engine

abstract class Car implements Openable {
    public Engine engine;
    private String color;
    private String name;

    // ограничение области видимости метода (protected) - можно исправить на public, либо публичная реализация у наследников
    protected void start() {
        System.out.println("Car starting");
    }

    public Engine getEngine() {
        return engine;
    }

    public void setEngine(Engine engine) {
        this.engine = engine;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}

