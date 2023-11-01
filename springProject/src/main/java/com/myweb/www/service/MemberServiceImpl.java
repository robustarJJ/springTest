package com.myweb.www.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myweb.www.repository.MemberDAO;
import com.myweb.www.security.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MemberServiceImpl implements MemberService{
	
	@Inject
	private MemberDAO mdao;
	
	@Transactional
	@Override
	public int register(MemberVO mvo) {
		int isOk = mdao.insertMember(mvo);
		return mdao.insertAuthInit(mvo.getEmail());
	}

	@Override
	public boolean updateLastLogin(String authEmail) {
		// TODO Auto-generated method stub
		return mdao.updateLastLogin(authEmail) > 0 ? true : false;
	}

	@Override
	public List<MemberVO> getList() {
		List<MemberVO> list = mdao.selectList();
		for(MemberVO mvo : list) {
			mvo.setAuthList(mdao.selectAuths(mvo.getEmail()));
		}
		return list;
	}

	@Override
	public MemberVO getDetail(String email) {
		
		return mdao.selectEmail(email);
	}


	@Override
	public int memModifyPwdEmpty(MemberVO mvo) {
		// TODO Auto-generated method stub
		return mdao.memUpdatePwdEmpty(mvo);
	}
	
	@Override
	public int memModify(MemberVO mvo) {
		
		return mdao.memUpdate(mvo);
	}

	@Override
	public int memRemove(String email) {
		mdao.removeAuth(email);
		return mdao.remove(email);
	}
}
