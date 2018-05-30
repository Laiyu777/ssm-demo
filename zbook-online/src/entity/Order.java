package entity;

import java.sql.Timestamp;

public class Order {
	private Integer id ;
   private String buyerid;
   private  String sellerid;
   private Integer addressid;
   private String state;
   private Double amount; 
   private Timestamp date;
 
   


public void setSellerid(String sellerid) {
	this.sellerid = sellerid;
}
public Integer getId() {
	return id;
}
public void setId(Integer id) {
	this.id = id;
}
public String getBuyerid() {
	return buyerid;
}
public void setBuyerid(String buyerid) {
	this.buyerid = buyerid;
}
public String getSellerid() {
	return sellerid;
}
public void setSeller_id(String sellerid) {
	this.sellerid = sellerid;
}
public Integer getAddressid() {
	return addressid;
}
public void setAddressid(Integer addressid) {
	this.addressid = addressid;
}
public String getState() {
	return state;
}
public void setState(String state) {
	this.state = state;
}
public Timestamp getDate() {
	return date;
}
public void setDate(Timestamp date) {
	this.date = date;
}
@Override
public String toString() {
	return "Order [id=" + id + ", buyer_id=" + buyerid + ", seller_id=" + sellerid + ", addressid=" + addressid
			+ ", state=" + state + ", date=" + date + "]";
}
public Double getAmount() {
	return amount;
}
public void setAmount(Double amount) {
	this.amount = amount;
}
   
   
	
}
