package Lesson1.BuilderPattern;

public class DemoBuilder {

    public static void main(String[] args) {
        Person person1 = Person.newBuilder()
                .setInnerFirstName("Иванова")
                .setInnerLastName("Иванна")
                .setInnerMiddleName("Ивановна")
                .setInnerCountry("Россия")
                .setInnerAddress("Москва")
                .setInnerPhone("+79999999999")
                .setInnerGender("ж")
                .setInnerAge(25)
                .build();

        Person person2 = Person.newBuilder()
                .setInnerFirstName("Сидоров")
                .setInnerLastName("Сидор")
                .setInnerMiddleName("Сидорович")
                .setInnerCountry("Россия")
                .setInnerGender("м")
                .build();

        System.out.println(person1);
        System.out.println(person2);
    }
}

/* РЕЗУЛЬТАТ (консоль):
Объект: Person@49e4cb85 {firstName='Иванова', lastName='Иванна', middleName='Ивановна', gender='ж', country='Россия', address='Москва', phone='+79999999999', age=25}
Объект: Person@7946e1f4 {firstName='Сидоров', lastName='Сидор', middleName='Сидорович', gender='м', country='Россия', address='null', phone='null', age=0}
*/