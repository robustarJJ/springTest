package com.myweb.www.domain;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class CommentVO {
	
	private long cno;
	private long bno;
	private String writer;
	private String content;
	private String regAt;
	private String modAt;
}

//create table comment(
//cno bigint auto_increment,
//bno bigint not null,
//writer varchar(100) not null,
//content text not null,
//reg_at datetime default now(),
//mod_at datetime default now(),
//primary key (cno));