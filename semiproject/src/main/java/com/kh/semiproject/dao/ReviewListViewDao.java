package com.kh.semiproject.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semiproject.dto.ReviewListViewDto;
import com.kh.semiproject.mapper.ReviewListViewMapper;
import com.kh.semiproject.vo.PageVO;

@Repository
public class ReviewListViewDao {
	@Autowired
	private ReviewListViewMapper reviewListViewMapper;
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public List<ReviewListViewDto> selectList(PageVO pageVO){
		String sql = "";
		if(pageVO.isList()) {
			sql = "select * from ("
				+ "select rownum rn, TMP.* from ("
					+ "SELECT R.*, M.* "
					+ "FROM REVIEW R "
					+ "LEFT JOIN MEMBER M ON R.review_writer = M.member_id "
					+ "ORDER BY R.review_no ASC "
				+ ")TMP"
			+ ") where rn between ? and ?";
			Object[] data = {pageVO.getStartRownum(), pageVO.getFinishRownum()};
			return jdbcTemplate.query(sql, reviewListViewMapper, data);
		}
		else {
			sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
						+ "SELECT R.*, M.* "
						+ "FROM REVIEW R "
						+ "LEFT JOIN MEMBER M ON R.review_writer = M.member_id "
						+ "where instr(#1, ?) > 0 "
						+ "ORDER BY R.review_no ASC "
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
				+ "SELECT R.*, M.* "
				+ "FROM REVIEW R "
				+ "LEFT JOIN MEMBER M ON R.review_writer = M.member_id "
				+ "where review_place = ? "
				+ "ORDER BY R.review_no ASC "
			+ ")TMP"
		+ ") where rn between ? and ?";
		
		Object[] data = {placeNo, pageVO.getStartRownum(), pageVO.getFinishRownum()};
		return jdbcTemplate.query(sql, reviewListViewMapper, data);
	}
	
	
	public List<ReviewListViewDto> selectListByPlace(int placeNo){
		String sql = "select * from("
				+ "select rownum rn, TMP.* from("
				+ "select R.*, M.* "
				+ "from review R "
				+ "LEFT JOIN MEMBER M ON R.review_writer = M.member_id "
				+ "where review_place = ? "
				+ "order by review_read desc "
				+ ")TMP"
				+ ") where rn between 1 and 5";
		Object[] data = {placeNo};
		
		List<ReviewListViewDto> list = jdbcTemplate.query(sql, reviewListViewMapper, data);
		//System.out.println(list);
		return list;
	}
	
	public List<ReviewListViewDto> selectListOnReview(){
		String sql = "	SELECT * "
				+ "FROM ("
				+ "    SELECT rownum rn, TMP.*"
				+ "    FROM ("
				+ "        SELECT R.*, M.*, (R.review_like + R.review_read) AS total_likes_and_reads"
				+ "        FROM review R"
				+ "        LEFT JOIN MEMBER M ON R.review_writer = M.member_id"
				+ "        ORDER BY total_likes_and_reads DESC"
				+ "    ) TMP"
				+ ")"
				+ "WHERE rn BETWEEN 1 AND 5";
		
		List<ReviewListViewDto> list = jdbcTemplate.query(sql, reviewListViewMapper);
		//System.out.println(list);
		return list;
	}
	
	
	
	
	
}
