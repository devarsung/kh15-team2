package com.kh.semiproject.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semiproject.dto.ReviewListViewDto;
import com.kh.semiproject.dto.ReviewListViewDto2;
import com.kh.semiproject.mapper.ReviewListViewMapper;
import com.kh.semiproject.mapper.ReviewListViewMapper2;
import com.kh.semiproject.mapper.ReviewPlaceMemberListViewMapper;
import com.kh.semiproject.vo.PageVO;

@Repository
public class ReviewListViewDao {
	@Autowired
	private ReviewListViewMapper2 reviewListViewMapper2;
	@Autowired
	private ReviewListViewMapper reviewListViewMapper;
	@Autowired
	private ReviewPlaceMemberListViewMapper reviewPlaceMemberListViewMapper;
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public List<ReviewListViewDto> selectList(PageVO pageVO){
		String sql = "";
		if(pageVO.isList()) {
			sql = "select * from ("
				+ "select rownum rn, TMP.* from ("
					+ "SELECT R.*, M.*, P.place_no, P.place_title "
					+ "FROM REVIEW R "
					+ "LEFT JOIN MEMBER M ON R.review_writer = M.member_id "
					+ "LEFT JOIN place P on R.review_place = P.place_no "
					+ "ORDER BY R.review_no desc "
				+ ")TMP"
			+ ") where rn between ? and ?";
			Object[] data = {pageVO.getStartRownum(), pageVO.getFinishRownum()};
			return jdbcTemplate.query(sql, reviewListViewMapper, data);
		}
		else {
			sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
					+ "SELECT R.*, M.*, P.place_no, P.place_title "
					+ "FROM REVIEW R "
					+ "LEFT JOIN MEMBER M ON R.review_writer = M.member_id "
					+ "LEFT JOIN place P on R.review_place = P.place_no "
					+ "where instr(#1, ?) > 0 "
					+ "ORDER BY R.review_no desc "
					+ ")TMP"
				+ ") where rn between ? and ?";
			sql = sql.replace("#1", pageVO.getColumn());
			Object[] data = {pageVO.getKeyword(), pageVO.getStartRownum(), pageVO.getFinishRownum()};
			return jdbcTemplate.query(sql, reviewListViewMapper, data);
		}
	}
	
	public List<ReviewListViewDto> selectList(PageVO pageVO, int placeNo){
		String sql = "select * from ("
				+ "select rownum rn, TMP.* from ("
				+ "SELECT R.*, M.*, P.place_no, P.place_title "
				+ "FROM REVIEW R "
				+ "LEFT JOIN MEMBER M ON R.review_writer = M.member_id "
				+ "LEFT JOIN place P on R.review_place = P.place_no "
				+ "where review_place = ? "
				+ "ORDER BY R.review_no desc "
			+ ")TMP"
		+ ") where rn between ? and ?";
		
		Object[] data = {placeNo, pageVO.getStartRownum(), pageVO.getFinishRownum()};
		return jdbcTemplate.query(sql, reviewListViewMapper, data);
	}
	
	public List<ReviewListViewDto2> selectListByPlace(int placeNo){
		String sql = "select * from("
				+ "select rownum rn, TMP.* from("
				+ "select R.review_no, R.review_Title, R.review_reply, "
				+ "R.review_wtime, R.review_like, "
				+ " M.member_nickname "
				+ "from review R "
				+ "LEFT JOIN MEMBER M ON R.review_writer = M.member_id "
				+ "where review_place = ? "
				+ "order by (R.review_read + R.review_like) desc "
				+ ")TMP"
				+ ") where rn between 1 and 5";
		
//		String sql = "select R.review_no, R.review_Title, "
//				+ "R.review_wtime, R.review_writer, M.member_nickname "
//				+ "from review R "
//				+ "LEFT JOIN MEMBER M ON R.review_writer = M.member_id "
//				+ "where review_place = ? "
//				+ "group by R.review_wtime, R.review_writer, "
//				+ "R.review_no, R.review_Title, M.member_nickname "
//				+ "order by R.review_no desc ";
	//	String sql = "select * from review_list_view";
		Object[] data = {placeNo};
		
		List<ReviewListViewDto2> list = jdbcTemplate.query(sql, reviewListViewMapper2, data);
	return list;
	}
	


	
	public int count(PageVO pageVO) {
		if (pageVO.isList()) {
			String sql = "select count(*) from review";
			return jdbcTemplate.queryForObject(sql, int.class);
		} 
		else if(pageVO.search()){
			String sql = "select count(*) from ("
					+ "	 select R.*, M.* from review R"
					+ "		left join member M on R.review_writer = M.member_id"
					+ "		where instr(#1,?) > 0 "
					+ "		)";
			sql = sql.replace("#1", pageVO.getColumn());
			Object[] data = { pageVO.getKeyword() };
			return jdbcTemplate.queryForObject(sql, int.class, data);
		}
		else if(pageVO.byPlace()) {
			String sql = "select count(*) from review where review_place = ?";
			Object[] data = {pageVO.getPlaceNo()};
			return jdbcTemplate.queryForObject(sql,int.class,data );
		}
		else {
			return 1;
		}
	}


	
}
