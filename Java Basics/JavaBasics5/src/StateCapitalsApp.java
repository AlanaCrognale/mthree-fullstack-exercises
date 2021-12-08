import java.util.*;
import java.io.*;

public class StateCapitalsApp {

    public static void main(String[] args) throws Exception{

        Map<String,Capital> sc = new HashMap<>();
        Scanner s = new Scanner(new BufferedReader(new FileReader("MoreStateCapitals.txt")));
        Scanner in = new Scanner(System.in);
        int numLines = 0;

        //read data from text file and add to hashmap
        while (s.hasNextLine()){
            String line = s.nextLine();
            String[] vals = line.split("::");
            Capital curCapital = new Capital(vals[1],Integer.parseInt(vals[2]),Float.parseFloat(vals[3]));
            sc.put(vals[0],curCapital);
            numLines++;
        }

        //print out num of state capitals loaded
        System.out.println(numLines+" STATE/CAPITAL PAIRS LOADED");

        //print out each state and its capitals name, population, and square milage
        Set<String> keys = sc.keySet();
        for (String k : keys){
            Capital cap = sc.get(k);
            String name = cap.getName();
            int pop = cap.getPop();
            float sm = cap.getSM();
            System.out.println(k+" - "+name+" | Pop: "+pop+" | Area: "+sm+" sq mi");
        }

        //ask user for a population limit
        System.out.println("Please enter the lower limit for capital city population: ");
        int minPop = Integer.parseInt(in.nextLine());

        //print all states/capitals w population > limit
        System.out.println("LISTING CAPITALS WITH POPULATIONS GREATER THAN "+minPop);

        for (String k : keys){
            Capital cap = sc.get(k);
            String name = cap.getName();
            int pop = cap.getPop();
            float sm = cap.getSM();
            if (pop>minPop) {
                System.out.println(k + " - " + name + " | Pop: " + pop + " | Area: " + sm + " sq mi");
            }
        }

        //ask user for an area limit
        System.out.println("Please enter the upper limit for capital city sq mileage: ");
        float maxSM = Float.parseFloat(in.nextLine());

        //print all states/capitals w area < limit
        System.out.println("LISTING CAPITALS WITH AREAS LESS THAN "+maxSM);

        for (String k : keys){
            Capital cap = sc.get(k);
            String name = cap.getName();
            int pop = cap.getPop();
            float sm = cap.getSM();
            if (sm<maxSM) {
                System.out.println(k + " - " + name + " | Pop: " + pop + " | Area: " + sm + " sq mi");
            }
        }
    }
}
