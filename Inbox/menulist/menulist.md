package kiosk.domain;  
  
import java.util.ArrayList;  
import java.util.List;  
import kiosk.vo.MenuData;  
  
public class MenuList {  
    private final List<Menu> menuList = new ArrayList<>();  
  
    public MenuList() {  
        for (MenuData menuData : MenuData.values()) {  
            Menu menu = new Menu(menuData.getMenu(), menuData.getDescription());  
            menuList.add(menu);  
        }  
    }  
    public List<Menu> getMenuList() {  
        return menuList;  
    }  
}