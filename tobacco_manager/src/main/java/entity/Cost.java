package entity;

/**
 * 对应cost表中的一条记录
 * Created by Administrator on 2017/12/18.
 */
public class Cost {
    private Integer goodId;
    private Integer roleId;
    private Double costPrice;

    @Override
    public String toString() {
        return "Cost{" +
                "goodId=" + goodId +
                ", roleId=" + roleId +
                ", costPrice=" + costPrice +
                '}';
    }

    public Integer getGoodId() {
        return goodId;
    }

    public void setGoodId(Integer goodId) {
        this.goodId = goodId;
    }

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    public Double getCostPrice() {
        return costPrice;
    }

    public void setCostPrice(Double costPrice) {
        this.costPrice = costPrice;
    }
}
