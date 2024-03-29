package com.oti.groupware.approval.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.oti.groupware.approval.dto.ApprovalLine;
import com.oti.groupware.common.dto.Organization;

public interface ApprovalLineDAO {
	public ApprovalLine getApprovalLineById(@Param("empId") String empId, @Param("docId") String docId);
	public void insertApprovalLine(ApprovalLine approvalLine);
	public void updateApprovalLine(ApprovalLine approvalLine);
	public void deleteApprovalLine(@Param("empId") String empId, @Param("docId") String docId);
	public void deleteApprovalLineByDocId(String docId);
    
	public void defaultInsertApprovalLine(ApprovalLine approvalLine);
	public List<ApprovalLine> getApprovalLinesBydocId(String docId);
	public void insertDraftApprovalLine(ApprovalLine approvalLine);
	public int updateApprovalLineOpener(ApprovalLine approvalLine);
}