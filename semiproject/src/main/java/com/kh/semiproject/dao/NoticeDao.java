package com.kh.semiproject.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semiproject.dto.NoticeDto;
import com.kh.semiproject.mapper.NoticeListViewMapper;
import com.kh.semiproject.mapper.NoticeMapper;
import com.kh.semiproject.vo.PageVO;

@Repository
public class NoticeDao {
	
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Autowired
	private NoticeMapper noticeMapper;

	@Autowired
	private NoticeListViewMapper noticeListViewMapper;
	
	public int sequence() {
		String sql = "select notice_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}

	public void insert(NoticeDto noticeDto) {
		String sql = "insert into notice("
				+ "notice_no, "
				+ "notice_title, "
				+ "notice_content, "
				+ "notice_writer) "
				+ "values(?,?,?,?)";

		Object[] data = { noticeDto.getNoticeNo(),
				noticeDto.getNoticeTitle(), 
				noticeDto.getNoticeContent(), 
				noticeDto.getNoticeWriter()};

		jdbcTemplate.update(sql, data);
	}

	public boolean delete(int noticeNo) {
		String sql = "delete from notice where notice_no = ?";
		Object[] data = { noticeNo };
		return jdbcTemplate.update(sql, data) > 0;
	}

	public boolean update(NoticeDto noticeDto) {
		String sql = "update notice set notice_title = ?, notice_content = ?, notice_etime=systimestamp where notice_no = ?";
		Object[] data = { noticeDto.getNoticeTitle(), noticeDto.getNoticeContent(), noticeDto.getNoticeNo() };
		return jdbcTemplate.update(sql, data) > 0;
	}

	public List<NoticeDto> selectList() {
		String sql = "select * from notice";
		return jdbcTemplate.query(sql, noticeMapper);
	}

	public NoticeDto selectOne(int noticeNo) {
		String sql = "select * from notice where notice_no=? ";
		Object[] data = {noticeNo};
		List<NoticeDto> list = jdbcTemplate.query(sql, noticeMapper, data);
		return list.isEmpty() ? null :list.get(0);
	}
	
//	public int count(PageVO pageVO) {
//	    if (pageVO.isList()) {
//	        String sql = "select count(*) from notice"; 
//	        return jdbcTemplate.queryForObject(sql, int.class);
//	    } 
//	    else if (pageVO.search()) {
//	        String sql = "select count(*) from ("
//	                + "     select N.*, M.* from notice N" 
//	                + "     left join member M on N.notice_writer = M.member_id" 
//	                + "     where instr(#1,?) > 0 "
//	                + "     )";
//	        sql = sql.replace("#1", pageVO.getColumn());
//	        Object[] data = { pageVO.getKeyword() };
//	        return jdbcTemplate.queryForObject(sql, int.class, data);
//	    }
//	    else if (pageVO.byPlace()) {
//	        String sql = "select count(*) from notice where notice_place = ?"; 
//	        Object[] data = { pageVO.getPlaceNo() };
//	        return jdbcTemplate.queryForObject(sql, int.class, data);
//	    }
//	    else {
//	        return 1;
//	    }
//	}


	// 조회수 1 증가 메소드
	public boolean updateNoticeRead(int noticeNo) {
		String sql = "update notice " + "set notice_read=notice_read+1 " + "where notice_no=?";
		Object[] data = { noticeNo };
		return jdbcTemplate.update(sql, data) > 0;
	}

	//공지사항 이미지 찾기
	//-반환형이 int이기 때문에 만약 이미지가없으면 예외가 발생함
	public int findAttachment(int noticeNo) {
		String sql="select attachment_no from ontice_list "
				+ "where noticeNo=? ";
		Object[] data= {noticeNo};
		return jdbcTemplate.queryForObject(sql, int.class,data);
	}
	
	
}
