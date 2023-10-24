package com.myweb.www.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@ToString
@Setter
@Getter
public class BoardVO {
	private long bno;
	private String title;
	private String content;
	private String writer;
	private String regAt;
	private String modAt;
	private int readCount;
	private int cmtQty;
	private int hasFile;
	
}

//create table board(
//bno bigint not null auto_increment,
//title varchar(200) not null,
//content text not null,
//writer varchar(100) not null,
//reg_at datetime default now(),
//mod_at datetime default now(),
//read_count int default 0,
//cmt_qty int default 0,
//has_file int default 0,
//primary key(bno));

