package com.kerasewk.home.usr;

import java.io.Serializable;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

public class UsrDTO implements Serializable {

	private long usr_no;
	private String usr_id;
	private String usr_pw;
	private String usr_name;
	private String usr_info;
	private int usr_level;
	private int usr_status;
	private String usr_regdate;
	private String usr_lastlogin;
	private int usr_logcnt;
	private String usr_ip;
	private String usr_zipcode;
	private String usr_address;
	private String usr_address_detail;
	private CommonsMultipartFile usr_pic;
	
	public long getUsr_no() {
		return usr_no;
	}
	public void setUsr_no(long usr_no) {
		this.usr_no = usr_no;
	}
	public String getUsr_id() {
		return usr_id;
	}
	public void setUsr_id(String usr_id) {
		this.usr_id = usr_id;
	}
	public String getUsr_pw() {
		return usr_pw;
	}
	public void setUsr_pw(String usr_pw) {
		this.usr_pw = DigestUtils.sha512Hex(usr_pw);
	}
	public String getUsr_name() {
		return usr_name;
	}
	public void setUsr_name(String usr_name) {
		this.usr_name = usr_name;
	}
	public String getUsr_info() {
		return usr_info;
	}
	public void setUsr_info(String usr_info) {
		this.usr_info = usr_info;
	}
	public int getUsr_level() {
		return usr_level;
	}
	public void setUsr_level(int usr_level) {
		this.usr_level = usr_level;
	}
	public int getUsr_status() {
		return usr_status;
	}
	public void setUsr_status(int usr_status) {
		this.usr_status = usr_status;
	}
	public String getUsr_regdate() {
		return usr_regdate;
	}
	public void setUsr_regdate(String usr_regdate) {
		this.usr_regdate = usr_regdate;
	}
	public String getUsr_lastlogin() {
		return usr_lastlogin;
	}
	public void setUsr_lastlogin(String usr_lastlogin) {
		this.usr_lastlogin = usr_lastlogin;
	}
	public int getUsr_logcnt() {
		return usr_logcnt;
	}
	public void setUsr_logcnt(int usr_logcnt) {
		this.usr_logcnt = usr_logcnt;
	}
	public String getUsr_ip() {
		return usr_ip;
	}
	public void setUsr_ip(String usr_ip) {
		this.usr_ip = usr_ip;
	}
	public String getUsr_zipcode() {
		return usr_zipcode;
	}
	public void setUsr_zipcode(String usr_zipcode) {
		this.usr_zipcode = usr_zipcode;
	}
	public String getUsr_address() {
		return usr_address;
	}
	public void setUsr_address(String usr_address) {
		this.usr_address = usr_address;
	}
	public String getUsr_address_detail() {
		return usr_address_detail;
	}
	public void setUsr_address_detail(String usr_address_detail) {
		this.usr_address_detail = usr_address_detail;
	}
	
	@Override
	public String toString() {
		return "UsrDTO [usr_no=" + usr_no + ", usr_id=" + usr_id + ", usr_pw=" + usr_pw + ", usr_name=" + usr_name
				+ ", usr_info=" + usr_info + ", usr_level=" + usr_level + ", usr_status=" + usr_status
				+ ", usr_regdate=" + usr_regdate + ", usr_lastlogin=" + usr_lastlogin + ", usr_logcnt=" + usr_logcnt
				+ ", usr_ip=" + usr_ip + ", usr_zipcode=" + usr_zipcode + ", usr_address=" + usr_address
				+ ", usr_address_detail=" + usr_address_detail+ ", usr_pic=" + usr_pic + "]";
	}
	public CommonsMultipartFile getUsr_pic() {
		return usr_pic;
	}
	public void setUsr_pic(CommonsMultipartFile usr_pic) {
		this.usr_pic = usr_pic;
	}

	
	
}