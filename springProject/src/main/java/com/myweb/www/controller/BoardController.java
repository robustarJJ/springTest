package com.myweb.www.controller;


import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.myweb.www.domain.BoardDTO;
import com.myweb.www.domain.BoardVO;
import com.myweb.www.domain.FileVO;
import com.myweb.www.domain.PagingVO;
import com.myweb.www.handler.FileHandler;
import com.myweb.www.handler.PagingHandler;
import com.myweb.www.service.BoardService;

import lombok.extern.slf4j.Slf4j;


@Slf4j
@Controller
@RequestMapping("/board/*")
public class BoardController {
	// 폴더명 : board / mapping : board
	// mpping => /board/register
	// 목적지 => /board/register
	
	@Inject
	private BoardService bsv;
	
	@Inject
	private FileHandler fh;
	
	@GetMapping("/register")
	public String register() {
		return "/board/register";
		
	}
	
	
	
//	@PostMapping("/register")
//	public String registerPost(BoardVO bvo, Model m) {
//		log.info(">>>"+bvo);
//		int isOk = bsv.register(bvo);
//		log.info(">>> board register >> "+(isOk>0? "Ok" :"Fail"));
//		if(isOk==0) {
//			m.addAttribute("isOk", "2");
//			return "/board/register";
//		}
//		
//		return "redirect:/board/list";
//		
//	}
	

	@PostMapping("/register")
	public String registerPost(BoardVO bvo, RedirectAttributes re,
			@RequestParam(name="files", required=false)MultipartFile[] files) {
		log.info(">>>"+bvo+" "+files);
		List<FileVO> flist = null;
		//file upload handler 생성
		if(files[0].getSize() > 0) {
			flist = fh.uploadFiles(files);
		}
		int isUp = bsv.insert(new BoardDTO(bvo, flist));
		
		log.info(">>>>>>>>> isUp >> "+isUp);
		if(isUp==2) {
			re.addFlashAttribute("isUp", isUp);
			return "redirect:/board/register";
		}else {
			re.addFlashAttribute("isUp", isUp);
			return "redirect:/board/list";	
			}
		}		
	
	
	
//	@GetMapping("/list")
//	public String list(Model m) {
//		List<BoardVO> list = bsv.getList();
//		m.addAttribute("list",list);
//		return "/board/list";
//	}
	
	//paging 추가
	@GetMapping("/list")
	public void list(Model m, PagingVO pagingVO) {
		log.info(">>> pagingVO >> "+pagingVO);
		m.addAttribute("list",bsv.getList(pagingVO));
		//페이징 처리
		//총페이지 개수 totalCount (검색포함)
		int totalCount = bsv.getTotalCount(pagingVO);
		PagingHandler ph = new PagingHandler(pagingVO, totalCount);
		m.addAttribute("ph",ph);
	}
	
	@GetMapping({"/detail","/modify"})
	public void detail(Model m, @RequestParam("bno")int bno) {
		BoardDTO bdto = bsv.getDetail(bno);
		m.addAttribute("bdto",bdto);
	}
	
//	@PostMapping("/modify")
//	public String modify(BoardVO bvo) {
//		int isOk = bsv.modify(bvo);
//		log.info(">>> board modify >> "+(isOk>0? "Ok" :"Fail"));
//		return "redirect:/board/detail?bno="+bvo.getBno();
//	}
	
	@PostMapping("/modify")
	public String modify(BoardVO bvo, RedirectAttributes reAttr,
			@RequestParam(name="files", required = false)MultipartFile[] files) {
		log.info(">>> modify bvo >> "+bvo);
		log.info(">>> modify files >> "+files);
		
		List<FileVO> flist = null;
		if(files[0].getSize() > 0) {
			//기존 파일은 이미 DB에 등록완료. 삭제할 파일은 비동기로 이미 삭제 완료.
			//새로 추가할 파일만 추가
			//file이 존재함.
			flist = fh.uploadFiles(files); //fvo 구성 List로 리턴
		}
		BoardDTO bdto = new BoardDTO(bvo, flist);
		int isOk = bsv.modifyFile(bdto);
		log.info(">>> board modify >> "+(isOk>0? "Ok" :"Fail"));
		reAttr.addFlashAttribute("isOk",isOk);
		return "redirect:/board/detail?bno="+bvo.getBno();
	}
	
	@GetMapping("/remove")
	public String remove(@RequestParam("bno")int bno, RedirectAttributes reAttr) {
		int isOk = bsv.remove(bno);
		log.info(">>> board remove >> "+(isOk>0? "Ok" :"Fail"));
		reAttr.addFlashAttribute("isOk",isOk);
		return "redirect:/board/list";
	}
	
	@DeleteMapping(value = "/file/{uuid}")
	public ResponseEntity<String> removeFile(@PathVariable("uuid") String uuid){
		log.info(">>>> uuid >>"+uuid);
		int isOk = bsv.removeFile(uuid);
		return isOk > 0? new ResponseEntity<String>("1", HttpStatus.OK)
				: new ResponseEntity<String>("0", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
}
