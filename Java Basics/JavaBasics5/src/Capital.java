public class Capital {

    private String name;
    private int population;
    private float squareMileage;

    public Capital(String name, int population, float squareMileage){
        this.name = name;
        this.population = population;
        this.squareMileage = squareMileage;
    }
    public String getName(){
        return name;
    }

    public int getPop(){
        return population;
    }

    public float getSM(){
        return squareMileage;
    }

}
