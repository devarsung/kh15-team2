package com.kh.semiproject.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semiproject.dto.CertDto;
import com.kh.semiproject.mapper.CertMapper;

@Repository
public class CertDao {
	@Autowired
	private CertMapper certMapper;
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	public void insert(CertDto certDto) {
		String sql = "insert into cert(cert_email, cert_number) values(?, ?)";
		Object[] data = {certDto.getCertEmail(), certDto.getCertNumber()};
		jdbcTemplate.update(sql, data);
	}
	public boolean update(CertDto certDto) {
		String sql = "update cert "
					+ "set "
						+ "cert_number=?, "
						+ "cert_time=systimestamp,"
						+ "cert_confirm=null "
					+ "where cert_email=?";
		Object[] data = {certDto.getCertNumber(), certDto.getCertEmail()};
		return jdbcTemplate.update(sql, data) > 0;
	}
	public CertDto selectOne(String certEmail) {
		String sql = "select * from cert where cert_email=?";
		Object[] data = {certEmail};
		List<CertDto> list = jdbcTemplate.query(sql, certMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	public void insertOrUpdate(CertDto certDto) {
		if(selectOne(certDto.getCertEmail()) == null) {//인증내역이 없는 이메일
			insert(certDto);
		}
		else {//이미 인증내역이 존재
			update(certDto);
		}
	}
	public boolean delete(String certEmail) {
		String sql = "delete cert where cert_email=?";
		Object[] data = {certEmail};
		return jdbcTemplate.update(sql, data) > 0;
	}
	public boolean confirm(String certEmail) {
 		String sql = "update cert "
 						+ "set cert_confirm=systimestamp "
 						+ "where cert_email=?";
 		Object[] data = {certEmail};
 		return jdbcTemplate.update(sql, data) > 0;
 	}
 	public boolean clean(int expireMinutes, int expireAccept) {
 		String sql = "delete cert where cert_email in ("
 							+ "select TMP.cert_email from ("
 								+ "select "
 									+ "cert.*, "
 									+ "extract(day from (systimestamp-cert_time)) * 24 * 60 + "
 									+ "extract(hour from (systimestamp-cert_time)) * 60 + "
 									+ "extract(minute from (systimestamp-cert_time)) + "
 									+ "extract(second from (systimestamp-cert_time)) / 60 "
 								+ "as diff "
 								+ "from cert "
 							+ ")TMP "
 						+ "where (cert_confirm is null and diff >= ?) "
 						+ "or (cert_confirm is not null and diff >= ?) "
 					+ ")";
 		Object[] data = {expireMinutes, expireAccept};
 		return jdbcTemplate.update(sql, data) > 0;
 	}
}
