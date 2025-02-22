<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>






 <script type="text/javascript">
        $(function(){
 
            //체크박스 모듈화
            //[1] .check-all 선택 시 .check-item으로 상태 전파
            //[2] .check-item 선택 시 .check-all에 대한 체크 여부 검토
            $(".check-all").on("input", function(){
                //this의 체크 상태를 모든 체크박스로 전파
                var isCheck = $(this).prop("checked");
                $(".check-all, .check-item").prop("checked", isCheck);
            });
            $(".check-item").on("input", function(){
                var all = $(".check-item").length;
                //var checked = $(".check-item:checked").length;
                var checked = $(".check-item").filter(":checked").length;
                var allCheck = all == checked;

                $(".check-all").prop("checked", allCheck);
            });
        });
    </script>

<form action="">
 <div class="container w-500">
        <div class="cell center">
            <h1>이용약관 </h1>
        </div>

    
   

        <div class="cell">
            <input type="checkbox" class="check-all"> 전체동의
        </div>

        <div class="cell my-50">
            <textarea class="field w-100 target" rows="7">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean euismod, est non egestas vestibulum, nisi ex ullamcorper erat, eget hendrerit ante metus vitae leo. Curabitur mattis orci porta libero sagittis interdum. Vivamus ullamcorper id metus nec porttitor. Phasellus sed ex risus. Ut bibendum molestie pharetra. Duis eleifend risus quis tortor sagittis congue. Proin a mollis libero. Aenean euismod turpis lacus, sed consequat enim pellentesque a. Sed dapibus lorem nec quam ornare maximus eget a est. Pellentesque et feugiat tortor, a mollis velit. Pellentesque eu turpis maximus, porta neque ornare, suscipit sem. Proin pharetra eget ipsum quis egestas. In ac tortor interdum, lobortis ex quis, elementum ipsum.
                Sed vitae tortor vulputate, tempor massa at, condimentum lectus. Quisque vitae dignissim diam, venenatis dapibus magna. Donec sit amet felis urna. Suspendisse pulvinar sed est in mattis. Duis in metus eu purus convallis dictum. Nam sapien lorem, scelerisque ac imperdiet id, dignissim sit amet quam. Suspendisse turpis felis, tristique nec felis dignissim, ornare luctus sapien. Duis egestas risus sed libero iaculis, id iaculis turpis lacinia. Integer eleifend metus a blandit aliquet. Morbi feugiat lectus et tincidunt pharetra.
                Curabitur congue iaculis purus, sit amet lobortis metus sagittis sit amet. Donec id maximus lacus. Morbi a porta ante, in tempus tortor. Sed at eleifend tellus. Maecenas vulputate, ante in posuere vulputate, quam leo semper est, et gravida purus ante id metus. Quisque non dictum augue. Ut magna massa, tempor vel est et, efficitur fringilla sapien. Nullam sed tempor purus, non volutpat felis. In dignissim accumsan purus, a porttitor urna sagittis eget.
                Sed id nulla eleifend, interdum orci in, ullamcorper risus. Nam laoreet cursus turpis, eget maximus leo bibendum eu. Nulla scelerisque, ligula nec dignissim euismod, mauris eros volutpat neque, eu sodales velit metus sed odio. Fusce tristique volutpat finibus. Praesent fermentum sed ipsum rhoncus lobortis. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Nam et nisi magna. Nam eu euismod tortor. Donec id velit diam.
                Quisque pulvinar dolor tincidunt mi porttitor, eu sagittis risus finibus. Nunc non consectetur tellus. Curabitur mauris libero, auctor a turpis sit amet, imperdiet euismod nisl. Ut ultrices augue quis consectetur cursus. Vivamus non blandit quam. Donec dolor quam, sagittis in nisi eu, placerat consequat justo. Vivamus aliquet ligula purus, eget lacinia massa dictum ut. Vivamus nec bibendum tortor. Pellentesque vehicula, ipsum nec pellentesque venenatis, urna enim malesuada metus, a facilisis felis enim ac urna. Ut ac nulla in erat ultricies interdum sed eget enim. Sed porta rutrum ante.</textarea>
        </div>
      
        <div class="cell mt-20">
            <input type="checkbox" class="check-item"> [필수]동의
        </div>
        <div class="cell">
            <textarea class="field w-100 target" rows="7">개인정보 수신 동의 이용약관:

1.본인은 서비스 이용을 위해 필요한 개인정보 수집에 동의합니다.
2.수집된 개인정보는 서비스 제공 및 개선을 위해 사용됩니다.
3.개인정보는 제3자에게 제공되지 않으며, 보안이 철저하게 유지됩니다.
4.본인은 개인정보 처리에 대한 권리를 행사할 수 있습니다.
5.개인정보 수집에 동의하지 않을 경우 일부 서비스 이용에 제한이 있을 수 있습니다.</textarea>
        </div>

        <div class="cell mt-50">
            <input type="checkbox" class="check-item">[선택]동의 
        </div>
        <div class="cell">
            <textarea class="field w-100 target" rows="7">개인정보 이벤트 수신 동의 이용약관:

1.본인은 서비스 관련 이벤트 및 프로모션 정보 수신에 동의합니다.
2.수신되는 정보는 이메일, SMS, 앱 알림 등 다양한 방식으로 제공됩니다.
3.본인의 개인정보는 이벤트 관련 정보 발송에만 사용되며, 제3자에게 제공되지 않습니다.
4.언제든지 수신 동의를 철회할 수 있으며, 철회 후에는 더 이상 이벤트 정보가 발송되지 않습니다.
5.이벤트 정보 수신에 동의하지 않으면 해당 이벤트 참여가 제한될 수 있습니다.</textarea>
        </div>
        <div class="cell my-50">
            <input type="checkbox" class="check-all"> 전체 동의 하기
        </div>
        <div class="cell my-0">
            <button class="btn btn-positive w-100">다음</button>
        </div>
    </div>

</form>

</body>
</html>