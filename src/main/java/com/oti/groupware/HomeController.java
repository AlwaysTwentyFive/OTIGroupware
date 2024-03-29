package com.oti.groupware;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.oti.groupware.approval.dto.Document;
import com.oti.groupware.approval.service.DocumentService;
import com.oti.groupware.board.dto.Board;
import com.oti.groupware.board.service.BoardService;
import com.oti.groupware.common.Pager;
import com.oti.groupware.employee.dto.Employee;
import com.oti.groupware.hr.dto.Attendance;
import com.oti.groupware.hr.service.HrService;
import com.oti.groupware.mail.dto.MailCount;
import com.oti.groupware.mail.dto.ReceivedMail;
import com.oti.groupware.mail.service.MailService;

import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
public class HomeController {
	Pager pager;
	List<Document> documents;
	List<Document> homeDocuments;
	List<Document> statisticsDocuments;
	List<Board> boards;
	List<Board> homeBoards;
	
	@Autowired
	private HrService hrService;
	
	@Autowired
	private DocumentService documentService;
	
	@Autowired
	private MailService mailService;
	
	@Autowired
	private BoardService boardService;
	
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String home(HttpSession session, Model model) {
		log.info("정보 로그");
		//세션에 저장된 직원ID 갖고옴
		Employee employee = (Employee) session.getAttribute("employee");
		String empId = employee.getEmpId();
		
		//오늘 출퇴근 시간을 갖고옴
		Attendance attendance = hrService.attendanceToday(employee.getEmpId()); 
		model.addAttribute("attendance", attendance);
		
		//결재
		pager = new Pager();
		documents = documentService.getDraftDocumentList(1, pager, employee.getEmpId());
		statisticsDocuments = documentService.getAllDraftDocumentListForHome(employee.getEmpId());
		
		Map<String, Integer> approvalStatistics = new HashMap<>();
		int homePageTableRowsNum = 3;
		int statisticsDocumemtsSize = statisticsDocuments.size();
		homeDocuments = null;
		if (documents != null && documents.size() > 0) {
			homeDocuments = new ArrayList<Document>();
			
			if (documents.size() > 3) {
				homePageTableRowsNum = 3;
			}
			else {
				homePageTableRowsNum = documents.size();
			}
			
			for (int i = 0; i < homePageTableRowsNum; i++) {
				homeDocuments.add(documents.get(i)); 
			}
			for (int i = 0; i < statisticsDocumemtsSize; i++) {
				approvalStatistics.compute(statisticsDocuments.get(i).getDocState(), (key, value) -> value != null ? value + 1 : 1);
			}
		}
		
		model.addAttribute("documents", homeDocuments);
		
		model.addAttribute("approvalStatistics", approvalStatistics);

		//메일
		int totalRows = mailService.mailRowsCount(employee.getEmpId());
		MailCount mailCount = mailService.mailHomeCount(employee.getEmpId());
		model.addAttribute("mailCount", mailCount);
		Pager pager = new Pager(3, 5, totalRows, 1);
		if (totalRows != 0) {
			List<ReceivedMail> receivedMail = mailService.getReceivedMail(employee.getEmpId(), pager);
			model.addAttribute("receivedmail", receivedMail);
		}
		
		//게시판
		pager = new Pager();
		boards = boardService.getBoardList(pager, 1);
		if (boards != null && boards.size() > 0) {
			homeBoards = new ArrayList<Board>();
			
			if (boards.size() > 3) {
				homePageTableRowsNum = 3;
			}
			else {
				homePageTableRowsNum = boards.size();
			}
			
			for (int i = 0; i < homePageTableRowsNum; i++) {
				homeBoards.add(boards.get(i)); 
			}
		}
		model.addAttribute("boards", homeBoards);
		
		return "home";
	}

	@RequestMapping(value = "/home", method = RequestMethod.POST)
	public String login() {
		return "home";
	}
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String main() {
		return "redirect:/login/login";
	}
	
}
