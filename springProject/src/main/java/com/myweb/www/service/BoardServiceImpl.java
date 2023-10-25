package com.myweb.www.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.myweb.www.domain.BoardDTO;
import com.myweb.www.domain.BoardVO;
import com.myweb.www.domain.FileVO;
import com.myweb.www.domain.PagingVO;
import com.myweb.www.repository.BoardDAO;
import com.myweb.www.repository.FileDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class BoardServiceImpl implements BoardService{
	
	@Inject
	private BoardDAO bdao;
	
	@Inject
	private FileDAO fdao;

//	@Override
//	public int register(BoardVO bvo) {
//		log.info(">>> list register serviceImpl");
//		if(bvo.getTitle()=="") {
//			return 0;
//		}else {
//		}
//		int isOk = bdao.insert(bvo);
//		return isOk;			
//	}

	@Override
	public List<BoardVO> getList(PagingVO pagingVO) {
		log.info(">>> list list serviceImpl");
		bdao.listCmtQty();
		return bdao.getList(pagingVO);
	}

	@Override
	public BoardDTO getDetail(long bno) {
		log.info(">>> list detail serviceImpl");
		bdao.readCount(bno,1);
		bdao.detailCmtQty(bno);
		//파일 list 가져온 다음 BoardDTO로 만들어 리턴
		BoardDTO bdto = new BoardDTO(bdao.getDetail(bno),fdao.getFileList(bno) );
		return bdto;
	}

	@Override
	public int modify(BoardVO bvo) {
		log.info(">>> list modify serviceImpl");
		bdao.readCount(bvo.getBno(), -2);
		return bdao.modify(bvo);
	}

	@Override
	public int remove(long bno) {
		log.info(">>> list remove serviceImpl");
		return bdao.delete(bno);
	}

	@Override
	public int getTotalCount(PagingVO pagingVO) {
		// TODO Auto-generated method stub
		return bdao.getTotalCount(pagingVO);
	}

	@Override
	public int insert(BoardDTO bdto) {	
		//제목 공백 등록 막기
		if(bdto.getBvo().getTitle().equals("")) {
			log.info(">>>>>>>>>>");
			return 2;
		}else {
			
			// bvo, flist 가져와서 각자 db에 저장
			//기존 메서드 활용
			int isUp = bdao.insert(bdto.getBvo()); //bno 등록
			//null처리
			if(bdto.getFlist()==null) {
				isUp*=1;
				return isUp;
			}
			//bvo insert 후 파일도 있다면...
			if(isUp > 0 && bdto.getFlist().size() > 0) {
				long bno = bdao.selectOneBno(); //가장 마지막에 등록된 bno
				//모든 파일에 bno set
				for(FileVO fvo : bdto.getFlist()) {
					fvo.setBno(bno);
					isUp*= fdao.insertFile(fvo);
				}
			}
			return isUp;
		}
	
	}

	@Override
	public int removeFile(String uuid) {
		log.info(">>>>> removeFile serviceImpl >>");
		return fdao.removeFile(uuid);
	}

	@Override
	public int modifyFile(BoardDTO bdto) {
		log.info("file modifyFile check 2");
		bdao.readCount(bdto.getBvo().getBno(), -2);
		int isOk = bdao.modifyFile(bdto.getBvo()); //기존 bvo update
		if(bdto.getFlist()==null) {
			isOk *=1;
		}else {
			if(isOk > 0 && bdto.getFlist().size() > 0) {
				long bno = bdto.getBvo().getBno();
				//모든 fvo에 bno set
				for(FileVO fvo : bdto.getFlist()) {
					fvo.setBno(bno);
					isOk *=fdao.insertFile(fvo);
				}
			}
		}
		return isOk;
	}
}
