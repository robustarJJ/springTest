package com.myweb.www.repository;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.myweb.www.domain.CommentVO;
import com.myweb.www.domain.PagingVO;

public interface CommentDAO {

	int insert(CommentVO cvo);

	List<CommentVO> getList(int bno);

	int delete(int cno);

	int edit(CommentVO cvo);

	int selectOntBnoTotalCount(long bno);

	List<CommentVO> selectListPaging(@Param("bno") long bno, @Param("pgvo") PagingVO pgvo);

}
