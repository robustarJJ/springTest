package com.myweb.www.controller;

import javax.inject.Inject;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.myweb.www.security.MemberVO;
import com.myweb.www.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/member/**")
@Controller
public class MemberController {
	
	@Inject
	private BCryptPasswordEncoder bcEncoder;
	
	@Inject
	private MemberService msv;
	
	@GetMapping("/register")
	public void register() {}
	
	@PostMapping("/register")
	public String register(MemberVO mvo) {
		mvo.setPwd(bcEncoder.encode(mvo.getPwd()));
		log.info(">>>> member register mvo >>"+mvo);
		int isOk = msv.register(mvo);
		return "index";
	}
	
	@GetMapping("/login")
	public String login() {
		
		return "/member/login";
	}
	
	
}
