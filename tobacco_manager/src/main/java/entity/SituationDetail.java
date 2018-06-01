package entity;

/**
 * Created by Administrator on 2017/12/6.
 */
public class SituationDetail {
    private Integer situationId;
    private String goodName;
    private Double sellPrice;
    private Integer sellCount;
    private Double sellCost;

    public Double getSellCost() {
        return sellCost;
    }

    public void setSellCost(Double sellCost) {
        this.sellCost = sellCost;
    }

    @Override
    public String toString() {
        return "SituationDetail{" +
                "situationId=" + situationId +
                ", goodName='" + goodName + '\'' +
                ", sellPrice=" + sellPrice +
                ", sellCount=" + sellCount +
                ", sellCost=" + sellCost +
                '}';
    }

    public Integer getSituationId() {
        return situationId;
    }

    public void setSituationId(Integer situationId) {
        this.situationId = situationId;
    }

    public String getGoodName() {
        return goodName;
    }

    public void setGoodName(String goodName) {
        this.goodName = goodName;
    }

    public Double getSellPrice() {
        return sellPrice;
    }

    public void setSellPrice(Double sellPrice) {
        this.sellPrice = sellPrice;
    }

    public Integer getSellCount() {
        return sellCount;
    }

    public void setSellCount(Integer sellCount) {
        this.sellCount = sellCount;
    }
}
