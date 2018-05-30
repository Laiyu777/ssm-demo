package entity.vo;

import java.util.List;

import entity.Address;
import entity.Order;
import entity.Shop;

//数据库中一个orderid对应一个Orderhelp
public class OrderHelp {
	private Order order;
	private Address address;
	private List<BookHelp> listBookHelp;
	private Shop shop;
	private double total;
	public Order getOrder() {
		return order;
	}
	public void setOrder(Order order) {
		this.order = order;
	}
	
	public Address getAddress() {
		return address;
	}
	public void setAddress(Address address) {
		this.address = address;
	}

	public Shop getShop() {
		return shop;
	}
	public void setShop(Shop shop) {
		this.shop = shop;
	}
	public OrderHelp() {
		super();
		// TODO Auto-generated constructor stub
	}
	public List<BookHelp> getListBookHelp() {
		return listBookHelp;
	}
	public void setListBookHelp(List<BookHelp> listBookHelp) {
		this.listBookHelp = listBookHelp;
	}
	public OrderHelp(Order order, Address address, List<BookHelp> listBookHelp, Shop shop) {
		super();
		this.order = order;
		this.address = address;
		this.listBookHelp = listBookHelp;
		this.shop = shop;
	}
	public double getTotal() {
		return total;
	}
	public void setTotal(double total) {
		this.total = total;
	}

	

	
}
