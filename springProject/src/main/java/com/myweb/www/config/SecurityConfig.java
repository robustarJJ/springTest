package com.myweb.www.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.myweb.www.security.CustomAuthMemberService;
import com.myweb.www.security.LoginFailuerHandler;
import com.myweb.www.security.LoginSuccessHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter{
	//security package를 생성하여 사용자 핸들러 생성
	
	//비밀번호 암호화 객체 빈 생성
	@Bean
	public PasswordEncoder bcPasswordEncoder() {
		return new BCryptPasswordEncoder();
	}
	
	//SuccessHandler 빈 객체 생성 => 사용자가 생성
	@Bean
	public AuthenticationSuccessHandler authSuccessHandler() {
		return new LoginSuccessHandler();
	}
	
	//failureHandler 빈 객체 생성 => 사용자가 생성
	@Bean
	public AuthenticationFailureHandler authFailureHandler() {
		return new LoginFailuerHandler();
	}
	
	//userDetail 빈 객체 생성 => 사용자가 생성
	@Bean
	public UserDetailsService customUserService() {
		return new CustomAuthMemberService();
	}
	
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(customUserService())
		.passwordEncoder(bcPasswordEncoder());
	}

	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.csrf().disable();
		
		//승인 요청
		http.authorizeRequests()
		.antMatchers("/member/list").hasRole("ADMIN") //관리자만 들어갈 수 있는 경로
		.antMatchers("/","/board/list","/board/detail","/resources/**","/member/register","/member/login","/comment/**","/upload/**").permitAll() //모든사용자(비회원도) 들어갈수있는 경로
		.anyRequest().authenticated(); //=>인증된 사용자만 처리
		
		//커스텀 로그인 페이지를 구성
		//Controller에 주소 요청 맵핑도 같이 꼭 적어줘야 함.
		http.formLogin()
		.usernameParameter("email")
		.passwordParameter("pwd")
		.loginPage("/member/login")
		.successHandler(authSuccessHandler())
		.failureHandler(authFailureHandler());
		
		//로그아웃 페이지, 반드시 method="post"
		http.logout()
		.logoutUrl("/member/logout")
		.invalidateHttpSession(true)
		.deleteCookies("JSESSIONID")
		.logoutSuccessUrl("/");
	}

	
	
	
	
	
	
	
	
	
	
	
	
	
}
