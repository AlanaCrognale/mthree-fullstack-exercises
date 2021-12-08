package org.example;

import java.util.Random;
import java.util.Scanner;

class Hero {
    private int maxHealth, health, attack, defense, gold, level, steps, goblinsSlain;
    private int[] potions;

    public Hero() {
        Random rand = new Random();
        this.maxHealth = rand.nextInt(11) + 20; //between 20 to 30
        this.health = this.maxHealth;
        this.attack = rand.nextInt(3) + 1;//between 1 to 3
        this.defense = rand.nextInt(5) + 1;//between 1 to 5
        this.gold = 0;
        this.level = 1;
        this.steps = 0;
        this.goblinsSlain = 0;
        this.potions = new int[5];
    }

    public int getAttack() {
        return this.attack;
    }

    public int getDefense() {
        return this.defense;
    }

    public int getHealth() {
        return this.health;
    }

    public int getGold() {
        return this.gold;
    }

    public int getLevel() {
        return this.level;
    }

    public int getPotions() {
        int result = 0;
        for (int i = 0; i < this.potions.length; i++) {
            if (potions[i] == 2) {
                result++;
            }
        }
        return result;
    }

    public int getGoblinsSlain(){
        return this.goblinsSlain;
    }

    public void setHealth(int n) {
        this.health += n;
    }

    public void setGold(int n) {
        this.gold += n;
    }

    public void setGoblinsSlain(int n){
        this.goblinsSlain+=n;
    }


    public boolean step(){//takes one step, returns whether a goblin was reached, level up if necessary
        Scanner in = new Scanner(System.in);
        this.steps++;
        if (steps == 10) {//level up
            this.steps = 0;
            this.level++;
            System.out.println("Congrats, you've leveled up! You are now level " +this.level);
            System.out.println("Would you like to buy a potion for 4 gold? Y/N");
            String result = in.nextLine();
            if (result.equals("Y")){
                if (this.gold<4){
                    System.out.println("Sorry, you only have "+this.gold+" gold, that's not enough for another potion. Slay more goblins to get more gold!");
                }
                else if (getPotions()>=5){
                    System.out.println("Sorry, you are already carrying the max number of potions. Use one in your next fight!");
                }
                else{
                    buyPotion();
                    System.out.println("You now have "+getPotions()+" potions!");
                }
            }
            else{
                System.out.println("No potions bought, let's keep going.");
            }
            return false;//for simplicity, say no goblin will ever be encountered on 10th step
        }
        Random rand = new Random();
        return rand.nextBoolean();
    }

    public void buyPotion() {
        for (int i = 0; i < this.potions.length; i++) {
            if (this.potions[i] != 2) {
                this.potions[i] = 2;
                this.gold -= 4;
                break;
            }
        }
    }

    public void usePotion() {
        for (int i = 0; i < this.potions.length; i++) {
            if (this.potions[i] == 2) {
                this.potions[i] = 0;

                if (this.health + 2 <= this.maxHealth) {
                    this.health += 2;
                } else {
                    this.health = this.maxHealth;
                }
                break;
            }
        }
    }

    public void restart() { //reset everything except for gold
        Random rand = new Random();
        this.maxHealth = rand.nextInt(11) + 20; //between 20 to 30
        this.health = this.maxHealth;
        this.attack = rand.nextInt(3) + 1;//between 1 to 3
        this.defense = rand.nextInt(5) + 1;//between 1 to 5
        this.level = 1;
        this.steps = 0;
        this.goblinsSlain = 0;
        this.potions = new int[5];
    }
}

class Goblin{
    private int health, attack, defense;

    public Goblin(){
        Random rand = new Random();
        this.health = rand.nextInt(6)+5; //between 5 to 10
        this.attack = rand.nextInt(2)+2;//between 2 to 3
        this.defense = rand.nextInt(2)+1;//between 1 to 2
    }

    public int getAttack(){
        return this.attack;
    }

    public int getDefense(){
        return this.defense;
    }

    public int getHealth(){
        return this.health;
    }

    public void setHealth(int n){
        this.health+=n;
    }
}

public class App 
{

    static void attack(Hero h, Goblin g){
        Random rand = new Random();
        int surprise = rand.nextInt(2); //0 or 1
        if (h.getAttack()>=g.getDefense() || surprise == 1){
            System.out.println("Nice attack! Goblin's health -1");
            g.setHealth(-1);
        }
        else{
            System.out.println("Your attack missed.");
        }
    }

    static void defend(Hero h, Goblin g){
        Random rand = new Random();
        int surprise = rand.nextInt(2); //0 or 1
        if (h.getDefense()<g.getAttack() || surprise == 1){
            h.setHealth(-1);
            System.out.println("Oh no, the goblin attacked you! You now have "+h.getHealth()+" health points left.");
        }
        else{
            System.out.println("The goblin missed!");
        }
    }

    public static void main( String[] args )
    {
        Scanner in = new Scanner(System.in);
        System.out.println( "Welcome to Goblin Tower!" );
        Goblin g = new Goblin();

        Hero h = new Hero();

        System.out.println("Your initial stats are as follows: ");
        System.out.println("health: "+h.getHealth());
        System.out.println("attack: "+h.getAttack());
        System.out.println("defense: "+h.getDefense());
        System.out.println("gold: "+h.getGold());
        System.out.println("level: "+h.getLevel());
        System.out.println("number of potions: "+h.getPotions());
        System.out.println("number of goblins slain: "+h.getGoblinsSlain());

        //take step
        System.out.println("Press any key to take a step.");
        String result = in.nextLine();

        boolean walking = true;
        boolean playing = true;
        boolean fighting = false;
        while (playing){
            while (walking) {
                boolean goblinEnc = h.step();

                if (goblinEnc == false) {
                    System.out.println("You have safely taken one step. Press any key to take another.");
                    result = in.nextLine();
                } else {
                    walking = false;
                    System.out.println("You've encountered a goblin!!");
                    g = new Goblin();
                    System.out.println("This goblin has the following stats:");
                    System.out.println("health: " + g.getHealth());
                    System.out.println("attack: " + g.getAttack());
                    System.out.println("defense: " + g.getDefense());
                    fighting = true;
                }
            }

            while (fighting) {
                System.out.println("Would you like to attack (A) or use a health potion? (H)");
                result = in.nextLine();
                if (result.equals("A")) {
                    attack(h, g);
                } else if (result.equals("H")) {
                    int numPotions = h.getPotions();
                    if (numPotions < 1) {
                        System.out.println("You don't have any potions, sorry.");
                    } else {
                        h.usePotion();
                        System.out.println("You drank a health potion. Now you have " + h.getHealth() + " health points left.");
                    }
                } else {
                    System.out.println("That was not a valid response..you're going to attack!");
                    attack(h, g);
                }

                if (g.getHealth() <= 0) {
                    System.out.println("Congrats, you've slain the goblin! You have earned 2 gold. Now let's keep going. Press any key to continue");
                    result = in.nextLine();
                    h.setGoblinsSlain(1);
                    h.setGold(2);
                    fighting = false;
                    walking = true;
                    break;
                }

                System.out.println("The goblin is preparing to attack you!");
                defend(h, g);

                if (h.getHealth() <= 0) {
                    System.out.println("Oh no, you've died! :( Do you want to play again? Y/N");
                    result = in.nextLine();
                    fighting = false;
                    walking = true;
                    if (result.equals("Y")) {
                        h.restart();
                        System.out.println("Your new stats are as follows: ");
                        System.out.println("health: "+h.getHealth());
                        System.out.println("attack: "+h.getAttack());
                        System.out.println("defense: "+h.getDefense());
                        System.out.println("gold: "+h.getGold());
                        System.out.println("level: "+h.getLevel());
                        System.out.println("number of potions: "+h.getPotions());
                        System.out.println("number of goblins slain: "+h.getGoblinsSlain());

                    } else {
                        playing = false;
                        System.out.println("Game over! You reached level "+h.getLevel()+" and slayed "+h.getGoblinsSlain()+" goblins");
                    }
                }
            }
        }
    }
}
