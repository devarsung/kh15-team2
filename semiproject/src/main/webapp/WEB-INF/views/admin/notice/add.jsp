<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <!-- google font -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

    <!-- font awesome cdn -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    
    <link rel="stylesheet" type="text/css" href="./css/commons.css">
    <!-- <link rel="stylesheet" type="text/css" href="./css/test.css"> -->
    <style>
        .note-editable {
            background-color: white !important;
        }
    </style>

    <!-- jQuery cdn -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <!-- summernote cdn -->
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.js"></script>

    <script type="text/javascript">
        $(function () {
            $("[name=noticeContent]").summernote({
                height:250,//높이(px)
                minHeight:200,//최소 높이(px)
                maxHeight:400,//최대 높이(px)



                placeholder:"타인에 대한 무분별한 비방시 예고 없이 삭제될 수 있습니다",

                //메뉴(toolbar)설정
                toolbar:[
                    //['메뉴명',['버튼명','버튼명',...]]
                    ["font",["style","fontname","fontsize","forecolor" ,"backcolor"]],
                    ["style",["bold","italic","underline","strikethrough"]],
                    ["attach",["picture"]],
                    ["tool",["ol","ul","table","hr","fullscreen"]],
                    // ["acion",["undo","redo"]]
                ],

                //상황에 맞는 callback 함수들
                callback:{
                    onlmageUpload:function(files){
                        //예상 시나리오
                        //1.서버로 사용자가 선택한 이미지를 업로드
                        //- 이미지는 multipart/form-data형태여야 한다
                        //- 상황상 form을 쓸 수가 없으므로 ajax를 써야 한다
                        //2.업로드한 이미지에 접근할 수 있는 정보 획득
                        //3.획득한 정보로 <img> 생성
                        //4.에디터에 추가
                        //-$("[name=boardContent]").summernote("insertNode",이미지 태그 객체);
                        // console.log(files);
                        if(files.length !=1)return;

                        var form=new FormData();//form을 대신할 도구
                            form.append("attach",files[0]);

                            $.ajax({
                                processData:false,//파일업로드를 위해 반드시 필요한 설정
                                contentType:false,//파일업로드를 위해 반드시 필요한 설정
                                url:"http://localhost:8080/rest/notice/upload",
                                method:"post",
                                data:form,
                                success:function(response){//첨부파일번호(attachmentNo)
                                    //첨부파일 번호를 이용해서 src생성
                                    //http://localhost:8080/attachment/download?attachmentNo=번호
                                    var tag=$("<img>").attr("src","http://localhost:8080/attachment/download?attachmentNo="+response)
                              
                                    .addClass("summernote-img");
                                    $("[name=noticeContent]").summernpte("insertNode",tag[0]);
                                }
                       });
                    },
                },
            });
        });
    </script>
         <script src="/js/summernote-custom.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote-lite.min.js"></script>
    <script src="/js/admin-notice-add-summernote.js"></script>
      <div class="container w-800">
        <div class="cell center" >
            <h1>공지사항 작성</h1>
        </div>
        
        <form class="form-check" action="add" method="post">
        <div class="cell">
            <label class="p-10">제목</label>
           <input class="field w-100" type="text" name="noticeTitle"  placeholder="제목 입력">
           <div class="fail-feedback">&nbsp;&nbsp;제목을 작성해주세요</div>
        </div>
        <div class="cell my-40">
            <label class="p-10">본문</label>
            <textarea name="noticeContent" ></textarea>
        </div>
        <div class="cell">
            <button type="submit" class="btn btn-positive w-100" style="height: 50px;">작성하기</button>
        </div>
        </form>
    </div>
        
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>   