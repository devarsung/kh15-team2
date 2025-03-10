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


}
