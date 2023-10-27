package com.myweb.www.security;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class MemberVO {

	private String email;
	private String pwd;
	private String nickName;
	private String regAt;
	private String lastLogin;
	private List<AuthVO> authList;
	
	
	
//			create table member(
//			email varchar(100) not null,
//			pwd varchar(1000) not null,
//			nick_name varchar(100) not null,
//			reg_at datetime default now(),
//			last_login datetime default null,
//			primary key(email));
}
