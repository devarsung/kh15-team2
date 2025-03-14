$(function () {
    $(".icon").on("click", function () {
        var noticeItem = $(this).closest(".notice-item"); // 해당 notice-item 가져오기
        var checkbox = noticeItem.find(".check-item"); // 체크박스 찾기
        var icon = noticeItem.find(".icon");

        // 체크 상태 변경 + change 이벤트 실행
        checkbox.prop("checked", !checkbox.prop("checked")).trigger("change");

        // 상태가 변경된 후에 개수를 확인하도록 setTimeout 사용
        setTimeout(function () {
            var totalItems = $(".check-item").length;  // 전체 개별 체크박스 개수
            var checkedItems = $(".check-item:checked").length;  // 체크된 개별 체크박스 개수
            var allCheck = totalItems === checkedItems; // 모든 체크박스가 체크되었는지 확인

            $(".check-all").prop("checked", allCheck);

     
        }, );
        
        // 체크 상태에 따라 아이콘 변경
        if (checkbox.is(":checked")) {
            icon.removeClass("fa-square").addClass("fa-check-square");
        } else {
            icon.removeClass("fa-check-square").addClass("fa-square");
        }
    });
});

    //아이콘변화 및 item채크 박스 전체		
    $(function () {
        $(".icon-all").on("click", function () {

            var noticeAll = $(this).closest(".notice-all");
            var checkbox_All = noticeAll.find(".check-all");

            var noticeItem = $(this).closest(".notice-item"); // 해당 notice-item 가져오기
            var checkbox_Item = noticeItem.find(".check-item"); // 체크박스 찾기


            var icon_all = $(this).closest(".notice-all").find(".icon-all");

            var icon = $(checkbox_Item).closest(".notice-item").find(".icon");


            checkbox_All.prop("checked", !checkbox_All.prop("checked")).trigger("change");

            if (checkbox_All.is(":checked")) {
                icon_all.removeClass("fa-square").addClass("fa-check-square");

            }

            else {

                icon_all.removeClass("fa-check-square").addClass("fa-square");

            }
        });
    });


    $(document).on("change", ".check-all", function () {
    var noticeAll = $(this).closest(".notice-all"); // 가장 가까운 .notice-all 찾기
    var iconAll = noticeAll.find(".icon-all"); // 같은 그룹의 아이콘 찾기
    var checkItems = noticeAll.closest(".notice-list").find(".check-item"); // 같은 그룹의 check-item 찾기
    var iconItem = checkItems.closest(".notice-item").find(".icon");

    var isChecked = $(this).prop("checked"); // 현재 check-all 상태 확인

    // [아이콘 변경]
    if (isChecked) {
        iconAll.removeClass("fa-square").addClass("fa-check-square"); // 체크되면 아이콘 변경
        iconItem.removeClass("fa-square").addClass("fa-check-square");
    } else {
        iconAll.removeClass("fa-check-square").addClass("fa-square"); // 체크 해제되면 원래대로
        iconItem.removeClass("fa-check-square").addClass("fa-square");
    }

    // [check-item 변경] → check-all이 체크되면 전체 항목도 체크됨
    checkItems.prop("checked", isChecked).trigger("change");
});

//  개별 체크박스 클릭 시 전체 체크박스 & 아이콘 자동 업데이트
$(document).on("change", ".check-item", function () {
    var noticeAll = $(this).closest(".notice-list"); // notice-list 영역 찾기
    var iconAll = noticeAll.find(".icon-all"); // 전체 체크 아이콘
    var checkAll = noticeAll.find(".check-all"); // 전체 체크박스
    var checkItems = noticeAll.find(".check-item"); // 전체 개별 체크박스 목록

    var totalItems = checkItems.length; // 전체 개별 체크박스 개수
    var checkedItems = checkItems.filter(":checked").length; // 체크된 개수

    var allChecked = totalItems === checkedItems; // 모든 체크박스가 체크되었는지 확인

    checkAll.prop("checked", allChecked); // 전체 체크박스 업데이트

    // 전체 선택 아이콘 변경
    if (allChecked) {
        iconAll.removeClass("fa-square").addClass("fa-check-square");
    } else {
        iconAll.removeClass("fa-check-square").addClass("fa-square");
    }
});



