package com.kerasewk.home.usr;

import java.awt.Image;
import java.io.File;
import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
@Controller
@RequestMapping("usr")
public class UsrController {

	private static final Logger logger = LoggerFactory.getLogger(UsrController.class);
	
	@Autowired
	private UsrService usrService;
	
	private String uploadUrl="C:/dev64/upload";
	
	@GetMapping("/")
	public String login() {
		return "usr/login";
	}
	
	@PostMapping("/")
	public String login(
			@ModelAttribute UsrDTO usrDTO,
			Model model,
			HttpSession session) {
		logger.info(usrDTO.toString());
		try {
			UsrDTO usrInfo = usrService.getUsr(usrDTO);
			logger.info(usrInfo.toString());
			
			session.setAttribute("usrInfo", usrInfo);
			return "./upd/ready";
		} catch (Exception e) {
			logger.info(e.getMessage());
			model.addAttribute("msg",e.getMessage());
			model.addAttribute("url", "./");
			return "result";
		}
	}
	@GetMapping("/logout")
	public ModelAndView logout(HttpSession session) {
		UsrDTO usrInfo = (UsrDTO) session.getAttribute("usrInfo");
		session.invalidate();
		
		ModelAndView mav = new ModelAndView("result");
		mav.addObject("msg", usrInfo.getUsr_name() + 
				 "(" + usrInfo.getUsr_id() + ")님이 로그아웃 하였습니다.");
		mav.addObject("url", "./");
		return mav;
	}
	
	@GetMapping("/regist")
	public String regist() {
		return "usr/regist";
	}
	
	@PostMapping("/regist")
	public String regist(@ModelAttribute UsrDTO usrDTO, Model model) {
		logger.info(usrDTO.toString());
		
		CommonsMultipartFile cmf = usrDTO.getUsr_pic();
		
		if (cmf == null) {
			logger.info("파일 업로드 실패");
			return null;
		}
		File uploadPath = new File(uploadUrl);
		
		if (!uploadPath.exists()) uploadPath.mkdirs();
		
		long fileSize = cmf.getSize();
		String originalName = cmf.getOriginalFilename()
		/*
		 * Copyright 2020 the original author or authors.
		 *
		 * Licensed under the Apache License, Version 2.0 (the "License");
		 * you may not use this file except in compliance with the License.
		 * You may obtain a copy of the License at
		 *
		 *      https://www.apache.org/licenses/LICENSE-2.0
		 *
		 * Unless required by applicable law or agreed to in writing, software
		 * distributed under the License is distributed on an "AS IS" BASIS,
		 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
		 * See the License for the specific language governing permissions and
		 * limitations under the License.
		 */
;
		File file = new File(uploadUrl + "/", usrDTO.getUsr_id() + ".png");
		
		String val = "file";
		String allowPattern = ".+\\.(jpg|png|bmp|gif)$";
		Pattern p = Pattern.compile(allowPattern);
		Matcher m = p.matcher(val.toLowerCase());

		/*
		 * if(m.matches()) {
		 * 
		 * //확장자만 추출 int pos = val.lastIndexOf("."); String ext = val.substring(pos+1,
		 * val.length()); if("jpg".equals(ext.toLowerCase())) {
		 * 
		 * }else {
		 * 
		 * }
		 */
		
		try {
			cmf.transferTo(file);
		} catch (IllegalStateException | IOException e1) {
		
			e1.printStackTrace();
		}
	
		
		
		try {
			usrService.regist(usrDTO);
			model.addAttribute("usrDTO", usrDTO);
			return "usr/regist_success";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "에러");
			model.addAttribute("url", "javascript:history.back();");
			return "result";
		}
	 
	}
	
	@GetMapping("/auth/kakao/callback")
	public @ResponseBody String kakaoCallback(
		String code,
		HttpServletRequest request) throws IOException {
		
		String contextPath = request.getContextPath();
		logger.info(contextPath);
		//POST방식으로 key=value 데이터를 요청(카카오 쪽으로)
		
		//HttpHeader 오브젝트 생성
		RestTemplate rt = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.add("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
		//HttpBody 오브젝트 생성
		MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
		params.add("grant_type", "authorization_code");
		params.add("client_id", "249ffb8a579fc2aa4d12d1dc77086be9");
		params.add("redirect_uri", "http://localhost"+ contextPath +"/usr/auth/kakao/callback");
		params.add("code", code);
		//HttpHeader와 HttpBody를 하나의 오브젝트에 담기
		HttpEntity<MultiValueMap<String, String>>kakaoTokenRequest=
				new HttpEntity<>(params, headers);
		
		//Http 요청하기-POST 방식으로 그리고 response 변수의 응답 받음
		ResponseEntity<String> response = rt.exchange(
				"https://kauth.kakao.com/oauth/token", 
				HttpMethod.POST,
				kakaoTokenRequest,
				String.class
		);	
		
		//Gson, Json Simple, ObjectMapper
		ObjectMapper objectMapper = new ObjectMapper();
		OAuthToken oauthToken = null;
	
		
		
		try {
			oauthToken = objectMapper.readValue(response.getBody(), OAuthToken.class);
		}catch (JsonMappingException e) {
			e.printStackTrace();
		}catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
	   // System.out.println("카카오 엑세스 토큰:" +oauthToken.getAccess_token());
	    
		return response.getBody();
	}
	@PostMapping("/checkID") 
	@ResponseBody
	public int checkID(@RequestParam String usr_id) {
		logger.info(usr_id);
		try {
			return usrService.countUsrId(usr_id);
			
		} catch (Exception e) {
			
			e.printStackTrace();
			return -1;
		}
	}
}