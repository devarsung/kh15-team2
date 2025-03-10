 $(function(){
       $(".reviewStar").score({
           starColor: "#FFE31A",
           editable:false,//편집 가능하도록 설정
           integerOnly:false,//별을 정수 개수로만 선택하도록 설정
           send:{//전송옵션
               sendable:false,//전송 가능
           },
           display:{
               textColor:"#d63031",
           },
       });
   });  
   