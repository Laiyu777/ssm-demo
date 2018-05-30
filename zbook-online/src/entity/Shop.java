package entity;

import java.sql.Timestamp;

public class Shop {
	private Integer id;
	private String user_id;
	private String name;
	private String description;
	private Integer integral;
	private Timestamp date;
	private Integer salecount;
	private Integer shopstate;
	public Integer getSalecount() {
		return salecount;
	}
	public void setSalecount(Integer salecount) {
		this.salecount = salecount;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Integer getIntegral() {
		return integral;
	}
	public void setIntegral(Integer integral) {
		this.integral = integral;
	}
	public Timestamp getDate() {
		return date;
	}
	public void setDate(Timestamp date) {
		this.date = date;
	}
	@Override
	public String toString() {
		return "Shop [id=" + id + ", user_id=" + user_id + ", name=" + name + ", description=" + description
				+ ", integral=" + integral + ", date=" + date + "]";
	}
	public Integer getShopstate() {
		return shopstate;
	}
	public void setShopstate(Integer shopstate) {
		this.shopstate = shopstate;
	}
	
	
}
