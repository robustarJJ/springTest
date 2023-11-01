package com.myweb.www.service;

import java.util.List;

import com.myweb.www.security.MemberVO;

public interface MemberService {

	int register(MemberVO mvo);

	boolean updateLastLogin(String authEmail);

	List<MemberVO> getList();

	MemberVO getDetail(String email);

	int memModify(MemberVO mvo);

	int memModifyPwdEmpty(MemberVO mvo);

	int memRemove(String email);
	
}
