package bookmall.vo;

public class UserVo {
	
	//- 이름, 전화번호, 이메일, 비밀번호
	private Long no;
	private String name;
	private String phoneNumber;
	private String email;
	private String password;
	
	
	public UserVo(String name, String email, String password, String phoneNumber) {
		this.name = name;
		this.email = email;
		this.password = password;
		this.phoneNumber = phoneNumber;
		
	}
	
	@Override
	public String toString() {
		
		return "UserVo [no = " + no + ", name = " + name + ", phone_number = " + phoneNumber + 
				", email = " + email + "password = " + password + "]";
	}
	public Long getNo() {
		return no;
	}
	public void setNo(Long no) {
		this.no = no;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
	
	
}
