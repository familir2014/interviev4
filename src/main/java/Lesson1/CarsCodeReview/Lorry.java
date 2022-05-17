package Lesson1.CarsCodeReview;

// наследвоание от абстрактного класса Car и реализация интерфейсов Moveable, Stopable (не указано "implements")
// не реализован абстрактный метод "open"
// @Override (не обязательно, но улучшает стилистику кода, + при изменении интерфейса компилятор сообщит об ошибке)

class Lorry extends Car implements  Moveable, Stopable {

    // расширение видимости метода родительского класса
    @Override
    public void start() {
        super.start();
    }

    @Override
    public void move(){
        System.out.println("Car is moving");
    }

    @Override
    public void stop(){
        System.out.println("Car is stop");
    }

    @Override
    public void open() {

    }
}

