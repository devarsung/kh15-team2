package com.kh.semiproject.controller.admin;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.semiproject.dao.PlaceDao;
import com.kh.semiproject.dto.PlaceDto;
import com.kh.semiproject.error.TargetNotFoundException;
import com.kh.semiproject.service.AttachmentService;
import com.kh.semiproject.vo.PlacePageVO;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/admin/place")
public class AdminPlaceController {
	@Autowired
	private PlaceDao placeDao;

	@Autowired
	private AttachmentService attachmentService;

	@GetMapping("/add")
	public String add() {
		return "/WEB-INF/views/admin/place/add.jsp";
	}

	@PostMapping("/add")
	public String add(@ModelAttribute PlaceDto placeDto, HttpSession session, @RequestParam MultipartFile firstImage) throws IllegalStateException, IOException {
		// img
		if (firstImage == null) {
			throw new TargetNotFoundException("파일이 존재하지 않습니다");
		}
		int placeFirstImage = attachmentService.save(firstImage);
		placeDto.setPlaceFirstImage(placeFirstImage);

		int placeNo = placeDao.sequence();
		placeDto.setPlaceNo(placeNo);
		placeDao.insert(placeDto);
		return "redirect:/admin/detail?placeNo=" + placeNo;
	}
	

	@RequestMapping("/delete")
	public String delete(@RequestParam int placeNo) {
		PlaceDto placeDto = placeDao.selectOne(placeNo);
		if(placeDto == null) {
			throw new TargetNotFoundException("존재 하지 않는 여행지 입니다");
		}
		if(placeDao.findAttachment(placeDto.getPlaceFirstImage()) == true) {
			attachmentService.delete(placeNo);
		}
		
		placeDao.delete(placeNo);
		return "redirect:/admin/list";
	}
	
	@RequestMapping("/list")
	public String list(@ModelAttribute("pageVO") PlacePageVO placePageVO, Model model) {
		List<PlaceDto> list = placeDao.selectList(placePageVO);
		model.addAttribute("list", list);
		int count = placeDao.count(placePageVO);
		placePageVO.setCount(count);
		return "/WEB-INF/views/admin/place/list.jsp";
	}

	@RequestMapping("/detail")
	public String detail(@RequestParam int placeNo, Model model) {
		PlaceDto placeDto = placeDao.selectOne(placeNo);
		if(placeDto == null) {
			throw new TargetNotFoundException("존재 하지 않는 여행지 입니다");
		}
		model.addAttribute(placeDto);
		return "/WEB-INF/views/admin/place/detail.jsp";
	}

	@GetMapping("/edit")
	public String edit(@RequestParam int placeNo, Model model) {
		PlaceDto placeDto = placeDao.selectOne(placeNo);
		model.addAttribute(placeDto);
		return "/WEB-INF/views/admin/place/edit.jsp";
	}

	@PostMapping("/edit")
	public String edit(@ModelAttribute PlaceDto placeDto,  @RequestParam MultipartFile firstImage) throws IllegalStateException, IOException {
		boolean success = placeDao.update(placeDto);
		if(placeDto == null) {
			throw new TargetNotFoundException("존재 하지 않는 여행지 입니다");
		}
		if(firstImage != null) {
			try {
				attachmentService.delete(placeDto.getPlaceFirstImage());
			}
			catch(Exception e) {}
			
			int placeFirstImage = attachmentService.save(firstImage);
			placeDto.setPlaceFirstImage(placeFirstImage);
		}
		
		int placeNo = placeDto.getPlaceNo();
		return "redirect:/admin/detail?placeNo=" + placeNo;
	}

	@RequestMapping("/image")
	public String image() {
		
		return "";
	}








}










