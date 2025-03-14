package com.kh.semiproject.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.semiproject.dao.PlaceDao;
import com.kh.semiproject.dao.ReviewListViewDao;
import com.kh.semiproject.dto.PlaceDto;
import com.kh.semiproject.dto.PlaceListViewDto;
import com.kh.semiproject.error.TargetNotFoundException;
import com.kh.semiproject.vo.PlacePageVO;

@Controller
@RequestMapping("/place")
public class PlaceController {

	@Autowired
	public PlaceDao placeDao;
	
	@Autowired
	private ReviewListViewDao reviewListViewDao;
	
	@RequestMapping("/list")
	public String list(@ModelAttribute ("pageVO")PlacePageVO placePageVO, Model model) {
		if(placePageVO.getOrder() == null || placePageVO.getOrder().isEmpty()) {
			placePageVO.setOrder("place_wtime");
		}
		
		if(placePageVO.getColumn() == null || placePageVO.getColumn().isEmpty()) {
			placePageVO.setColumn("place_title");
		}
		
		List<PlaceListViewDto> list = placeDao.selectList(placePageVO);
		model.addAttribute("list", list);
		int count = placeDao.count(placePageVO);
		placePageVO.setCount(count);
		return "/WEB-INF/views/place/list.jsp";
	}
	
	@RequestMapping("/detail")
	public String detail(@RequestParam int placeNo, @RequestParam(required = false) String source, Model model) {
		PlaceDto placeDto = placeDao.selectOne(placeNo);
		if(placeDto == null) {
			throw new TargetNotFoundException("존재 하지 않는 여행지 입니다");
		}
		model.addAttribute("placeDto",placeDto);
		List<Integer> attachmentNos = placeDao.selectDetailImagesNos(placeNo, placeDto.getPlaceFirstImage());
		model.addAttribute("attachmentNos", attachmentNos);
		
		// top 5 리뷰 추출
		model.addAttribute("reviews",reviewListViewDao.selectListByPlace(placeNo));
		
		//별점 추출
		model.addAttribute("placeStar", placeDao.selectStarAvg(placeNo));
		
		//어디서 왔는지
		model.addAttribute("source", source);
		return "/WEB-INF/views/place/detail.jsp";
	}


	


}
