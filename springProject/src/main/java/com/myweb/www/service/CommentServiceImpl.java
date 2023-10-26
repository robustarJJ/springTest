package com.myweb.www.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myweb.www.domain.CommentVO;
import com.myweb.www.domain.PagingVO;
import com.myweb.www.handler.PagingHandler;
import com.myweb.www.repository.CommentDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CommentServiceImpl implements CommentService{
	
	@Inject
	private CommentDAO cdao;

	@Override
	public int post(CommentVO cvo) {
		// TODO Auto-generated method stub
		return cdao.insert(cvo);
	}

//	@Override
//	public List<CommentVO> getList(int bno) {
//		// TODO Auto-generated method stub
//		return cdao.getList(bno);
//	}
	
	@Override
	public int remove(int cno) {
		// TODO Auto-generated method stub
		return cdao.delete(cno);
	}

	@Override
	public int edit(CommentVO cvo) {
		// TODO Auto-generated method stub
		return cdao.edit(cvo);
	}
	
	@Transactional
	@Override
	public PagingHandler getList(long bno, PagingVO pgvo) {
		// totalCount 구하기
		int totalCount = cdao.selectOntBnoTotalCount(bno);
		log.info(">>>>>> total  "+totalCount);
		// Comment List 찾아오기
		List<CommentVO> list = cdao.selectListPaging(bno,pgvo);
		log.info(">>>>>> list  "+list);
		PagingHandler ph = new PagingHandler(pgvo, totalCount, list);
		// paging Handler 값 완성 리턴
		return ph;
	}
}
