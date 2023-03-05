package com.oti.groupware.hr.dto;

import java.util.Date;

import lombok.Data;

@Data
public class AttendanceException {
    private int atdExcpId;
    private String empId;
    private String atdExcpReason;
    private String atdExcpCategory;
    private String atdExcpInTime;
    private String atdExcpOutTime;
    private String atdExcpDate;
    private Date atdExcpProcessDate;
    private String atdExcpApprovalEmp;
    private String atdExcpOpinion;
    private String atdExcpProcessState;
}