//에디터 처리
$(function(){
    $(".deletemessage").click(function(event){
        if (!confirm("정말 삭제하시겠습니까?")) {
            event.preventDefault(); // 취소 시 페이지 이동 막기
        }
    });
});