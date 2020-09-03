package com.kerasewk.home.upd;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kerasewk.home.usr.UsrController;

@Controller
@RequestMapping("upd")
public class UpdController {
	private static final Logger logger = LoggerFactory.getLogger(UpdController.class);
	
	
	@GetMapping("/")
	public String regist() {
		return "upd/ready";
	}
}
