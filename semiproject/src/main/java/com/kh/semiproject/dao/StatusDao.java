package com.kh.semiproject.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semiproject.mapper.StatusMapper;
import com.kh.semiproject.vo.StatusVO;

@Repository
public class StatusDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private StatusMapper statusMapper;

	// 회원 성별 현황
	public List<StatusVO> memberGenderGroup() {
		String sql = "select member_gender key, count(*) value from member " + "group by member_gender "
				+ "order by value desc, key asc";
		return jdbcTemplate.query(sql, statusMapper);
	}
	
	//회원 연령대 현황
	public List<StatusVO> memberAgeGroup() {
		String sql = "select age_group as key, count(*) as value from ( "
						+ "select "
							+ "case "
								+ "when age IS NULL or age = '' then '알 수 없음' "
								+ "when age < 20 then '10대' "
								+ "when age < 30 then '20대' "
								+ "when age < 40 then '30대' "
								+ "when age < 50 then '40대' "
								+ "when age < 60 then '50대' "
								+ "when age < 70 then '60대' "
								+ "when age >= 70 then '70대 이상' "
							+ "end as age_group "
						+ "from ( "
							+ "select "
								+ "months_between(trunc(sysdate,'year'), "
								+ "trunc(to_date(member_birth,'YYYY-MM-DD'),'year')) / 12 + 1 as age "
							+ "from member "
						+ ") sub "
					+ ") "
				+ "group by age_group "
				+ "order by age_group";
		return jdbcTemplate.query(sql, statusMapper);
	}

	public List<StatusVO> placeReviewGroup(){
		String sql = "select * from ( select rownum rn, TMP.* from("
				+ "select place_title key, place_review value from place \r\n"
				+ "				group by place_review, PLACE_TITLE \r\n"
				+ "				order by place_review desc "
				+ ")TMP) where rn between 1 and 10";
		return jdbcTemplate.query(sql,  statusMapper);
	}
	public List<StatusVO> reviewReplyGroup(){
		String sql = "select * from ( select rownum rn, TMP.* from("
				+ "select review_title key, review_reply value from REVIEW \r\n"
				+ "				group by review_title, REVIEW_REPLY 	\r\n"
				+ "				order by COALESCE(review_reply, 0) desc"
				+ ")TMP) where rn between 1 and 10";
		return jdbcTemplate.query(sql, statusMapper);
	}

	public List<StatusVO> placeLikeGroup(){
		String sql = "select * from ( select rownum rn, TMP.* from("
				+ "select  place_title key, place_like value from place \r\n"
				+ "				group by place_like, PLACE_TITLE \r\n"
				+ "				order by place_like desc"
				+ ")TMP) where rn between 1 and 10";
		return jdbcTemplate.query(sql,  statusMapper);
	}
	
	public List<StatusVO> placeReadGroup(){
		String sql = "select * from ( select rownum rn, TMP.* from("
				+ "select  place_title key, place_read value from place \r\n"
				+ "				group by place_read, PLACE_TITLE \r\n"
				+ "				order by place_read desc"
				+ ")TMP) where rn between 1 and 10";
		return jdbcTemplate.query(sql,  statusMapper);
	}

	public List<StatusVO> reviewLikeGroup(){
		String sql = "select * from ( select rownum rn, TMP.* from("
				+ "select  review_title key, review_like value from review \r\n"
				+ "				group by review_title, review_like \r\n"
				+ "				order by review_like desc"
				+ ")TMP) where rn between 1 and 10";
		return jdbcTemplate.query(sql,  statusMapper);
	}
	public List<StatusVO> reviewReadGroup(){
		String sql = "select * from ( select rownum rn, TMP.* from("
				+ "select  review_title key, review_read value from review \r\n"
				+ "				group by review_title, review_read \r\n"
				+ "				order by review_read desc"
				+ ")TMP) where rn between 1 and 10";
		return jdbcTemplate.query(sql,  statusMapper);
	}
	
	// 리뷰 가장 많이 쓴 사람
	// 여행지 지역별, 타입별
	
	public List<StatusVO> reviewUserGroup(){
		String sql = "select * from ( select rownum rn, TMP.* from("
				+ "select review_writer key, count(*) value from review "
				+ "group by review_writer "
				+ "order by value desc"
				+ ")TMP) where rn between 1 and 10";
		return jdbcTemplate.query(sql,  statusMapper);
	}

	public List<StatusVO> placeTypeGroup(){
		String sql = "select * from ( select rownum rn, TMP.* from("
				+ "select place_type key, count(*) value from place "
				+ "group by place_type "
				+ "order by value desc"
				+ ")TMP) where rn between 1 and 10";
		return jdbcTemplate.query(sql, statusMapper);
	}
	public List<StatusVO> placeRegionGroup(){
		String sql = "select * from ( select rownum rn, TMP.* from("
				+ "select place_region key, count(*) value from place "
				+ "group by place_region "
				+ "order by value desc"
				+ ")TMP) where rn between 1 and 10";
		return jdbcTemplate.query(sql, statusMapper);
	}
	
}









































