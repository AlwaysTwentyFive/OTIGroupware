package com.oti.groupware.employee.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.oti.groupware.employee.dto.Employee;
import com.oti.groupware.employee.dto.EmployeeDetail;
import com.oti.groupware.employee.service.EmployeeService;
import com.oti.groupware.interceptor.Authorization;

import lombok.extern.log4j.Log4j2;
/**
 * 
 * @author 장영은
 *
 */
@Controller
@Log4j2
@RequestMapping("/employee")
@Authorization
public class EmployeeController {
	
	@Autowired
	private EmployeeService employeeService;
	
	//휴대전화 유효성 체크
	@RequestMapping(value="/phonecheck", method = RequestMethod.POST)
	@ResponseBody
	public String phoneCheck(String phoneNumber) {
		String result = employeeService.phoneCheck(phoneNumber);
		return result;
	}
	
	//이메일 유효성 체크
	@RequestMapping(value="/mailidcheck", method = RequestMethod.POST)
	@ResponseBody
	public String mailIdCheck(String mailId) {
		String result = employeeService.mailIdCheck(mailId);
		return result;
	}
	
	/**
	 * Join - 임직원 등록
	 * @param employee - DTO
	 * @param employeeDetail - DTO
	 * @param empBirthdayStr - 생년월일이 String이므로 따로 받아옴
	 * @param employmentDateStr - 입사일에 대한 String
	 * @return 성공시 redirect를 통해 인사관리의 메인인 select 페이지로 이동한다.
	 */
	@PostMapping(value = "/insertemployee")
	@Authorization("ROLE_HR")
	public String insertEmployee(Employee employee, EmployeeDetail employeeDetail) throws IOException{
		//파일 데이터
		MultipartFile employeeFile = employee.getEmpFileDataMulti();
		if(!employeeFile.isEmpty()) {
			String attachsname = new Date().getTime() +"-"+employee.getEmpId();
			employee.setEmpFileData(employeeFile.getBytes());
			employee.setEmpFileName(attachsname);
			//파일의 타입 설정
			employee.setEmpFileType(employeeFile.getContentType());
			//서버 파일 시스템에 파일로 저장
			File file = new File("C:/Temp/uploadFiles/"+attachsname);
			employeeFile.transferTo(file);
		}
		//insert를 위한 service
		employeeService.insertEmployee(employee, employeeDetail);
		return "redirect:/employee/selectemployee";
	}
	
	
	// 임직원 등록
	@GetMapping(value = "/insertemployee")
	@Authorization("ROLE_HR")
	public String insertEmployee() {
		return "employee/insertemployee";
	}
	
	// 마이페이지
	@RequestMapping(value = "/mypage", method = RequestMethod.GET)
	public String mypage(HttpSession session, Model model) {
		Employee employee = (Employee)session.getAttribute("employee");
		employee = employeeService.getEmployee(employee.getEmpId());
		if(employee!=null) {
			Date now = new Date(System.currentTimeMillis());
			EmployeeDetail employeeDetail = employeeService.getEmployeeDetail(employee.getEmpId(), now);
			model.addAttribute("subEmployee", employee);
			model.addAttribute("employeeDetail", employeeDetail);
		}
		return "employee/mypage";
	}
	
	@RequestMapping(value = "/updateimg", method = RequestMethod.POST)
	@ResponseBody
	public void updateImg(HttpSession session, MultipartFile multi) throws IOException {
		Employee employee =(Employee)session.getAttribute("employee");
		MultipartFile imgFile = multi;
		if(!imgFile.isEmpty()) {
			String attachsname = new Date().getTime() +"-"+employee.getEmpId();
			employee.setEmpFileData(imgFile.getBytes());
			employee.setEmpFileName(attachsname);
			//파일의 타입 설정
			employee.setEmpFileType(imgFile.getContentType());
			//서버 파일 시스템에 파일로 저장
			File file = new File("C:/Temp/uploadFiles/"+attachsname);
			imgFile.transferTo(file);
		}
		employeeService.updateImg(employee);
	}
	
	@RequestMapping(value = "/password", method = RequestMethod.POST)
	@ResponseBody
	public void updatePassword(HttpSession session, String password) {
		log.info("실행");
		log.info(password);
		Employee employee =(Employee)session.getAttribute("employee");
		String empId = employee.getEmpId();
		if(password != null) {
			employeeService.updatePassword(empId, password);
		}
	}

	//임직원 조회
	@RequestMapping(value = "/selectemployee", method = RequestMethod.GET)
	public String selectEmployee() {
		return "employee/selectemployee";
	}
	
	// 임직원 조회
	@RequestMapping(value = "/updateemployee", method = RequestMethod.GET)
	@Authorization("ROLE_HR")
	public String updateEmployee() {
		return "employee/updateemployee";
	}


	// 조직도
	@RequestMapping(value = "/organizationchart", method = RequestMethod.GET)
	public String organizationChart() {
		return "employee/organizationchart";
	}
	
	@RequestMapping(value = "/searchdepartment", method = RequestMethod.POST)
	@ResponseBody
	public List<String> searchDepartment(HttpSession session, String depId) {
		log.info("실행");
		List<String> depEmployee = new ArrayList<>();
		depEmployee = employeeService.getDepartment(Integer.parseInt(depId));
		return depEmployee;
	}
	
	//직원정보 디테일 popup
	@RequestMapping(value = "/detailpopup", method = RequestMethod.GET)
	public String detailPopup() {
		return "employee/detailpopup";
	}
	
	//비밀번호 초기화popup
	@RequestMapping(value = "/deletepasswordpopup", method = RequestMethod.GET)
	public String deletePasswordPopup() {
		return "employee/deletePasswordPopup";
	}
	
	//접근권한 페이지
	@RequestMapping(value="/error", method=RequestMethod.GET)
	public String errorEmployee() {
		return "employee/error";
	}
}
