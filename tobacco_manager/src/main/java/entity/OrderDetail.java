package entity;

/**
 * Created by Administrator on 2017/12/6.
 */
public class OrderDetail {
    private Integer orderId;

    private Integer count;

    private Good good;

    public Good getGood() {
        return good;
    }

    public void setGood(Good good) {
        this.good = good;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }


    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    @Override
    public String toString() {
        return "OrderDetail{" +
                "orderId=" + orderId +
                ", count=" + count +
                ", good=" + good +
                '}';
    }
}
