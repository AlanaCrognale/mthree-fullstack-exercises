import java.lang.Math;
import java.time.Year;
import java.util.*;

class PlayerDeck {

    static void shuffle(Card[] cards) {

        int toSwap;
        Card temp;
        int l = cards.length;

        Random rand = new Random();

        for (int i = 0; i < l; i++) {
            toSwap= rand.nextInt(l);
            temp = cards[toSwap];
            cards[toSwap] = cards[i];
            cards[i] = temp;
        }
    }

    static Card[] draw(Card[] cards, int X){

        Card[] drawn = new Card[X];
        int i = 0;
        int j = 0;

        while (i<X && j < cards.length){
            if (cards[j]!=null){
                drawn[i]=cards[j];
                cards[j]=null;
                i++;
            }
            j++;
        }
        return drawn;
    }

    static void play(Card[] cardsToPlay, Card[] discard){

        int l = cardsToPlay.length;
        int j = 0;
        int k = 0;

        System.out.println("Playing cards: ");
        for (int i = 0; i < l; i++){
            System.out.println(cardsToPlay[i].getTitle()+" "+cardsToPlay[i].getDesc());
        }

        while (k<l){
            if (discard[j]==null){
                discard[j]=cardsToPlay[k];
                k++;
            }
            j++;
        }
    }

    public static void main(String[] args) {

        Scanner in = new Scanner(System.in);

        //initialize deck
        String[] Suits = {"Clubs", "Diamonds", "Hearts", "Spades"};
        String[] Ranks = {"2", "3", "4", "5", "6", "7", "8", "9", "10", "Jack", "Queen", "King", "Ace"};
        int n = Suits.length * Ranks.length;
        Card[] deck = new Card[n];
        int si = 0;
        int ri = 0;
        for (int i = 0; i < n; i++) {
            deck[i] = new Card(Suits[si], Ranks[ri]);
            if (ri < Ranks.length - 1) {
                ri++;
            } else {
                si++;
                ri = 0;
            }
        }

        boolean playing = true;

        while (playing) {

            Card[] discarded = new Card[n];

            //shuffle
            shuffle(deck);

            int cardsLeft = n;
            int x = 4;//cards to be drawn per play, user can change
            while (cardsLeft > 0) {
                //player draws x number of cards
                Card[] drawn = draw(deck, x);

                //player plays x number of cards and discards
                play(drawn, discarded);

                cardsLeft -= x;

                if (cardsLeft<x){//if there are fewer cards left than there are to be drawn, draw remaining cards
                    x = cardsLeft;
                }
            }

            //restart game if requested
            System.out.println("Do you want to play again? Y/N");
            String answer = in.nextLine();
            if (answer.equals("Y")) {//create a new deck with the discard pile and repeat
                deck = Arrays.copyOf(discarded,discarded.length);
            } else {
                //game finished
                System.out.println("Thanks for playing!! :)");
                playing = false;
            }
        }
    }
}
