package com.oti.groupware.approval.service;

import java.util.List;

import com.oti.groupware.approval.dto.Document;
import com.oti.groupware.approval.dto.DocumentContent;
import com.oti.groupware.common.Pager;
import com.oti.groupware.common.dto.Organization;

public interface DocumentService {
	public Document readDocument(String docId);
	int saveDocument(String html, DocumentContent documentContent, String docTempYn, String drafterId);
	public boolean processApprovalRequest(String state, String opinion, String docId, String empId);
	
	
	public List<Document> getDraftDocumentList(int pageNo, Pager pager, String empId);
	public List<Document> getpendedDocumentList(int pageNo, Pager pager, String empId);
	public List<Document> getReturnedDocumentList(int pageNo, Pager pager, String empId);

	public List<Document> getTempDocumentList(int pageNo, Pager pager, String empId);
	public List<Document> getCompletedDocumentList(int pageNo, Pager pager,String empId);
	
	List<Document> getDraftDocumentListByState(int pageNo, Pager pager, String empId, String state);
	
	public List<Organization> getOrganization();
}