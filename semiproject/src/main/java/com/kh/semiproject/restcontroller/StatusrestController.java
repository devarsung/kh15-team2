package com.kh.semiproject.restcontroller;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.kh.semiproject.dao.StatusDao;
import com.kh.semiproject.vo.StatusVO;

@CrossOrigin
@RestController
@RequestMapping("/rest/status")
public class StatusrestController {
	@Autowired
	private StatusDao statusDao;
	
	@RequestMapping("/memberGender")
	public List<StatusVO> memberGender(){
		return statusDao.memberGenderGroup();
	}
	
}
