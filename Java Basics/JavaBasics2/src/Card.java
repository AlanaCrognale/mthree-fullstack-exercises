public class Card {

    private String title, desc;

    public Card(String title, String desc){
        this.title = title;
        this.desc = desc;
    }

    public String getTitle(){
        return title;
    }

    public String getDesc(){
        return desc;
    }

    public void setTitle(String title){
        this.title = title;
    }

    public void setDesc(String desc){
        this.desc = desc;
    }

}
