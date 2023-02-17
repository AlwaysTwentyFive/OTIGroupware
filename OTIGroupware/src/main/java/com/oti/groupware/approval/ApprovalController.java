package com.oti.groupware.approval;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
@RequestMapping(value="/approval")
public class ApprovalController {
	
	@RequestMapping(value = "/main")
	public String main() {
		log.info("정보 로그");
		return "approval/GWApprovalMain";
	}

	@RequestMapping(value = "/write", method=RequestMethod.GET)
	public String write() {
		log.info("정보 로그");
		return "approval/GWApprovalWrite";
	}
	
	@RequestMapping(value = "/draftDocumentBox", method=RequestMethod.GET)
	public String readApprovalDetail() {
		log.info("정보 로그");
		return "approval/GWApprovalDetail";
	}
	
}