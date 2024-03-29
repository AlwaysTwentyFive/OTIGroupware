package com.oti.groupware.approval.service;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.oti.groupware.approval.component.ApprovalHandler;
import com.oti.groupware.approval.component.DocumentContentProvider;
import com.oti.groupware.approval.component.DocumentParser;
import com.oti.groupware.approval.dao.ApprovalLineDAO;
import com.oti.groupware.approval.dao.DocumentDAO;
import com.oti.groupware.approval.dao.DocumentFileDAO;
import com.oti.groupware.approval.dto.ApprovalLine;
import com.oti.groupware.approval.dto.ApprovalLines;
import com.oti.groupware.approval.dto.Document;
import com.oti.groupware.approval.dto.DocumentFile;
import com.oti.groupware.approval.dto.SearchQuery;
import com.oti.groupware.common.Pager;
import com.oti.groupware.common.dto.Organization;
import com.oti.groupware.employee.dao.EmployeeDAO;
@Service
public class DocumentServiceImpl implements DocumentService {
	Document document;
	ApprovalLine approvalLine;
	List<ApprovalLine> approvalLines;
	List<Organization> employees;
	DocumentFile documentFile;
	
	/*
	 * Request로 들어온 HTML을 Parse
	 * - Document getParsedDocument()
	 */
	@Autowired
	DocumentParser documentParser;
	
	/*
	 * Document Type에 따라 document의 Id와 Retention Period를 제공
	 * -String getDocumentIdByDocumentType()
	 * -String getDocumentRetentionPeriodByDocumentType()
	 */
	@Autowired
	DocumentContentProvider documentContentProvider;
	
	/*
	 * Request로 들어온 요청에 따라서 결재를 처리하기 위한 Handler
	 * int process() (0: 처리하지 못함, 1: 처리)
	 */
	@Autowired
	ApprovalHandler approvalHandler;

	@Autowired
	DocumentDAO documentDAO;
	
	@Autowired
	ApprovalLineDAO approvalLineDAO;
	
	@Autowired
	EmployeeDAO employeeDAO;
	
	@Autowired
	DocumentFileDAO documentFileDAO;
	
	@Override
	@Transactional
	public Document readDocument(String docId) {
		document = documentDAO.getDocumentById(docId);
		if (docId != null && !("".equals(docId)) && documentFileDAO.getDocumentFilesById(docId) != null) {
			document.setDocumentFiles(documentFileDAO.getDocumentFilesById(docId));
		}
		return document;
	}
	
	@Override
	public DocumentFile downloadDocumentFile(int docFileId) {
		return documentFileDAO.getDocumentFileById(docFileId);
	}
	
	@Override
	@Transactional
	public void saveDocument(ApprovalLines approvalLines, Document document, MultipartFile[] multipartFiles) throws IOException {
		String drafterId = approvalLines.getEmpId()[0];
		int approvalLineSize = approvalLines.getEmpId().length;
		
		document.setEmpId(drafterId);
		document.setDocMaxStep(approvalLineSize);
		document.setDocReportDate(Timestamp.valueOf(LocalDateTime.now()));
		document.setDocWriteDate(Timestamp.valueOf(LocalDateTime.now()));
		
		//결재문서는 타입에 따라 아이디와 보관기간을 받음
		String documentType = document.getDocType();
		document.setDocId(documentContentProvider.getDocumentIdByDocumentType(documentType, document.getDocTempYn()));
		document.setDocRetentionPeriod(documentContentProvider.getDocumentRetentionPeriodByDocumentType(documentType));
		
		//결재 문서에 아이디랑 번호 부여해주기
		documentParser.setParsingTarget(document.getDocContent());
		documentParser.getElementById("documentId").text(document.getDocId());
		documentParser.getElementById("documentRetentionPeriod").text(document.getDocRetentionPeriod());
		document.setDocContent(documentParser.getParsedTarget());
		
		documentDAO.insertDraftDocument(document);
		
		String docId = document.getDocId();
		
		if (multipartFiles != null && multipartFiles.length > 0) {
			for (MultipartFile multipartFile : multipartFiles) {
				if (!("".equals(multipartFile.getOriginalFilename())) && multipartFile.getOriginalFilename() != null) {
					documentFile = new DocumentFile();
					documentFile.setDocId(docId);
					documentFile.setDocFileData(multipartFile.getBytes());
					documentFile.setDocFileLength(multipartFile.getSize());
					documentFile.setDocFileName(multipartFile.getOriginalFilename());
					documentFile.setDocFileType(multipartFile.getContentType());
					documentFileDAO.insertDocumentFile(documentFile);
				}
			}
		}
		
		for (int i = 0; i < approvalLineSize; i++) {
			approvalLine = new ApprovalLine();
			approvalLine.setDocId(document.getDocId());
			approvalLine.setEmpId(approvalLines.getEmpId()[i]);
			approvalLine.setAprvLineOrder(approvalLines.getAprvLineOrder()[i]);
			approvalLine.setAprvLineRole(approvalLines.getAprvLineRole()[i]);
			approvalLine.setAprvLineState(approvalLines.getAprvLineState()[i]);
			approvalLineDAO.defaultInsertApprovalLine(approvalLine);
		}
	}
	
	@Override
	@Transactional
	public void updateDocument(ApprovalLines approvalLines, Document document, MultipartFile[] multipartFiles) throws IOException {
		String drafterId = approvalLines.getEmpId()[0];
		int approvalLineSize = approvalLines.getEmpId().length;
		
		document.setEmpId(drafterId);
		document.setDocMaxStep(approvalLineSize);
		document.setDocReportDate(Timestamp.valueOf(LocalDateTime.now()));
		document.setDocWriteDate(Timestamp.valueOf(LocalDateTime.now()));
		
		documentDAO.updateDocument(document);
		
		String docId = document.getDocId();
		
		//결재선과 첨부파일 초기화 후 새로이 삽입
		approvalLineDAO.deleteApprovalLineByDocId(docId);
		documentFileDAO.deleteDocumentFile(docId);
		
		if (multipartFiles != null && multipartFiles.length > 0) {
			for (MultipartFile multipartFile : multipartFiles) {
				if (!("".equals(multipartFile.getOriginalFilename())) && multipartFile.getOriginalFilename() != null) {
					documentFile = new DocumentFile();
					documentFile.setDocId(docId);
					documentFile.setDocFileData(multipartFile.getBytes());
					documentFile.setDocFileLength(multipartFile.getSize());
					documentFile.setDocFileName(multipartFile.getOriginalFilename());
					documentFile.setDocFileType(multipartFile.getContentType());
					documentFileDAO.insertDocumentFile(documentFile);
				}
			}
		}
		
		for (int i = 0; i < approvalLineSize; i++) {
			approvalLine = new ApprovalLine();
			approvalLine.setDocId(document.getDocId());
			approvalLine.setEmpId(approvalLines.getEmpId()[i]);
			approvalLine.setAprvLineOrder(approvalLines.getAprvLineOrder()[i]);
			approvalLine.setAprvLineRole(approvalLines.getAprvLineRole()[i]);
			approvalLine.setAprvLineState(approvalLines.getAprvLineState()[i]);
			approvalLineDAO.defaultInsertApprovalLine(approvalLine);
		}
	}

	@Override
	public int deleteDocument(String docId) {
		return documentDAO.deleteDocument(docId);
	}
	
	//승인 처리
	@Override
	@Transactional
	public boolean handleApproveRequest(String state, String opinion, String docId, String empId, String docType) {
		document = documentDAO.getDocumentById(docId);
		approvalLine = approvalLineDAO.getApprovalLineById(empId, docId);
		approvalHandler.setDocument(document);
		approvalHandler.setApprovalLine(approvalLine);
		
		int documentMaxStep = document.getDocMaxStep();
		
		boolean isApproved = approvalHandler.handleApprove(state, opinion, documentMaxStep);
		
		if (isApproved) {
			document = approvalHandler.getDocument();
			approvalLine = approvalHandler.getApprovalLine();
			
			//문서 내용에 공란 상태인 결재 내용 반영하기
			String rId = "r" + empId;
			documentParser.setParsingTarget(document.getDocContent());
			documentParser.getElementById("formApprovalState").getElementsByClass(rId).get(0).text(state);
			documentParser.getElementById("formApprovalDate").getElementsByClass(rId).get(0).text(LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy/MM/dd")));
			document.setDocContent(documentParser.getParsedTarget());
			
			//휴일근무품의서가 승인되면 기안자의 대체휴무 +1
			if ("승인".equals(document.getDocState()) && "휴일근무품의서".equals(docType)) {
				employeeDAO.updateEmployeeSubstitueReserve(document.getEmpId());
			}
			
			documentDAO.updateDocument(document);
			approvalLineDAO.updateApprovalLine(approvalLine);
			return true;
		}
		else {
			return false;
		}
	}
	
	//반려 처리
	@Override
	@Transactional
	public boolean handleReturnRequest(String state, String opinion, String docId, String empId) {
		document = documentDAO.getDocumentById(docId);
		approvalLine = approvalLineDAO.getApprovalLineById(empId, docId);
		approvalHandler.setDocument(document);
		approvalHandler.setApprovalLine(approvalLine);
		
		boolean isReturned = approvalHandler.handleReturn(state, opinion);
		
		if (isReturned) {
			document = approvalHandler.getDocument();
			approvalLine = approvalHandler.getApprovalLine();
			
			//문서 내용에 공란 상태인 결재 내용 반영하기
			String rId = "r" + empId;
			documentParser.setParsingTarget(document.getDocContent());
			documentParser.getElementById("formApprovalState").getElementsByClass(rId).get(0).text(state);
			documentParser.getElementById("formApprovalDate").getElementsByClass(rId).get(0).text(LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy/MM/dd")));
			document.setDocContent(documentParser.getParsedTarget());
			//
			
			documentDAO.updateDocument(document);
			approvalLineDAO.updateApprovalLine(approvalLine);
			return true;
		}
		else {
			return false;
		}
	}
	
	//회수 처리
	@Override
	@Transactional
	public boolean handleRetrieveRequest(String state, String docId, String empId) {
		document = documentDAO.getDocumentById(docId);
		approvalLine = approvalLineDAO.getApprovalLineById(empId, docId);
		approvalLines = approvalLineDAO.getApprovalLinesBydocId(docId);
		approvalHandler.setDocument(document);
		approvalHandler.setApprovalLine(approvalLine);
		approvalHandler.setApprovalLines(approvalLines);
		
		boolean isRetrieved = approvalHandler.handleRetrieve(state);
		
		if (isRetrieved) {
			document = approvalHandler.getDocument();
			approvalLine = approvalHandler.getApprovalLine();
			approvalLines = approvalHandler.getApprovalLines();
			
			//회수를 하여 결재선의 상태가 초기화됨
			for (ApprovalLine approvalLinesElement : approvalLines) {
				if ("결재".equals(approvalLinesElement.getAprvLineRole())) {
					String rId = "r" + approvalLinesElement.getEmpId();
					documentParser.setParsingTarget(document.getDocContent());
					documentParser.getElementById("formApprovalState").getElementsByClass(rId).get(0).text("공란");
					documentParser.getElementById("formApprovalDate").getElementsByClass(rId).get(0).text("공란");
				}
			}
			document.setDocContent(documentParser.getParsedTarget());
			//
			
			documentDAO.updateDocument(document);
			approvalLineDAO.updateApprovalLine(approvalLine);
			approvalLines = approvalHandler.getApprovalLines();
			for (ApprovalLine approvalLinesElement : approvalLines) {
				if ("결재".equals(approvalLinesElement.getAprvLineRole())) {
					approvalLineDAO.updateApprovalLine(approvalLinesElement);
				}
			}
			return true;
		}
		else {
			return false;
		}
	}
	
	//열람 처리
	@Override
	@Transactional
	public boolean handleOpenRequest(String state, String docId, String empId) {
		document = documentDAO.getDocumentById(docId);
		approvalLine = approvalLineDAO.getApprovalLineById(empId, docId);
		approvalHandler.setDocument(document);
		approvalHandler.setApprovalLine(approvalLine);
		
		boolean isOpened = approvalHandler.handleOpen();
		
		if (isOpened) {
			document = approvalHandler.getDocument();
			approvalLine = approvalHandler.getApprovalLine();
			
			documentDAO.updateDocument(document);
			approvalLineDAO.updateApprovalLine(approvalLine);
			return true;
		}
		else {
			return false;
		}
	}

	//목록 조회 메소드들
	@Override
	@Transactional
	public List<Document> getDraftDocumentListForHome(int pageNo, Pager pager, String empId) {
		int totalRows = documentDAO.getDraftDocumentCount(empId);
		pager.setRowsPerPage(3);
		pager.setPagesPerGroup(10);
		pager.setTotalRows(totalRows);
		pager.setPageNo(pageNo);
		return documentDAO.getDraftDocumentList(pager, empId);
	}
	
	@Override
	@Transactional
	public List<Document> getAllDraftDocumentListForHome(String empId) {
		return documentDAO.getAllDraftDocmentState(empId);
	}
	
	@Override
	@Transactional
	public List<Document> getDraftDocumentList(int pageNo, Pager pager, String empId) {
		int totalRows = documentDAO.getDraftDocumentCount(empId);
		pager.setRowsPerPage(10);
		pager.setPagesPerGroup(10);
		pager.setTotalRows(totalRows);
		pager.setPageNo(pageNo);
		return documentDAO.getDraftDocumentList(pager, empId);
	}
	
	@Override
	@Transactional
	public List<Document> getPendedDocumentList(int pageNo, Pager pager, String empId) {
		int totalRows = documentDAO.getPendedDocumentCount(empId);
		pager.setRowsPerPage(10);
		pager.setPagesPerGroup(10);
		pager.setTotalRows(totalRows);
		pager.setPageNo(pageNo);
		return documentDAO.getPendedDocumentList(pager, empId);
	}
	
	@Override
	@Transactional
	public List<Document> getReturnedDocumentList(int pageNo, Pager pager, String empId) {
		int totalRows = documentDAO.getReturnedDocumentCount(empId);
		pager.setRowsPerPage(10);
		pager.setPagesPerGroup(10);
		pager.setTotalRows(totalRows);
		pager.setPageNo(pageNo);
		return documentDAO.getReturnedDocumentList(pager, empId);
	}

	@Override
	@Transactional
	public List<Document> getTakePartInDocumentList(int pageNo, Pager pager, String empId) {
		int totalRows = documentDAO.getTakePartInDocumentCount(empId);
		pager.setRowsPerPage(10);
		pager.setPagesPerGroup(10);
		pager.setTotalRows(totalRows);
		pager.setPageNo(pageNo);
		return documentDAO.getTakePartInDocumentList(pager, empId);
	}

	@Override
	@Transactional
	public List<Document> getTempDocumentList(int pageNo, Pager pager, String empId) {
		int totalRows = documentDAO.getTempDocumentCount(empId);
		pager.setRowsPerPage(10);
		pager.setPagesPerGroup(10);
		pager.setTotalRows(totalRows);
		pager.setPageNo(pageNo);
		return documentDAO.getTempDocumentList(pager, empId);
	}
	
	
	//검색
	@Override
	@Transactional
	public List<Document> getDraftDocumentListByQuery(SearchQuery searchQuery, Pager pager, String empId) {
		int totalRows = documentDAO.getDraftDocumentCountByQuery(empId, searchQuery);
		int pageNo = searchQuery.getPageNo();
		pager.setRowsPerPage(10);
		pager.setPagesPerGroup(10);
		pager.setTotalRows(totalRows);
		pager.setPageNo(pageNo);
		return documentDAO.getDraftDocumentListByQuery(pager, empId, searchQuery);
	}
	
	@Override
	@Transactional
	public List<Document> getTakePartInDocumentListByQuery(SearchQuery searchQuery, Pager pager, String empId) {
		int totalRows = documentDAO.getTakePartInDocumentCountByQuery(empId, searchQuery);
		int pageNo = searchQuery.getPageNo();
		pager.setRowsPerPage(10);
		pager.setPagesPerGroup(10);
		pager.setTotalRows(totalRows);
		pager.setPageNo(pageNo);
		return documentDAO.getTakePartInDocumentListByQuery(pager, empId, searchQuery);
	}
	
	@Override
	@Transactional
	public List<Document> getPendedDocumentListByQuery(SearchQuery searchQuery, Pager pager, String empId) {
		int totalRows = documentDAO.getPendedDocumentCountByQuery(empId, searchQuery);
		int pageNo = searchQuery.getPageNo();
		pager.setRowsPerPage(10);
		pager.setPagesPerGroup(10);
		pager.setTotalRows(totalRows);
		pager.setPageNo(pageNo);
		return documentDAO.getPendedDocumentListByQuery(pager, empId, searchQuery);
	}

	@Override
	@Transactional
	public List<Document> getReturnedDocumentListByQuery(SearchQuery searchQuery, Pager pager, String empId) {
		int totalRows = documentDAO.getReturnedDocumentCountByQuery(empId, searchQuery);
		int pageNo = searchQuery.getPageNo();
		pager.setRowsPerPage(10);
		pager.setPagesPerGroup(10);
		pager.setTotalRows(totalRows);
		pager.setPageNo(pageNo);
		return documentDAO.getReturnedDocumentListByQuery(pager, empId, searchQuery);
	}

	@Override
	@Transactional
	public List<Document> getTempDocumentListByQuery(SearchQuery searchQuery, Pager pager, String empId) {
		int totalRows = documentDAO.getTempDocumentCountByQuery(empId, searchQuery);
		int pageNo = searchQuery.getPageNo();
		pager.setRowsPerPage(10);
		pager.setPagesPerGroup(10);
		pager.setTotalRows(totalRows);
		pager.setPageNo(pageNo);
		return documentDAO.getTempDocumentListByQuery(pager, empId, searchQuery);
	}
	
	@Override
	public List<Organization> getOrganization() {
		employees = employeeDAO.getOrganization();
		return employees;
	}

}
