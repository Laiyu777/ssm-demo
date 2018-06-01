package entity;

import java.util.List;

/**
 * 图表中的数据全部封装在这里
 * x轴的时间
 * y轴的销售量和利润
 * Created by Administrator on 2018/3/27.
 */
public class SaleAndProfitWrapper {
    private List<String> date;
    private List<Double> sale;
    private List<Double> profit;

    public List<String> getDate() {
        return date;
    }

    public void setDate(List<String> date) {
        this.date = date;
    }

    public List<Double> getSale() {
        return sale;
    }

    public void setSale(List<Double> sale) {
        this.sale = sale;
    }

    public List<Double> getProfit() {
        return profit;
    }

    public void setProfit(List<Double> profit) {
        this.profit = profit;
    }
}
