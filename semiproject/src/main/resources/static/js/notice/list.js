$(function() {
    // 아이콘 클릭 시 체크박스 상태 변경 + 아이콘 업데이트
    $(".icon").on("click", function() {
        var noticeItem = $(this).closest(".notice-item"); // 해당 notice-item 가져오기
        var checkbox = noticeItem.find(".check-item"); // 체크박스 찾기
		
		var icon = $(this).closest(".notice-item").find(".icon");
      
		  checkbox.prop("checked", !checkbox.prop("checked")).trigger("change"); // 체크 상태 변경 + change 이벤트 실행
  
		if ($(checkbox).is(":checked")) {
		          icon.removeClass("fa-square").addClass("fa-check-square"); // 체크되면 변경
		      } else {
		          icon.removeClass("fa-check-square").addClass("fa-square"); // 해제되면 원래대로
		      }
		  });
});
				s
$(function(){
	$(".icon-all").on("click", function(){
			
			var noticeAll=$(this).closest(".notice-all");
			var checkbox_All=noticeAll.find(".check-all");
			
			var noticeItem = $(this).closest(".notice-item"); // 해당 notice-item 가져오기
			var checkbox_Item = noticeItem.find(".check-item"); // 체크박스 찾기
			
			
			var icon_all =$(this).closest(".notice-all").find(".icon-all");		
			
			var icon = $(checkbox_Item).closest(".notice-item").find(".icon");
			
			
			checkbox_All.prop("checked", !checkbox_All.prop("checked")).trigger("change");
			
				if($(checkbox_All).is(":checked")){
							icon_all.removeClass("fa-square").addClass("fa-check-square");
							}
						else{
							icon_all.removeClass("fa-check-square").addClass("fa-square");
						}
				});
		});
		
		
  // [2] .check-all 선택 시, 해당 그룹 내의 아이콘 + check-item 상태 변경
    $(document).on("change", ".check-all", function(){
        var noticeAll = $(this).closest(".notice-all"); // 가장 가까운 .notice-all 찾기
        var iconAll = noticeAll.find(".icon-all"); // 같은 그룹의 아이콘 찾기
        var checkItems = noticeAll.closest(".notice-list").find(".check-item"); // 같은 그룹의 check-item 찾기

        var isChecked = $(this).prop("checked"); // 현재 check-all 상태 확인

        // [아이콘 변경]
        if(isChecked){
            iconAll.removeClass("fa-square").addClass("fa-check-square"); // 체크되면 아이콘 변경
        } else {
            iconAll.removeClass("fa-check-square").addClass("fa-square"); // 체크 해제되면 원래대로
        }

        // [check-item 변경]
        checkItems.prop("checked", isChecked); // check-all의 상태에 따라 check-item 변경
    });



