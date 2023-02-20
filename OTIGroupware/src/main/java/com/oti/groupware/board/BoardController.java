package com.oti.groupware.board;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
public class BoardController {
	
	//공지게시판
	@RequestMapping(value = "/board", method = RequestMethod.GET)
	public String mail() {
		log.debug("디버그 로그");
		log.info("정보 로그");
		log.warn("경고 로그");
		log.error("에러 로그");
		return "board/board";
	}
	
	//인사발령
	@RequestMapping(value = "/hrBoard", method = RequestMethod.GET)
	public String hrBoard() {
		return "board/hrBoard";
	}

	//경조사
	@RequestMapping(value = "/familyEventBoard", method = RequestMethod.GET)
	public String familyEventBoard() {
		return "board/familyEventBoard";
	}
	
	//경조사
	@RequestMapping(value = "/writeBoard", method = RequestMethod.GET)
	public String writeBoard() {
		return "board/writeBoard";
	}
	
	
}
