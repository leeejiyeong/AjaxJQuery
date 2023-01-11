package co.micol.prj.notice.map;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import co.micol.prj.common.Criteria;
import co.micol.prj.notice.service.NoticeAttechVO;
import co.micol.prj.notice.service.NoticeVO;

public interface NoticeMapper {
	List<NoticeVO> noticeSelectList();
	NoticeVO noticeSelect(NoticeVO vo);  //첨부파일 한개만
	int noticeInsert(NoticeVO vo);  //게시글 저장
	int noticeUpdate(NoticeVO vo);  //게시글 수정
	int noticeDelete(NoticeVO vo);  //게시글 삭제
	
	int noticeAttechDelete(NoticeAttechVO vo); //첨부파일 삭제
	int noticeAttechInsert(NoticeAttechVO vo); //첨부파일 저장	
	
	void noticeHitUpdate(int id); //조회수 증가
	List<NoticeVO> noticeSearchList(@Param("key") String key, @Param("val") String val);  //게시글 내 검색을 위해
	
	//페이징
	List<NoticeVO> noticeListPaging(Criteria cri);
	
	int pagingAllCount(Criteria cri);
}
