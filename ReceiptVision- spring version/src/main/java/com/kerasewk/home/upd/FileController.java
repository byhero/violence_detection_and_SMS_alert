package com.kerasewk.home.upd;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class FileController {
	@RequestMapping("upload")
	public String upload() {
		return "upd/ready";
	}
	
}
