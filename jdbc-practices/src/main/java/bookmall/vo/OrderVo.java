package bookmall.vo;

public class OrderVo {
	private Long no;
	private String number;
	private String status;
	private int payment;
	private String shipping;
	private Long userNo;
	
//	public OrderVo(String number, String status, int payment, String shipping, Long userNo) {
//		this.number = number;
//		this.status = status;
//		this.payment= payment;
//		this.shipping = shipping;
//		this.userNo = userNo;
//		
//	}
	
	public Long getNo() {
		return no;
	}
	public void setNo(Long no) {
		this.no = no;
	}
	public String getNumber() {
		return number;
	}
	public void setNumber(String number) {
		this.number = number;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public int getPayment() {
		return payment;
	}
	public void setPayment(int payments) {
		this.payment = payments;
	}
	public String getShipping() {
		return shipping;
	}
	public void setShipping(String shipping) {
		this.shipping = shipping;
	}
	public Long getUserNo() {
		return userNo;
	}
	public void setUserNo(Long userNo) {
		this.userNo = userNo;
	}
	
	@Override
	public String toString() {
		
		return "OrderVp = [ no =" + no + ", number = " + number + ",status = " + status + "payment= " + payment +
				"shipping = " + shipping + "userNo = " + userNo + "]";
		
	}
	

}
