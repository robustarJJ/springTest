package com.myweb.www.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.myweb.www.domain.BoardDTO;
import com.myweb.www.domain.BoardVO;
import com.myweb.www.domain.FileVO;
import com.myweb.www.domain.PagingVO;
import com.myweb.www.repository.BoardDAO;
import com.myweb.www.repository.CommentDAO;
import com.myweb.www.repository.FileDAO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class BoardServiceImpl implements BoardService{
	
	@Inject
	private BoardDAO bdao;
	
	@Inject
	private FileDAO fdao;
	
	@Inject
	private CommentDAO cdao;

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
	
	
	
	//모든 작업들이 성공적으로 완료되어야 작업 묶음의 결과를 적용하고, 어떤 작업에서 오류가 발생했을 때는 이전에 있던 모든 작업들이 성공적이었더라도 없었던 일처럼 완전히 되돌리는 것
	//오류가 발생했을 때 모든 작업들을 원상태로 되돌릴 수 있다. 모든 작업들이 성공해야만 최종적으로 데이터베이스에 반영됨.
	//우선순위 : 클래스 메소드 -> 클래스 -> 인터페이스 메소드 -> 인터페이스
	//반드시 public 메서드에 적용되어야한다.
	@Transactional
	@Override
	public List<BoardVO> getList(PagingVO pagingVO) {
		log.info(">>> list list serviceImpl");
		bdao.listCmtQty();
		bdao.fileCmtQty();
		return bdao.getList(pagingVO);
	}
	
	@Transactional
	@Override
	public BoardDTO getDetail(long bno) {
		log.info(">>> list detail serviceImpl");
		bdao.readCount(bno,1);
		bdao.detailCmtQty(bno);
		//파일 list 가져온 다음 BoardDTO로 만들어 리턴
		BoardDTO bdto = new BoardDTO(bdao.getDetail(bno),fdao.getFileList(bno) );
		return bdto;
	}
	
	@Transactional
	@Override
	public int modify(BoardVO bvo) {
		log.info(">>> list modify serviceImpl");
		bdao.readCount(bvo.getBno(), -2);
		return bdao.modify(bvo);
	}
	
	@Transactional
	@Override
	public int remove(long bno) {
		log.info(">>> list remove serviceImpl");
		//게시글 삭제시 파일과 댓글 같이 삭제
		cdao.deleteAllCmt(bno);
		fdao.deleteAllFile(bno);
		return bdao.delete(bno);
	}

	@Override
	public int getTotalCount(PagingVO pagingVO) {
		// TODO Auto-generated method stub
		return bdao.getTotalCount(pagingVO);
	}
	
	@Transactional
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
	
	@Transactional
	@Override
	public int removeFile(String uuid) {
		log.info(">>>>> removeFile serviceImpl >>");
		return fdao.removeFile(uuid);
	}

	@Transactional
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
