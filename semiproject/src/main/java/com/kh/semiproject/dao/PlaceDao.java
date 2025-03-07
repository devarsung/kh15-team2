package com.kh.semiproject.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semiproject.dto.NoticeListViewDto;
import com.kh.semiproject.dto.PlaceDto;
import com.kh.semiproject.mapper.PlaceMapper;
import com.kh.semiproject.vo.PlacePageVO;

@Repository
public class PlaceDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Autowired
	private PlaceMapper placeMapper;

	public int sequence() {
		String sql = "select place_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
		
	//여행지 등록
	public void insert(PlaceDto placeDto) {
		String sql = "insert into place("
					+ "place_no, place_writer, place_title, place_overview, "
					+ "place_post, place_address1, place_address2, place_region, "
					+ "place_lat, place_lng, place_first_image, place_type)"
					+ "values(?,?,?,?,?,?,?,?,?,?,?,?)";
		Object[] data = {
				placeDto.getPlaceNo(), placeDto.getPlaceWriter(), 
				placeDto.getPlaceTitle(), placeDto.getPlaceOverview(), placeDto.getPlacePost(), 
				placeDto.getPlaceAddress1(), placeDto.getPlaceAddress2(), placeDto.getPlaceRegion(), 
				placeDto.getPlaceLat(), placeDto.getPlaceLng(), placeDto.getPlaceFirstImage(),
				placeDto.getPlaceType()
		};
		jdbcTemplate.update(sql, data);
	}
	
	//여행지 이미지 등록(연결테이블)
	public void insertPlaceImage(int placeNo, int attachmentNo) {
		String sql = "insert into place_image(place_no, attachment_no) values(?,?)";
		Object[] data = {placeNo, attachmentNo};
		jdbcTemplate.update(sql, data);
	}

	public boolean delete(int placeNo) {
		String sql = "delete from place where place_no = ?";
		// 추가 이미지 삭제

		Object[] data = { placeNo };
		return jdbcTemplate.update(sql, data) > 0;
	}

	public boolean update(PlaceDto placeDto) {
		String sql = "update place set place_title=?, place_content=?, place_post=? place_address1=?, place_address2=?, place_region=? where place_no =?";
		Object[] data = { placeDto.getPlaceTitle(), placeDto.getPlaceOverview(), placeDto.getPlacePost(),
				placeDto.getPlaceAddress1(), placeDto.getPlaceAddress2(), placeDto.getPlaceRegion(),
				placeDto.getPlaceNo() };
		return jdbcTemplate.update(sql, data) > 0;
	}

	// 목록(검색) 결과 카운트
	public int count(PlacePageVO placePageVO) {
		StringBuilder sql = new StringBuilder();

		if (placePageVO.isList()) {
			sql.append("select count(*) from place");
			return jdbcTemplate.queryForObject(sql.toString(), int.class);
		} else {
			List<Object> dataList = new ArrayList<>();
			sql.append("select count(*) from place ").append("where 1=1 ");

			if (placePageVO.getKeyword() != null) {
				sql.append("and instr(").append(placePageVO.getColumn()).append(", ?) > 0 ");
				dataList.add(placePageVO.getKeyword());
			}

			if (placePageVO.getRegion() != null) {
				sql.append("and place_region = ? ");
				dataList.add(placePageVO.getRegion());
			}

			if (placePageVO.getType() != null) {
				sql.append("and place_type = ? ");
				dataList.add(placePageVO.getType());
			}

			return jdbcTemplate.queryForObject(sql.toString(), int.class, dataList.toArray());
		}
	}

	// 여행지 목록 조회+검색
	public List<PlaceDto> selectList(PlacePageVO placePageVO) {
		StringBuilder sql = new StringBuilder();
		List<Object> dataList = new ArrayList<>();

		if (placePageVO.isList()) {
			sql.append("select * from (").append("select rownum rn, TMP.* from (").append("select * from place ")
					.append("order by place_no asc").append(") TMP").append(") where rn between ? and ?");

			dataList.add(placePageVO.getStartRownum());
			dataList.add(placePageVO.getFinishRownum());
		} else {
			sql.append("select * from (").append("select rownum rn, TMP.* from (").append("select * from place ")
					.append("where 1=1 ");

			if (placePageVO.getKeyword() != null) {
				sql.append("and instr(").append(placePageVO.getColumn()).append(", ?) > 0 ");
				dataList.add(placePageVO.getKeyword());
			}

			if (placePageVO.getRegion() != null) {
				sql.append("and place_region = ? ");
				dataList.add(placePageVO.getRegion());
			}

			if (placePageVO.getType() != null) {
				sql.append("and place_type = ? ");
				dataList.add(placePageVO.getType());
			}

			sql.append("order by place_no asc").append(") TMP").append(") where rn between ? and ?");

			dataList.add(placePageVO.getStartRownum());
			dataList.add(placePageVO.getFinishRownum());
		}

		return jdbcTemplate.query(sql.toString(), placeMapper, dataList.toArray());
	}
	
	//여행지 1개 조회
	public PlaceDto selectOne(int placeNo) {
		String sql = "select * from place where place_no = ?";
		Object[] data = { placeNo };
		List<PlaceDto> list = jdbcTemplate.query(sql, placeMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}

	public boolean findAttachment(int placeFirstImage) {
		String sql = "select count(*) from attachment where attachment_no = ?";
		Object[] data = { placeFirstImage };
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//여행지 이미지 번호들 조회
	public List<Integer> selectPlaceImagesNos(int placeNo) {
		String sql = "select attachment_no from place_image where place_no=?";
		Object[] data= {placeNo};
		return jdbcTemplate.queryForList(sql, Integer.class, data);
	}
	
	//상세이미지 번호만 조회
	public List<Integer> selectDetailImagesNos(int placeNo, int firstImageNo) {
		String sql = "select attachment_no from place_image "
				+ "where place_no=? and attachment_no not in(?)";
		Object[] data = {placeNo, firstImageNo};
		return jdbcTemplate.queryForList(sql, Integer.class, data);
	}

	// 조회수 1 증가 메소드
	public boolean updatePlaceRead(int placeNo) {
		String sql = "update place " + "set place_read=place_read+1 " + "where place_no=?";
		Object[] data = { placeNo };
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	
	public List<PlaceDto> selectListOnNotice(){
		String sql = "	SELECT * "
				+ "FROM ("
				+ "    SELECT rownum rn, TMP.*"
				+ "    FROM ("
				+ "        SELECT P.*, M.*, (P.place_like + P.place_read + P.place_star) AS total"
				+ "        FROM place P"
				+ "        LEFT JOIN MEMBER M ON P = M.member_id"
				+ "        ORDER BY total_likes_and_reads DESC"
				+ "    ) TMP"
				+ ")"
				+ "WHERE rn BETWEEN 1 AND 5";
		
		List<PlaceDto> list = jdbcTemplate.query(sql, placeMapper);
		System.out.println(list);
		return list;
	}
}






























