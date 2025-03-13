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
import com.kh.semiproject.dao.ReviewListViewDao;
import com.kh.semiproject.dto.PlaceDto;
import com.kh.semiproject.dto.PlaceListViewDto;
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

	@Autowired
	private ReviewListViewDao reviewListViewDao;
	
	@GetMapping("/add")
	public String add() {
		return "/WEB-INF/views/admin/place/add.jsp";
	}

	@PostMapping("/add")
	public String add(@ModelAttribute PlaceDto placeDto, HttpSession session,
			@RequestParam MultipartFile firstImage, @RequestParam List<MultipartFile> detailImages) 
			throws IllegalStateException, IOException {
		//작성자 설정
		String userId = (String)session.getAttribute("userId");
		placeDto.setPlaceWriter(userId);
		
		//placeNo 시퀀스 얻기
		int placeNo = placeDao.sequence();
		placeDto.setPlaceNo(placeNo);
		
		//대표이미지 저장 후 placeDto에 대표이미지 번호 설정
		if(firstImage.isEmpty() == false) {
			int firstImageNo = attachmentService.save(firstImage);
			placeDto.setPlaceFirstImage(firstImageNo);
			
			//placeDto 저장, 여행 이미지 정보 등록(연결테이블)
			placeDao.insert(placeDto);
			placeDao.insertPlaceImage(placeNo, firstImageNo);
		}
		
		//상세 이미지 처리
		//아무것도 없어도 size는 1이기에 isEmpty로 확인한다
		for(MultipartFile detailImage : detailImages) {
			if(detailImage.isEmpty()) {
				break;
			}
			
			//이미지 저장, 여행지 이미지 정보 등록
			int attachmentNo = attachmentService.save(detailImage);
			placeDao.insertPlaceImage(placeNo, attachmentNo);
		}
		
		return "redirect:detail?placeNo=" + placeNo;
	}

	@RequestMapping("/delete")
	public String delete(@RequestParam int placeNo) {
		PlaceDto placeDto = placeDao.selectOne(placeNo);
		if(placeDto == null) {
			throw new TargetNotFoundException("존재 하지 않는 여행지 입니다");
		}
		
		List<Integer> imageNos = placeDao.selectPlaceImagesNos(placeNo);
		for(int imageNo : imageNos) {
			try {
				attachmentService.delete(imageNo);
			}
			catch(Exception e) {}
		}
		
		placeDao.delete(placeNo);
		return "redirect:list";
	}
	
	@RequestMapping("/deleteAll")
	public String deleteAll(@RequestParam List<Integer> placeNoList) {
		for(int placeNo : placeNoList) {
			
			List<Integer> imageNos = placeDao.selectPlaceImagesNos(placeNo);
			for(int imageNo : imageNos) {
				try {
					attachmentService.delete(imageNo);
				}
				catch(Exception e) {}
			}
			
			placeDao.delete(placeNo);
		}
		
		return "redirect:list";
	}
	
	@RequestMapping("/list")
	public String list(@ModelAttribute("pageVO") PlacePageVO placePageVO, Model model) {
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
		return "/WEB-INF/views/admin/place/list.jsp";
	}

	@RequestMapping("/detail")
	public String detail(@RequestParam int placeNo, Model model) {
		PlaceDto placeDto = placeDao.selectOne(placeNo);
		if(placeDto == null) {
			throw new TargetNotFoundException("존재 하지 않는 여행지 입니다");
		}
		
		model.addAttribute("placeDto", placeDto);
		List<Integer> attachmentNos = placeDao.selectDetailImagesNos(placeNo, placeDto.getPlaceFirstImage());
		model.addAttribute("attachmentNos", attachmentNos);
		//System.out.println(attachmentNos);
		
		// top 5 리뷰 추출
		model.addAttribute("reviews",reviewListViewDao.selectListByPlace(placeNo));
		
		//별점 추출
		model.addAttribute("placeStar", placeDao.selectStarAvg(placeNo));
		return "/WEB-INF/views/admin/place/detail.jsp";
	}

	@GetMapping("/edit")
	public String edit(@RequestParam int placeNo, Model model) {
		PlaceDto placeDto = placeDao.selectOne(placeNo);
		model.addAttribute("placeDto", placeDto);
		List<Integer> detailImagesNos = placeDao.selectDetailImagesNos(placeNo, placeDto.getPlaceFirstImage());
		model.addAttribute("detailImagesNos", detailImagesNos);
		return "/WEB-INF/views/admin/place/edit.jsp";
	}

	@PostMapping("/edit")
	public String edit(@ModelAttribute PlaceDto placeDto, 
					@RequestParam boolean firstImageChange, @RequestParam MultipartFile firstImage,
					@RequestParam List<Integer> deletedOldNos, @RequestParam List<MultipartFile> detailImages) 
			throws IllegalStateException, IOException {
		//원래 여행지 정보 가져오기
		PlaceDto originDto = placeDao.selectOne(placeDto.getPlaceNo());
		if(originDto == null) throw new TargetNotFoundException("존재하지 않는 여행지입니다");
		
		//교체
		originDto.setPlaceRegion(placeDto.getPlaceRegion());
		originDto.setPlaceType(placeDto.getPlaceType());
		originDto.setPlaceTitle(placeDto.getPlaceTitle());
		originDto.setPlacePost(placeDto.getPlacePost());
		originDto.setPlaceAddress1(placeDto.getPlaceAddress1());
		originDto.setPlaceAddress2(placeDto.getPlaceAddress2());
		originDto.setPlaceLat(placeDto.getPlaceLat());
		originDto.setPlaceLng(placeDto.getPlaceLng());
		originDto.setPlaceOverview(placeDto.getPlaceOverview());
		originDto.setPlaceTel(placeDto.getPlaceTel());
		originDto.setPlaceWebsite(placeDto.getPlaceWebsite());
		originDto.setPlaceParking(placeDto.getPlaceParking());
		originDto.setPlaceOperate(placeDto.getPlaceOperate());
		
		//대표이미지
		if(firstImageChange) {
			if(firstImage.isEmpty()) {
				//이 경우 프론트에서 막았지만 혹시 모르니 확인
				System.out.println("실행되어서는 안되는 문장임. 짜증나게 하지마라");
			}
			else {
				try {
					//기존 이미지 지우기
					//이미지 지워지면 연결테이블의 레코드도 지워진다(on delete cascade로 만들었으니까)
					//System.out.println("너 왜 실행안되니?");
					attachmentService.delete(originDto.getPlaceFirstImage());
				}
				catch(Exception e) {/* 아무것도 안함 */
					//System.out.println("catch 가 실행되는건가?");
				}
				
				//바꾼 이미지 등록(attachment, place_image에)
				int newAttachmentNo = attachmentService.save(firstImage);
				//place 테이블의 firstImage 업데이트
				originDto.setPlaceFirstImage(newAttachmentNo);
				placeDao.insertPlaceImage(placeDto.getPlaceNo(), newAttachmentNo);
			}
		}
		
		//상세 지워진 이미지들 처리
		if(deletedOldNos.isEmpty() == false) {
			for(int deletedNo: deletedOldNos) {
				try {
					attachmentService.delete(deletedNo);
				}
				catch(Exception e) {/* 아무것도 안함 */ }
			}
		}
		
		//상세 새로 추가된 이미지 처리
		for(MultipartFile detailImage : detailImages) {
			if(detailImage.isEmpty()) {
				break;
			}
			
			//이미지 저장, 여행지 이미지 정보 등록
			int attachmentNo = attachmentService.save(detailImage);
			placeDao.insertPlaceImage(placeDto.getPlaceNo(), attachmentNo);
		}
		
		placeDao.update(originDto);
		return "redirect:detail?placeNo=" + placeDto.getPlaceNo();
	}

	@RequestMapping("/image")
	public String image(@RequestParam int attachmentNo) {
		return "";
	}
}










