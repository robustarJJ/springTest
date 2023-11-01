package com.myweb.www.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	
	@GetMapping("/register/")
	public void register() {}
	
	@PostMapping("/register")
	public String register(MemberVO mvo) {
		mvo.setPwd(bcEncoder.encode(mvo.getPwd()));
		log.info(">>>> member register mvo >>"+mvo);
		int isOk = msv.register(mvo);
		return "index";
	}
	
	@GetMapping("/login")
	public void login() {}
	
	@PostMapping("/login")
	public String loginPost(HttpServletRequest request, RedirectAttributes re) {
		//로그인 실패시 다시 로그인 페이지로 돌아와 오류 메시지 전송
		//다시 로그인 유도
		re.addAttribute("email", request.getAttribute("email"));
		re.addAttribute("errMsg", request.getAttribute("errMsg"));
		return "redirect:/member/login";
	}
	
	@GetMapping("/list")
	public void memList(Model m) {
		List<MemberVO> list = msv.getList();
		m.addAttribute("memList", list);
	}
	
	@GetMapping("/detail")
	public void memDetail(Model m, @RequestParam("email")String email) {
		MemberVO detail = msv.getDetail(email);
		m.addAttribute("memDetail", detail);
	}
	
	
	@GetMapping("/modify")
	public void memModify(Model m, @RequestParam("email")String email) {
		MemberVO detail = msv.getDetail(email);
		m.addAttribute("memDetail", detail);
	}
	
	
	@PostMapping("/modify")
	public String memModify(MemberVO mvo, RedirectAttributes reAttr, HttpServletRequest request, HttpServletResponse response) {
		int isOk =3;
		if(mvo.getPwd().isEmpty()) {
			isOk = msv.memModifyPwdEmpty(mvo);
		}else {	
			mvo.setPwd(bcEncoder.encode(mvo.getPwd())); //bcEncoder.encode 비밀번호 암호화 기능
			isOk = msv.memModify(mvo);
		}
		reAttr.addFlashAttribute("isOk",isOk);
		//logout(request, response);
		return "redirect:/member/detail?email="+mvo.getEmail();
	}
	
	@GetMapping("/remove")
	public String RemoveMember(@RequestParam("email") String email, HttpServletRequest req, HttpServletResponse res) {
		int isOk = msv.memRemove(email);
		log.info(">>>> 회원탈퇴>> "+(isOk > 0 ? "Ok" : "Fail"));
		logout(req, res);
		return "index";
	}
	
	
	
	//로그인한 인증 기록을 삭제하는 거
	private void logout(HttpServletRequest request,  HttpServletResponse response) {
		Authentication authentication = SecurityContextHolder
				.getContext().getAuthentication();
		new SecurityContextLogoutHandler().logout(request, response, authentication);
	}
	
	
	
	
}
