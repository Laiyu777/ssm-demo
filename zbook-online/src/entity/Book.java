package entity;

import java.sql.Timestamp;
import java.util.Date;

public class Book {
	private Integer id;
	private String name;
	private Double price;
	private Double price2;
	private int ifkill;//是否是秒杀商品
	private String description;
	private Integer stock;
	private Integer shop_id;
	private Timestamp date;
	private Integer clickcount;
	private Integer salecount;
	private Integer bookdown;
	private String key;
	private String kind;
	
	public String getKey() {
		return key;
	}
	public void setKey(String key) {
		this.key = key;
	}
	public String getKind() {
		return kind;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}
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
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Double getPrice() {
		return price;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Integer getStock() {
		return stock;
	}
	public void setStock(Integer stock) {
		this.stock = stock;
	}
	public Integer getShop_id() {
		return shop_id;
	}
	public void setShop_id(Integer shop_id) {
		this.shop_id = shop_id;
	}

	public Double getPrice2() {
		return price2;
	}
	public void setPrice2(Double price2) {
		this.price2 = price2;
	}
	public int getIfkill() {
		return ifkill;
	}
	public void setIfkill(int ifkill) {
		this.ifkill = ifkill;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Book other = (Book) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}
	public Timestamp getDate() {
		return date;
	}
	public void setDate(Timestamp date) {
		this.date = date;
	}
	public Integer getClickcount() {
		return clickcount;
	}
	public void setClickcount(Integer clickcount) {
		this.clickcount = clickcount;
	}
	public Integer getBookdown() {
		return bookdown;
	}
	public void setBookdown(Integer bookdown) {
		this.bookdown = bookdown;
	}
	@Override
	public String toString() {
		return "Book [id=" + id + ", name=" + name + ", price=" + price + ", price2=" + price2 + ", ifkill=" + ifkill
				+ ", description=" + description + ", stock=" + stock + ", shop_id=" + shop_id + ", date=" + date
				+ ", clickcount=" + clickcount + ", salecount=" + salecount + ", bookdown=" + bookdown + ", key=" + key
				+ ", kind=" + kind + "]";
	}
	
	
}
