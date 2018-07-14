/*菜单栏的显示*/
$(".nav>li>a").on('mouseover',function(){
	$(this).next().css("display","block");
	$(this).css("color","#CE0000").css("background-color","#fff");
});

$(".nav>li>a").on('mouseout',function(){
	$(this).next().css("display","none");
	$(this).css("color","#fff").css("background-color","#CE0000");
});

$(".nav>li>ul").on('mouseover',function(e){
	$(this).prev().css("color","#CE0000").css("background-color","#fff");
	$(this).css("display","block");
})

$(".nav>li>ul").on('mouseout',function(e){
	$(this).css("display","none");
	$(this).prev().css("color","#fff").css("background-color","#CE0000");
})

/*banner的自动播放*/
var titles =  $(".banner-text a");
var images = $(".banner-slide-img div").slice(0,3);
var footerTitles = $(".banner-footer-title a");
var dots = $(".dots a");

var index = 0;
//默认设置第一个圆点
$(dots[0]).css("background-color","#fff");
function changeImage(){
	//console.log("changeImage()接收到的index是:"+index)
	//改变图片 改变上方标题
	$(images[index]).css("opacity","0");
	$(titles[index]).css("display","none");
	$(footerTitles[index]).css("display","none");

	//处理圆点 index=0是填充第二个点 index=1是填充第三个点 index=0是填充第一个点
	for(var i = 0;i<3;i++){
		$(dots[i]).css("background-color","rgba(7, 17, 27, 0.4)");
	}
	if(index==2){
		$(dots[0]).css("background-color","#fff");//填充第一个点
	}else{
		$(dots[index+1]).css("background-color","#fff");
	}

	index++;

	if(index==3){//第一次轮播结束的时候，只有小原点的处理特殊一些
		index = 0;
		for(var i=0;i<3;i++){
			$(images[i]).css("opacity","1");
			$(titles[i]).css("display","block");
			$(footerTitles[i]).css("display","block");
		}		
	}
	
}

var timer = setInterval(changeImage,3000);
//移动到图片的时候停放,移开就继续
$(".banner-slide-img").on("mouseover",function(){
	clearInterval(timer);
})

$(".banner-slide-img").on("mouseout",function(){
	timer = setInterval(changeImage,3000);
})

//点击banner左右两边的按钮
$(".next-img").click(function(){
	//获取当前的索引
	var i = index;
	//将当前的图片标题隐藏起来，就会显示下一张
	$(images[index]).css("opacity","0");
	$(titles[index]).css("display","none");
	$(footerTitles[index]).css("display","none");
	index = i+1;
	//设置小圆点
	for(var k = 0;k<3;k++){
		$(dots[k]).css("background-color","rgba(7, 17, 27, 0.4)");
	}
	$(dots[index]).css("background-color","#fff");

	if(index == 3){//最后一张的时候把所有图片重置，默认显示第一张
		index = 0;
		for(var j=0;j<3;j++){
			$(images[j]).css("opacity","1");
			$(titles[j]).css("display","block");
			$(footerTitles[j]).css("display","block");
			//设置第一个圆点
		}	
		$(dots[0]).css("background-color","#fff");
	}
})
$(".pre-img").click(function(){
	//console.log("$(\".pre-img\")接收的index值："+index)
	//获取当前的索引
	//先初始化样式
	for(var j=0;j<3;j++){
			$(dots[j]).css("background-color","rgba(7, 17, 27, 0.4)");
			$(titles[j]).css("display","none");
			$(footerTitles[j]).css("display","none");
			//$(images[j]).css("opacity","1");
	}

	//为上一个点填充或者是第一个点
	if(index == 0){//显示第三张图片
		$(dots[2]).css("background-color","#fff");
		$(images[0]).css("opacity","0");
		$(images[1]).css("opacity","0");	
		$(titles[2]).css("display","block");
		$(footerTitles[2]).css("display","block");
		
		index = 2;
	}else{//显示第二张图片
		$(dots[index-1]).css("background-color","#fff");
		$(images[index-1]).css("opacity","1");
		$(titles[index-1]).css("display","block");
		$(footerTitles[index-1]).css("display","block");
		index -=1;
	}

	//更新index的值
	
});

//处理圆点的切换图片
$.each(dots,function(i,n){
	$(n).click(function(){
		var count = parseInt($(this).attr("index"));
		index = count;
			//先将小圆点全部取消
		for(var j=0;j<3;j++){
			$(images[j]).css("opacity","1");
			$(dots[j]).css("background-color","rgba(7, 17, 27, 0.4)");
			$(titles[j]).css("display","none");
			$(footerTitles[j]).css("display","block");
		}
		$(dots[index]).css("background-color","#fff");
		if(index==0){
			$(images[index]).css("opacity","1");
			$(titles[index]).css("display","block");
			$(titles[index+1]).css("display","block");
			$(titles[index+2]).css("display","block");
		}else if(index==1){
			$(images[index-1]).css("opacity","0");
			$(titles[index]).css("display","block");
			$(titles[index+1]).css("display","block");
			$(footerTitles[index-1]).css("display","none");
			// $(footerTitles[index+1]).css("display","block");
		}else{
			$(images[index-1]).css("opacity","0");
			$(images[index-2]).css("opacity","0");
			$(titles[index]).css("display","block");
			$(footerTitles[index-1]).css("display","none");
			$(footerTitles[index-2]).css("display","none");
		}
		//console.log("点击圆点后改变的index是："+index)
	});
})


/*******网页下方的图片滚动********/
//处理图片的自动滚动
var floorArea =  $(".floor-5-body")[0];
var firstFloorArea =  $(".floor-5-body div:first-child")[0];
function imageAutoRoll(){
	var left = floorArea.scrollLeft;
	if(left<firstFloorArea.scrollWidth){
		floorArea.scrollLeft ++;
	}else{
		floorArea.scrollLeft = 0;
	}
}
var scrollTimer = setInterval(imageAutoRoll,10);


//鼠标在上面停止滚动，移开继续滚动
$(firstFloorArea).on("mouseover",function(){
	clearInterval(scrollTimer);
})
$(firstFloorArea).on("mouseout",function(){
	scrollTimer = setInterval(imageAutoRoll,10);
})

//点击查看全部的时候显示模态框
//先设置模态框的样式
var height =window.screen.availHeight;//这是除去任务栏的屏幕高度
//console.log("\""+height+"px\"")
$("#stay_modal").css("height",height);

$("#lookToday").click(function(){
	$("#stay_modal").css("display","block");
});

//单个部门查询的时候
$("#dept_modal").css('height',height);

$("a[dept_modal]").click(function(){
	var deptName = $(this).html();
	$.ajax({
		url:"getTodayStayByDeptName",
		method:"get",
		data:"deptName="+deptName,
		success:function(result){
			$("td[deptName]").html(deptName);
            $("td[dayEmps]").html(" ");
            $("td[nightEmps]").html(" ");
			if(result.length>0){
                var info = result[0];
                var dayEmps = "";
                if(info.dayEmps!=null){
                    for(var i=0;i<info.dayEmps.length;i++){
                        dayEmps += info.dayEmps[i].name+",";
                    }
				}
                var dayEmps1 = dayEmps.substring(0,dayEmps.length-1);
                $("td[dayEmps]").html(dayEmps1);

                var nightEmps =""
                if(info.nightEmps!=null) {
                    for (var i = 0; i < info.nightEmps.length; i++) {
                        nightEmps += info.nightEmps[i].name + ",";
                    }
                }
                var nightEmps1 = nightEmps.substring(0,nightEmps.length-1);
                $("td[nightEmps]").html(nightEmps1);
			}

            $("#dept_modal").css("display","block");
		}
	});
});

//点击外面的时候小时
$("#stay_modal").click(function(){
	//console.log("外面被点击了")
	$(this).css("display","none");
});

$("#dept_modal").click(function(){
    //console.log("外面被点击了")
    $(this).css("display","none");
});

//点击到里面模态框的内容时候不会被关闭
$('.modal-content').click(function(e){
	//console.log("里面被点击了")
	e.stopPropagation();
});

//显示注册框
$("#register_btn").click(function(){
	$('#register_modal').css("height",height);
	$('#register_modal').css("display","block");
});

$("#register_modal").click(function(){
	//console.log("外面被点击了")
	$(this).css("display","none");
});

//左侧常用链接模态框
$("#nav_left_btn").click(function(){
	$("#common_link_modal").css("display","block");
    $("#common_link_modal").css("height",height);
});

$("#common_link_modal").click(function(){
	$(this).css("display","none");
});



/******处理向上向下滚动按钮*****/

var documentHeight = $(document).height();
var windowAvailHeight = $(this).height();

$(window).scroll(function(){
	var scrollTop = $(this).scrollTop();
	//console.log(scrollTop)
	//console.log(document.clientHight);
	//console.log("屏幕可用高度："+typeof(window.screen.availHeight));
	if(scrollTop > 0){
		$("#btn-up").fadeIn(600);
		$("#btn-down").fadeIn(600);
	}
	if(scrollTop==0){
			$("#btn-up").fadeOut(600);
	}
	var heightHaveScrolled = scrollTop;
	if(documentHeight==heightHaveScrolled+windowAvailHeight){//判断是否滑动到底部
		$("#btn-down").fadeOut(600);
	}
});

/****实现点击返回顶部和底部***/
$("#btn-up").click(function(){
	//$(window).scrollTop(0);
	$('body,html').animate({scrollTop:0},500)
})

$("#btn-down").click(function(){
	//$(window).scrollTop(documentHeight-windowAvailHeight);
    $('body,html').animate({scrollTop:documentHeight-windowAvailHeight},500)
})

//登录验证方法
$("#login_btn").click(function () {
	var data = $("#login_form").serialize();
	//console.log(data);
	$.ajax({
		url:"/login",
		data:data,
		type:"post",
		success:function (result) {
			if(result.code == 400){
				$("#login_form label").css("color","red");
                $("#login_form input").css("border","2px solid red");
				alert(result.info);
			}else{
				location.href = "/";
			}
        },
		error:function(){
			alert("服务器繁忙请稍后再试!");
		}
	})
});

//表单提交验证
$("#register_form").submit(function () {
    var password1 = $("#register_form input[name=password]").val();
    var password2 = $("#register_form input[name=confirm_password]").val();
    if(password1!=password2){
    	alert("两次输入的密码不一样");
        $("#register_form input[name=password]").val("").focus();
        $("#register_form input[name=confirm_password]").val("");
        return false;
	}else {
    	$.ajax({
			url:"/register",
			data:$("#register_form").serialize(),
			type:"post",
			success:function(result){
				if(result.code == 200){
                    alert("注册成功，请等待管理员审核");
                    location.href = "/";
				}else {
					alert(result.info);
                    $("#register_form input[name=username]").val("").focus();
				}
			},
			error:function(result){
				alert("服务器繁忙，请稍后再试")
			}
		});
	}
    return false;
});


//取消注册按钮
$("#cancel_register").click(function () {
	$("#register_modal").css("display","none");
});

//点击留守信息中“查看更多的按钮” 弹出一个新的页面
$("#lookMoreStay").click(function(){
    window.open("moreStay","_blank","toolbar=yes, location=yes, directories=no, status=no, menubar=yes, scrollbars=yes, resizable=yes, copyhistory=yes, width=1203, height=800");
});