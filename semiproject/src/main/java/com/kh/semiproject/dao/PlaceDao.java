package com.kh.semiproject.dao;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.kh.semiproject.dto.PlaceDto;

import com.kh.semiproject.dto.PlaceReviewDto;

import com.kh.semiproject.dto.PlaceListViewDto;
import com.kh.semiproject.mapper.PlaceListViewMapper;

import com.kh.semiproject.mapper.PlaceMapper;
import com.kh.semiproject.mapper.PlaceReviewMapper;
import com.kh.semiproject.vo.PlacePageVO;

@Repository
public class PlaceDao {
	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Autowired
	private PlaceMapper placeMapper;

	
	@Autowired
	private PlaceReviewMapper placeReviewMapper;
	

	@Autowired
	private PlaceListViewMapper placeListViewMapper;


	public int sequence() {
		String sql = "select place_seq.nextval from dual";
		return jdbcTemplate.queryForObject(sql, int.class);
	}
		
	//여행지 등록
	public void insert(PlaceDto placeDto) {
		String sql = "insert into place("
					+ "place_no, place_writer, place_title, place_overview, "
					+ "place_post, place_address1, place_address2, place_region, "
					+ "place_lat, place_lng, place_first_image, place_type, "
					+ "place_tel, place_website, place_parking, place_operate"
					+ ")"
					+ "values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
		Object[] data = {
				placeDto.getPlaceNo(), placeDto.getPlaceWriter(), placeDto.getPlaceTitle(), placeDto.getPlaceOverview(), 
				placeDto.getPlacePost(), placeDto.getPlaceAddress1(), placeDto.getPlaceAddress2(), placeDto.getPlaceRegion(), 
				placeDto.getPlaceLat(), placeDto.getPlaceLng(), placeDto.getPlaceFirstImage(), placeDto.getPlaceType(),
				placeDto.getPlaceTel(), placeDto.getPlaceWebsite(), placeDto.getPlaceParking(), placeDto.getPlaceOperate()
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
		String sql = "delete place where place_no = ?";
		Object[] data = { placeNo };
		return jdbcTemplate.update(sql, data) > 0;
	}

	public boolean update2(PlaceDto placeDto) {
		String sql = "update place set place_title=?, place_content=?, place_post=? place_address1=?, place_address2=?, place_region=? where place_no =?";
		Object[] data = { placeDto.getPlaceTitle(), placeDto.getPlaceOverview(), placeDto.getPlacePost(),
				placeDto.getPlaceAddress1(), placeDto.getPlaceAddress2(), placeDto.getPlaceRegion(),
				placeDto.getPlaceNo() };
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	public boolean update(PlaceDto placeDto) {
		String sql = "update place set "
				+ "place_region=?, place_type=?, place_title=?, "
				+ "place_post=?, place_address1=?, place_address2=?, "
				+ "place_lat=?, place_lng=?, place_overview=?, "
				+ "place_tel=?, place_website=?, place_parking=?, "
				+ "place_operate=?, place_first_image=?, "
				+ "place_etime=systimestamp "
				+ "where place_no=?";
		Object[] data = {
				placeDto.getPlaceRegion(), placeDto.getPlaceType(), placeDto.getPlaceTitle(),
				placeDto.getPlacePost(), placeDto.getPlaceAddress1(), placeDto.getPlaceAddress2(),
				placeDto.getPlaceLat(), placeDto.getPlaceLng(), placeDto.getPlaceOverview(),
				placeDto.getPlaceTel(), placeDto.getPlaceWebsite(), placeDto.getPlaceParking(),
				placeDto.getPlaceOperate(), placeDto.getPlaceFirstImage(),
				placeDto.getPlaceNo()
		};
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
	public List<PlaceListViewDto> selectList(PlacePageVO placePageVO) {
		StringBuilder sql = new StringBuilder();
		List<Object> dataList = new ArrayList<>();

		if (placePageVO.isList()) {
			sql.append("select * from( ")
				.append("select rownum rn, tmp.* from( ")
					.append("select p.*, COALESCE(sub.star_avg,0) as place_star from place p ")
						.append("left join  (")
							.append("select review_place, avg(nvl(review_star,0)) as star_avg ")
							.append("from review ")
							.append("group by review_place ")
							.append(") sub on p.place_no = sub.review_place ")
						.append("order by ").append(placePageVO.getOrder()).append(" desc, place_no asc ")
					.append(") tmp ")
			.append(") where rn between ? and ?");
	
			dataList.add(placePageVO.getStartRownum());
			dataList.add(placePageVO.getFinishRownum());
		} else {
			sql.append("select * from( ")
					.append("select rownum rn, tmp.* from( ")
						.append("select p.*, COALESCE(sub.star_avg,0) as place_star from place p ")
							.append("left join  (")
								.append("select review_place, avg(nvl(review_star,0)) as star_avg ")
								.append("from review ")
								.append("group by review_place ")
								.append(") sub on p.place_no = sub.review_place ")
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
							
			sql.append("order by ").append(placePageVO.getOrder()).append(" desc, place_no asc ")
				.append(") tmp ")
			.append(") where rn between ? and ?");
			
			dataList.add(placePageVO.getStartRownum());
			dataList.add(placePageVO.getFinishRownum());
		}

		return jdbcTemplate.query(sql.toString(), placeListViewMapper, dataList.toArray());
	}
	
	//여행지 1개 조회
	public PlaceDto selectOne(int placeNo) {
		String sql = "select * from place where place_no = ?";
		Object[] data = { placeNo };
		List<PlaceDto> list = jdbcTemplate.query(sql, placeMapper, data);
		return list.isEmpty() ? null : list.get(0);
	}
	
	//여행지 이미지 번호들 조회(모두)//이 메소드 필요없을듯->여행지 삭제시 쓰면 될듯 
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
	
	
	public float star(int placeNo){
		String sql = "select avg(review_star) from review "
				+ "left join place on review.review_place = place.place_no "
				+ "where place_no = ? "
				+ "group by review_place";
		Object[] data = {placeNo};
		
		return jdbcTemplate.queryForObject(sql, float.class, data);
	}
	
	
	//메인에서 보여줄 top5
	public List<PlaceListViewDto> selectListOnPlace() {			
		String sql = "select * from ("
						+ "select rownum rn, tmp.* from ("
								+ "select p.place_no,p.place_title,p.place_type,p.place_like,p.place_read,p.place_review,"
								+ "round(coalesce(avg(r.review_star),0),1) as place_star, p.place_region,p.place_writer,p.place_wtime,p.place_etime,"
								+ "(p.place_like + p.place_read + p.place_review + coalesce(avg(r.review_star),0)) as total,p.place_first_image "
								+ "from place p left join review r on p.place_no=r.review_place "
								+ "group by p.place_no,p.place_title,p.place_type,p.place_like,p.place_read,p.place_review,"
								+ "p.place_region,p.place_writer,p.place_wtime,p.place_etime,p.place_first_image "
								+ "having p.place_like>0  and p.place_review>0 and p.place_read>0 and coalesce(avg(r.review_star),0)>0 "
								+ "order by total desc "
							+ ")tmp "
				+ ") where rn between 1 and 5";
		List<PlaceListViewDto> list = jdbcTemplate.query(sql, placeListViewMapper);
		return list;
	}
	
	//1개 여행지의 리뷰 평균
	//데이터 정상이고 외래키 잘 연결되어있다면
	/*
	 * select round(coalesce(avg(nvl(review_star, 0)),0),1) as review_Star from
	 * REVIEW where review_place = 5 group by review_place
	 * 
	 * 이런 구문도 가능한데 현재 더미데이터라 일단 조인했음
	 */
	public Double selectStarAvg(int placeNo) {
		String sql = "select round(coalesce(sub.star_avg,0),1) as review_star "
					+ "from place p "
					+ "left join ( "
						+ "select review_place, avg(nvl(review_star, 0)) as star_avg "
						+ "from review "
						+ "group by review_place "
					+ ") sub on p.place_no = sub.review_place "
					+ "where p.place_no = ?";
		Object[] data = {placeNo};
		return jdbcTemplate.queryForObject(sql, Double.class, data);
	}
	
	//리뷰 쓸 때마다 리뷰수 갱신
	public boolean updatePlaceReview(int placeNo, int count) {
		String sql = "update place set place_review = ? where place_no = ?";
		Object[] data = { count, placeNo };
		return jdbcTemplate.update(sql, data) > 0;
	}
	
	//리뷰 몇 개인지
	public int countPlaceReview(int placeNo) {
		String sql = "select count(*) from review where review_place = ?";
		Object[] data = { placeNo };
		return jdbcTemplate.queryForObject(sql, int.class, data);
	}
}






























