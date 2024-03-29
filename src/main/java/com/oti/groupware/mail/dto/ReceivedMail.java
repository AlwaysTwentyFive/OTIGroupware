package com.oti.groupware.mail.dto;

import java.util.Date;

import lombok.Data;

@Data
public class ReceivedMail {
    private int sendMailId; //부모 메일 id
    private String empIdEmployees; //받는사람
    private String recdMailImportanceYN; //중요도
    private Date recdMailDate; //받은날
    private String recdMailReadReceiptYN; //읽음 여부
    private Date recdMailDelDate; //휴지통에 넣은 시간
    private String recdMailDelYN; //휴지통에 넣었는지 여부
    private String recdMailDelCompleteYN; //완전삭제
    private String empId; //보낸사람
    private String empName;
    private String posName;
    private String depName;
    private String mailId;
    private String sendMailTitle;
    private String sendMailContent;
    private String fileYN; //파일 유무
    private int parentSendMailId; //답장에서 
    private EmployeeInfo parentEmployeeInfo;
    private String parentSendMailTitle;
    private String parentSendMailContent;
}