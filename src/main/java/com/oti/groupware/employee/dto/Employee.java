package com.oti.groupware.employee.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class Employee {

    private String empId;
    private int posId;
    private String posName;
    private int depId;
    private String depName;
    private String empMail;
    private String empName;
    private String empPassword;
    private String empExtensionNumber;
    private String empPhoneNumber;
    private double empLeaveReserve;
    private double empSubstitueReserve;
    private int empLoginFailuresCnt;
    private byte[] empFileData;
    private MultipartFile empFileDataMulti;
    private String empFileType;
    private String empFileName;
    private String initialPasswordYN;
}