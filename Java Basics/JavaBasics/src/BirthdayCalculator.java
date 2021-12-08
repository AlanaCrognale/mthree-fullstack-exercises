import java.util.*;
import java.time.*;
import java.time.format.*;
import java.time.temporal.ChronoUnit;

public class BirthdayCalculator {

    public static void main(String[] args) {

        Scanner in = new Scanner(System.in);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM-dd-yyyy");
        boolean notValid = true;
        LocalDate bd = LocalDate.now();

        System.out.println("What is your birthday?");

        while (notValid) {
            try {
                String b = in.nextLine();
                bd = LocalDate.parse(b, formatter);
                notValid = false;
            } catch (DateTimeParseException e) {
                System.out.println("Please enter in format MM-DD-YYYY");
            }
        }

        DayOfWeek bornDOW = bd.getDayOfWeek();
        System.out.println("That means you were born on a "+bornDOW+"!");

        int curYear = LocalDate.now().getYear();
        LocalDate bdNext = bd.withYear(curYear);
        DayOfWeek curDOW = bdNext.getDayOfWeek();
        System.out.println("This year it falls on a "+curDOW+"...");

        System.out.println("And since today is "+LocalDate.now().format(formatter)+",");

        int yearAdjustor = bdNext.compareTo(LocalDate.now());

        if (yearAdjustor<0){//next birthday is next year, i.e. birthday this year already happened
            bdNext = bdNext.withYear(curYear+1);
        }

        long daysUntil = LocalDate.now().until(bdNext,ChronoUnit.DAYS);
        int newAge = bdNext.getYear()-bd.getYear();
        System.out.println("there are "+daysUntil+" more days until the next one when you turn "+newAge+"!");
    }
}
