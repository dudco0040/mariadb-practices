package bookmall.vo;

public class OrderBookVo {
	private String orderNo;
	private Long bookNo;
	private int quantity;
	private int price;
	
		
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public Long getBookNo() {
		return bookNo;
	}
	public void setBookNo(Long bookNo) {
		this.bookNo = bookNo;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}


	@Override
	public String toString() {
		return "OrderVo[ orderNo = " + orderNo + ", bookNo = " + bookNo + ", quantity = " + quantity + ", price = " + price + "]";
	}
	

}
