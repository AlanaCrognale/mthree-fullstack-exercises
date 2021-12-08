import java.util.*;

public class stateCapitals {

    public static void main(String[] args) {

        String[] States = {"Alabama", "Alaska", "Arizona", "Arkansas", "California",
                "Colorado", "Connecticut", "Delaware", "Florida", "Georgia", "Hawaii", "Idaho", "Illinois", "Indiana",
                "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine", "Maryland", "Massachusetts", "Michigan",
                "Minnesota", "Mississippi", "Missouri", "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey",
                "New Mexico", "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon",
                "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee", "Texas", "Utah",
                "Vermont", "Virginia", "Washington", "West Virginia", "Wisconsin", "Wyoming"};

        String[] Capitals = {"Montgomery", "Juneau", "Phoenix", "Little Rock",
                "Sacramento", "Denver", "Hartford", "Dover", "Tallahassee", "Atlanta", "Honolulu", "Boise",
                "Springfield", "Indianapolis", "Des Moines", "Topeka", "Frankfort", "Baton Rouge", "Augusta",
                "Annapolis", "Boston", "Lansing", "St. Paul", "Jackson", "Jefferson City", "Helena", "Lincoln",
                "Carson City", "Concord", "Trenton", "Santa Fe", "Albany", "Raleigh", "Bismarck", "Columbus",
                "Oklahoma City", "Salem", "Harrisburg", "Providence", "Columbia", "Pierre", "Nashville", "Austin",
                "Salt Lake City", "Montpelier", "Richmond", "Olympia", "Charleston", "Madison", "Cheyenne"};

        Map<String, String> sc = new HashMap<>();

        for (int i = 0; i < States.length; i++){
            sc.put(States[i],Capitals[i]);
        }

        System.out.println("STATES: ");

        Set<String> keys = sc.keySet();
        for (String s : keys){
            System.out.println(s);
        }

        System.out.println("CAPITALS: ");

        Collection<String> vals = sc.values();
        for (String s : vals){
            System.out.println(s);
        }

        System.out.println("STATE/CAPITAL PAIRS: ");

        for (String s : keys){
            String c = sc.get(s);
            System.out.println(s+" - "+c);
        }
    }
}
