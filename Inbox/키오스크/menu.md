```java
package kiosk.domain;  
  
public enum Menu {  
    BURGERS("Burgers", 1, "앵거스 비프 통살을 다져만든 버거"),  
    FORZEN_CUSTARD("ForzenCustard",2, "매장에서 신선하게 만드는 아이스크림"),  
    DRINKS("Drinks", 3, "매장에서 직접 만드는 음료"),  
    BEER("Beer", 4, "뉴욕 브루클린 브루어리에서 양조한 맥주");  
  
    private final String menu;  
    private final int menuNumber;  
    private final String explanation;  
  
  
    Menu(String menu, int menuNumber, String explanation) {  
        this.menu = menu;  
        this.menuNumber = menuNumber;  
        this.explanation = explanation;  
    }  
  
    public int getMenuNumber() {  
        return menuNumber;  
    }  
  
    public String getExplanation() {  
        return explanation;  
    }  
  
    public String getMenu() {  
        return menu;  
    }  
}

//

    //BURGERS
    SHACK_BURGER(MenuCategory.BURGERS),
    SMOKE_SHACK,
    SHROOM_BURGER,
    CHEESE_BURGER,
    HAMBURGER,
    //FROGEN CUSTARD
    SHAKE,
    SHAKE_OF_THE_WEEK,
    RED_BEAN_SHAKE,
    FLOATS,
    CUPS_CONES,
    CONCRETES,
    SHACK_ATTACK,
    //DRINK
    SHACK_MADE_LEMONADE,
    FRESH_BREWED_ICED_TEA,
    FIFTY_FIFTY,
    FOUNTAIN_SODA,
    ABITA_ROOT_BEER,
    BOTTLED_WATER,
    //BEER
    SHACKMEISTER_ALE,
    MAGPIE_BREWING_CO;
    ```