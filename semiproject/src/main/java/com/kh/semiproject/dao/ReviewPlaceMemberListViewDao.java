package com.kh.semiproject.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semiproject.dto.ReviewListViewDto;
import com.kh.semiproject.dto.ReviewPlaceMemberListViewDto;
import com.kh.semiproject.mapper.ReviewPlaceMemberListViewMapper;

@Repository
public class ReviewPlaceMemberListViewDao {
	@Autowired
	private ReviewPlaceMemberListViewMapper reviewPlaceMemberListViewMapper;
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	
	// top 5
//	public List<ReviewPlaceMemberListViewDto> selectListOnReview(){
//		//String sql ="select * from review_place_member_list_view order by coalesce(R.review_like,0) + coalesce(R.review_read,0) desc;";
////		String sql = "SELECT R.review_no, R.review_place, R.REVIEW_TITLE, "
////		           + "M.MEMBER_ID, M.member_nickname, P.place_no, P.place_title, "
////		           + "COALESCE(R.review_like, 0) + COALESCE(R.review_read, 0) AS total_likes_and_reads "
////		           + "FROM review R "
////		           + "LEFT JOIN MEMBER M ON R.review_writer = M.member_id "
////		           + "LEFT JOIN place P ON R.review_place = P.place_no";
//		 
////		String sql = "select R.review_no, R.review_title, R.review_like, R.review_read, R.review_star, R.review_wtime, R.review_writer, "
////				+ "R.review_place, M.member_id, M.member_nickname, P.place_no, P.place_title from review R "
////				+ "left join place P ON R.review_place =  P.place_no "
////				+ "LEFT JOIN member M ON R.review_writer = M.member_id";
////		 
//		String sql = "SELECT * FROM review_place_member_list_view";
//		
//		//System.out.println(jdbcTemplate.query(sql, reviewPlaceMemberListViewMapper));
//		List<ReviewPlaceMemberListViewDto> list = jdbcTemplate.query(sql, reviewPlaceMemberListViewMapper);
//		return list;
//	}
	
	public List<ReviewPlaceMemberListViewDto> selectListOnReview(){

		String sql = "SELECT * FROM ("
				+ "    SELECT rownum rn, TMP.*"
				+ "    FROM ("
				+ "        SELECT "
				+ "            R.review_no, R.review_title, R.review_like, R.review_read, "
				+ "            R.review_star, R.review_wtime, R.review_writer,  R.review_place, "
				+ "            M.member_id, M.member_nickname, "
				+ "            P.place_no, P.place_title, "
				+ "            (NVL(R.review_like, 0) + NVL(R.review_read, 0)) AS total_likes_and_reads"
				+ "        FROM review R"
				+ "        LEFT JOIN MEMBER M ON R.review_writer = M.member_id"
				+ "        LEFT JOIN place P ON R.review_place = P.place_no"
				+ "        ORDER BY total_likes_and_reads DESC"
				+ "    ) TMP"
				+ ")"
				+ "WHERE rn BETWEEN 1 AND 5";
		
		
		List<ReviewPlaceMemberListViewDto> list = jdbcTemplate.query(sql, reviewPlaceMemberListViewMapper);
		return list;
	}
	
	
	
}
