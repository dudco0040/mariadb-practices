package bookmall.vo;

public class CartVo {
	private int quantity;
	private Long userNo;
	private Long bookNo;
	private String bookTitle;
	
	// book Title
	public String getBookTitle() {
		return bookTitle;
	}
	public void setBookTitle(String bookTitle) {
		this.bookTitle = bookTitle;
	}
	
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public Long getUserNo() {
		return userNo;
	}
	public void setUserNo(Long userNo) {
		this.userNo = userNo;
	}
	public Long getBookNo() {
		return bookNo;
	}
	public void setBookNo(Long bookNo) {
		this.bookNo = bookNo;
	}
	
	
	@Override
	public String toString() {
		return "CartVo [quantity = " + quantity + ", userNo = " + userNo + ", bookNo = "+ bookNo + "]";
	}
	

//	public String getBookTitle() {
//		// book table에 있는 no, title 변수를 활용하여 가져옴
//		BookVo vo = new BookVo(null, quantity);		// title, price  - title 값이 필요한데 title 값을 입력한다? 
//		String bookTitle = vo.getTitle();
//		
//		return bookTitle;
//	}
	
}
