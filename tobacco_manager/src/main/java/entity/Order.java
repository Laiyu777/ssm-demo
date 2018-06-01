package entity;

import java.sql.Timestamp;
import java.util.List;

/**
 * Created by Administrator on 2017/12/6.
 */
public class Order {
    private Integer orderId;
    private String username;
    private Timestamp createTime;
    private String status;
    private String notes;


    private List<OrderDetail> orderDetails;

    private double total;

    private User user;

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public double getTotal(){
        return this.total;
    }

    public void setTotal(){
        double total = 0;
        String username = this.getUsername();
        for(OrderDetail orderDetail:orderDetails){
            Good good =orderDetail.getGood();
            Integer roleId = this.user.getRole().getRoleId();
            //2018 5 22
            total+=good.getCostList().get(roleId-1).getCostPrice()*orderDetail.getCount();
        }
        this.total=total;
    }

    @Override
    public String toString() {
        return "Order{" +
                "orderId=" + orderId +
                ", username='" + username + '\'' +
                ", createTime=" + createTime +
                ", status='" + status + '\'' +
                ", notes='" + notes + '\'' +
                ", orderDetails=" + orderDetails +
                ", total=" + total +
                '}';
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Timestamp getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Timestamp createTime) {
        this.createTime = createTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public List<OrderDetail> getOrderDetails() {
        return orderDetails;
    }

    public void setOrderDetails(List<OrderDetail> orderDetails) {
        this.orderDetails = orderDetails;
    }
}
