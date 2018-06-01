package entity;

import java.util.List;

/**
 * Created by Administrator on 2017/12/11.
 */
public class CartItem {

    private Integer count;

    private Good good;

   private String username;

    @Override
    public String toString() {
        return "CartItem{" +
                "count=" + count +
                ", good=" + good +
                ", username='" + username + '\'' +
                '}';
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public Good getGood() {
        return good;
    }

    public void setGood(Good good) {
        this.good = good;
    }
}
