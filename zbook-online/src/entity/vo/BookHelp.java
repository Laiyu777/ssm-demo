package entity.vo;

import entity.Book;

public class BookHelp {
	private Integer id;
	private Book book;
	private int count;
	private double total;
	public Book getBook() {
		return book;
	}
	public void setBook(Book book) {
		this.book = book;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public BookHelp() {
		super();
		// TODO Auto-generated constructor stub
	}
	public BookHelp(int id ,Book book, int count) {
		super();
		this.id=id;
		this.book = book;
		this.count = count;
	}
	@Override
	public String toString() {
		return "BookHelp [book=" + book + ", count=" + count + "]";
	}
	
	public Integer getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	
	public double getTotal() {
		if(book.getIfkill()==1){
			return book.getPrice2()*count;
		}
		return book.getPrice()*count;
	}
	public void setTotal(double total) {
		this.total = total;
	}
}
