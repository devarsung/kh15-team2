<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

    <script src="https://cdn.jsdelivr.net/gh/hiphop5782/score@latest/score.min.js"></script>
    <script type="text/javascript">
    $(function(){
        $(".reviewStar").score({
            starColor: "#FFE31A",
            editable:false,//편집 가능하도록 설정
            integerOnly:false,//별을 정수 개수로만 선택하도록 설정
            send:{//전송옵션
                sendable:true,//전송 가능
                name:"reviewStar",//전송될 이름 설정
            },
            display:{
                showNumber:true,
                placeLimit:1,
                textColor:"#d63031",
            },
        });
    });  
    </script>
</head>
<div class="container w-800">

    <div class="cell center">
        <h1>시우시우 님의 후기</h1>
    </div>
    <div class="cell right">
        <i class="fa-solid fa-heart"></i>33|<i class="fa-solid fa-eye"></i> 50|<i class="fa-solid fa-comment-dots"></i>5
    </div>
    <div class="cell right">
    작성일2025-03-05|수정일2025-03-06
    </div>
    <div class="cell p-20">
        <h1>
            타코야끼맛집
        </h1>
    </div>
    <div class="cell reviewStar"></div>
    <div calss="cell p-20" style="min-height:300px; border:1px solid rgb(192, 192, 192)">
    신방화에...타코야키파는데..진짜 먹고싶다 오늘은 제발 팔아줬으면 좋겠다...계좌이체할게요.. 타코야끼에 그뭐냐 불닭 먹으면 맛있다며,,,
    배고프다 진짜 남아서 프젝하고싶은데 맨날 배가고파서 못남겠어 신방화에...타코야키파는데..진짜 먹고싶다 오늘은 제발 팔아줬으면 좋겠다...
    계좌이체할게요.. 타코야끼에 그뭐냐 불닭 먹으면 맛있다며,,,배고프다 진짜 남아서 프젝하고싶은데 맨날 배가고파서 못남겠어 신방화에...타코야키파는데..진짜 먹고싶다 오늘은 제발 팔아줬으면 좋겠다...계좌이체할게요.. 타코야끼에 그뭐냐 불닭 먹으면 맛있다며,,,배고프다 진짜 남아서 프젝하고싶은데 맨날 배가고파서 못남겠어 신방화에...타코야키파는데..진짜 먹고싶다 오늘은 제발 팔아줬으면 좋겠다...계좌이체할게요.. 타코야끼에 그뭐냐 불닭 먹으면 맛있다며,,,배고프다 진짜 남아서 프젝하고싶은데 맨날 배가고파서 못남겠어 신방화에...타코야키파는데..진짜 먹고싶다 오늘은 제발 팔아줬으면 좋겠다...계좌이체할게요.. 타코야끼에 그뭐냐 불닭 먹으면 맛있다며,,,배고프다 진짜 남아서 프젝하고싶은데 맨날 배가고파서 못남겠어 신방화에...타코야키파는데..진짜 먹고싶다 오늘은 제발 팔아줬으면 좋겠다...계좌이체할게요.. 타코야끼에 그뭐냐 불닭 먹으면 맛있다며,,,배고프다 진짜 남아서 프젝하고싶은데 맨날 배가고파서 못남겠어 신방화에...타코야키파는데..진짜 먹고싶다 오늘은 제발 팔아줬으면 좋겠다...계좌이체할게요.. 타코야끼에 그뭐냐 불닭 먹으면 맛있다며,,,배고프다 진짜 남아서 프젝하고싶은데 맨날 배가고파서 못남겠어 신방화에...타코야키파는데..진짜 먹고싶다 오늘은 제발 팔아줬으면 좋겠다...계좌이체할게요.. 타코야끼에 그뭐냐 불닭 먹으면 맛있다며,,,배고프다 진짜 남아서 프젝하고싶은데 맨날 배가고파서 못남겠어 신방화에...타코야키파는데..진짜 먹고싶다 오늘은 제발 팔아줬으면 좋겠다...계좌이체할게요.. 타코야끼에 그뭐냐 불닭 먹으면 맛있다며,,,배고프다 진짜 남아서 프젝하고싶은데 맨날 배가고파서 못남겠어 신방화에...타코야키파는데..진짜 먹고싶다 오늘은 제발 팔아줬으면 좋겠다...계좌이체할게요.. 타코야끼에 그뭐냐 불닭 먹으면 맛있다며,,,배고프다 진짜 남아서 프젝하고싶은데 맨날 배가고파서 못남겠어 </div>
    <br>
    <div class="cell left my-0">
        <label>댓글등록</label>
    </div>
    <div class="flex-box">
        <div class="cell w-100" style="border:1px solid lightgray">
            <textarea style="min-height:100px; max-height:250px; "class="w-100" placeholder="댓글입력창"></textarea>
        </div>
        <div class="cell right w-150 flex-vertical">
            <button class="btn btn-neutral ">등록</button>
        </div>
    </div>

    <div class="cell left my-0">
        <label>댓글목록</label>
    </div>
    <div class="cell flex-box" style="border: 1px solid lightgray;">
            <div class="w-150 my-0 mx-10">
                <span class="" style="font-size:13px;color: gray;">2025-03-06</span>
                <h3 class="">닉네임</h3>
            </div>
            <div class="w-100 mt-10">
            <h5>이것은 예시로 작성된 글입니다. 텍스트의 길이는 500자 정도이며, 다양한 형태의 내용으로 구성되어 있습니다. 우리가 일상에서 자주 겪는 일들이나 생각들을 적어보면, 그만큼 글을 쓰는 것이 중요하고 재미있는 일이라는 것을 알 수 있습니다. 글을 쓰는 것은 단순히 문자를 배열하는 것이 아니라, 자신의 생각과 감정을 전달하는 중요한 수단입니다. 이처럼 우리는 글을 통해 소통하고, 다양한 아이디어와 정보를 교환할 수 있습니다. 또한, 글쓰기는 학문적인 목적뿐만 아니라 개인적인 기록을 남기거나 창작을 할 때도 매우 유용한 도구입니다. 글을 통해 세상과 소통하고, 자신의 생각을 표현하는 것은 매우 의미 있는 일이라고 할 수 있습니다. 그러므로 글쓰기를 계속해서 연습하고, 나만의 스타일을 찾는 것이 중요합니다. 이제 이 글을 끝내기 전에, 이 글이 독자에게 어떠한 메시지를 전달하고 있는지 다시 한번 생각해보는 것이 좋습니다. 글을 쓸 때는 항상 독자를 생각하며 작성하는 것이 중요합니다. 글의 목적에 맞게 정확하고 명확한 전달이 이루어지도록 노력해야 합니다.</h5>     
        </div>
        <div class="m-10 w-15">
                <button class="" style="border: 1px solid rgb(218, 218, 218); background-color: rgb(224, 241, 255);"><i class="fa-solid fa-pen-to-square"></i></button>
                <button class="" style="border: 1px solid rgb(218, 218, 218); background-color: rgb(255, 224, 224);"><i class="fa-regular fa-trash-can"></i></button>
            </div>

        </div>
    <div class="cell flex-box" style="border: 1px solid lightgray;">
            <div class="w-150 my-0 mx-10">
                <span class="" style="font-size:13px;color: gray;">2025-03-06</span>
                <h3 class="">열받아</h3>
            </div>
            <div class="w-100 mt-10">
            <h5>플렉스박스 패러가실 파티원구함</h5>     
        </div>
        <div class="m-10 w-15">
                <button class="" style="border: 1px solid rgb(218, 218, 218); background-color: rgb(224, 241, 255);"><i class="fa-solid fa-pen-to-square"></i></button>
                <button class="" style="border: 1px solid rgb(218, 218, 218); background-color: rgb(255, 224, 224);"><i class="fa-regular fa-trash-can"></i></button>
            </div>

        </div>
    <div class="cell flex-box" style="border: 1px solid lightgray;">
            <div class="w-150 my-0 mx-10">
                <span class="" style="font-size:13px;color: gray;">2025-03-06</span>
                <h3 class="">특근하실분</h3>
            </div>
            <div class="w-100 mt-10">
            <h5>주말특근하실분 구함</h5>     
        </div>
        <div class="m-10 w-15">
                <button class="" style="border: 1px solid rgb(218, 218, 218); background-color: rgb(224, 241, 255);"><i class="fa-solid fa-pen-to-square"></i></button>
                <button class="" style="border: 1px solid rgb(218, 218, 218); background-color: rgb(255, 224, 224);"><i class="fa-regular fa-trash-can"></i></button>
            </div>

        </div>

    <div class="cell center">
        <button class="btn btn-neutral" style="width:200px">목록으로</button>
    </div>

</div>
</body>

</html>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>   
