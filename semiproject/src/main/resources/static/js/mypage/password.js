$(function(){
            var status ={
                currentPw : false,
                newPw : false,
                reinputPw : false,
                ok : function(){
                    return this.currentPw && this.newPw && this.reinputPw
                },
            };

            $("[name=currentPw]").blur(function(){
            var isValid = $(this).val().length > 0;
            $(this).removeClass("fail").addClass(isValid ? "" : "fail")
            status.currentPw = isValid;
        });

            $("[name=newPw]").blur(function(){
                var regex = /^[A-Za-z0-9!@#$]{8,16}$/; 
                var isValid = regex.test($(this).val());
                $(this).removeClass("success fail").addClass(isValid ? "success" : "fail")
                status.newPw = isValid;
            });

            $("[name=reinputPw]").blur(function(){
                var newPw = $("[name=newPw]").val();
                var reinputPw = $(this).val();
                $(this).removeClass("success fail fail2");
                if(status.newPw == false){
                    $(this).addClass("fail2");
                    status.reinputPw = false;
                }
                else if(newPw != reinputPw){
                    $(this).addClass("fail");
                    status.reinputPw = false;
                }
                else{
                    $(this).addClass("success")
                        status.reinputPw = true;
            }
            });

            $(".form-check").submit(function(){
                $("[name]").trigger("blur");
                return status.ok();
            });
        });
      