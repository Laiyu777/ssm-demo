<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/static/js/jquery-3.2.1.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/static/js/echarts.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/css/bootstrap.css" ></link>
</head>
<body>

<jsp:include page="../template/top.jsp"></jsp:include>

	<div class="container">
		<div class="row">
			<div class="col-md-6 ">
				<div id="main" style="height: 300px"></div>
			</div>
			<div class="col-md-6 ">
				<div id="main2" style="height: 300px"></div>
			</div>
		</div>
		<div class="row">
		<div class="col-md-6"><br><br>
				<div id="main4" style="height: 400px"></div>
			</div>
			<div class="col-md-6"><br><br>
				<div id="main3" style="height: 400px"></div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
	
	
	
	var myChart = echarts.init(document.getElementById('main'));
	var option = {
		    title : {
		        text: '店铺销售趋势',
		    },
		    tooltip : {
		        trigger: 'axis'
		    },
		    legend: {
		        data:['订单完成数','图书数']
		    },
		    toolbox: {
		        show : true,
		        feature : {
		            mark : {show: true},
		            dataView : {show: true, readOnly: false},
		            magicType : {show: true, type: ['line', 'bar']},
		            restore : {show: true},
		            saveAsImage : {show: true}
		        }
		    },
		    calculable : true,
		    color:[
                   '#00aeef',	//温度曲线颜色
                   '#53FF53',	//湿度曲线颜色
                   ],
		    dataZoom: [
		                 {
		                     type: 'slider',	//支持鼠标滚轮缩放
		                     start: 0,			//默认数据初始缩放范围为10%到90%
		                     end: 100
		                 },
		                 {
		                     type: 'inside',	//支持单独的滑动条缩放
		                     start: 0,			//默认数据初始缩放范围为10%到90%
		                     end: 100
		                 }
		            ],
		    xAxis : [
		        {
		            type : 'category',
		            boundaryGap : false,
		            data : eval("${sessionScope.daySet}")
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value',
		            name:'订单数',
		            axisLabel : {
		                formatter: '{value} 单'
		            }
		        },
		        {
		            type : 'value',
		            name:'图书数',
		            axisLabel : {
		                formatter: '{value} 本'
		            }
		        }
		    ],
		    series : [
		        {
		            name:'订单完成数',
		            type:'line',
		            data:eval("${sessionScope.orderCountSet}"),
		           
		            markLine : {
		                data : [
		                    {type : 'average', name: '平均值'}
		                ]
		            }
		        },  
		        {
		            name:'图书数',
		            type:'line',
		            data:eval("${sessionScope.bookCount}"),
		           
		            markLine : {
		                data : [
		                    {type : 'average', name: '平均值'}
		                ]
		            }
		        }
		        
		    ]
		};
	 myChart.setOption(option); 
	 
	 
	 var myChart2 = echarts.init(document.getElementById('main2'));
		var option2 = {
			    title : {
			        text: '书籍销售趋势',
			    },
			    tooltip : {
			        trigger: 'axis'
			    },
			    legend: {
			        data:['图书销售数','图书库存数']
			    },
			    toolbox: {
			        show : true,
			        feature : {
			            mark : {show: true},
			            dataView : {show: true, readOnly: false},
			            magicType : {show: true, type: ['line', 'bar']},
			            restore : {show: true},
			            saveAsImage : {show: true}
			        }
			    },
			    calculable : true,
			    color:[
	                   '#00aeef',	
	                   '#53FF53',	
	                   ],
			    dataZoom: [
			                 {
			                     type: 'slider',	//支持鼠标滚轮缩放
			                     start: 0,			//默认数据初始缩放范围为10%到90%
			                     end: 100
			                 },
			                 {
			                     type: 'inside',	//支持单独的滑动条缩放
			                     start: 0,			//默认数据初始缩放范围为10%到90%
			                     end: 100
			                 }
			            ],
			    xAxis : [
			        {
			            type : 'category',
			            //boundaryGap : false,
			            data : eval("${sessionScope.bookNames}"),
			            interval:0,
                        rotate:45,
                        margin:2,
                        axisLabel:{  
                            interval:0,//横轴信息全部显示  
                            rotate:-30//-30度角倾斜显示  
                       } 
			        }
			    ],
			    yAxis : [
			        {
			            type : 'value',
			            name:'本数',
			            axisLabel : {
			                formatter: '{value}本'
			            }
			        }
			    ],
			    series : [
			        {
			            name:'图书销售数',
			            type:'bar',
			            data:eval("${sessionScope.bookSale}"),
			            markPoint : {
			                data : [
			                    {type : 'max', name: '最大值'}
			                ]
			            },
			            markLine : {
			                data : [
			                    {type : 'average', name: '平均值'}
			                ]
			            }
			        },
			        {
			            name:'图书库存数',
			            type:'bar',
			            data:eval("${sessionScope.bookStock}"),
			            markPoint : {
			                data : [
			                    {type : 'max', name: '最大值'}
			                ]
			            }
			        }
			        
			    ]
			};
		 myChart2.setOption(option2);
	 	//饼图 各类图书占比
		 var myChart3 = echarts.init(document.getElementById('main3'));
	 	 var option3 = {
	 		    title : {
	 		        text: '图书销售占比',
	 		        x:'center'
	 		    },
	 		    tooltip : {
	 		        trigger: 'item',
	 		        formatter: "{a} <br/>{b} : {c} ({d}%)"
	 		    },
	 		   /*  legend: {
	 		        orient : 'vertical',
	 		        x : 'left',
	 		        data:['直接访问','邮件营销','联盟广告','视频广告','搜索引擎']
	 		    }, */
	 		    toolbox: {
	 		        show : true,
	 		        feature : {
	 		            mark : {show: true},
	 		            dataView : {show: true, readOnly: false},
	 		            magicType : {
	 		                show: true, 
	 		                type: ['pie','funnel'],
	 		                option: {
	 		                    funnel: {
	 		                        x: '25%',
	 		                        width: '50%',
	 		                        funnelAlign: 'left',
	 		                        max: 1548
	 		                    }
	 		                }
	 		            },
	 		            restore : {show: true},
	 		            saveAsImage : {show: true}
	 		        }
	 		    },
	 		    calculable : true,
	 		    series : [
	 		        {
	 		            name:'销售情况',
	 		            type:'pie',
	 		            radius : '55%',
	 		            center: ['50%', '60%'],
	 		            data:eval("${sessionScope.VKlist2}")
	 		        }
	 		    ]
	 		};
	 	 myChart3.setOption(option3); 
	 	 
	 	 
	 	 //各类订单占比
	 	  var myChart4 = echarts.init(document.getElementById('main4'));
	 	 var option4 = {
	 		    title : {
	 		        text: '各类订单占比',
	 		        x:'center'
	 		    },
	 		    tooltip : {
	 		        trigger: 'item',
	 		        formatter: "{a} <br/>{b} : {c} ({d}%)"
	 		    },
	 		    legend: {
	 		        orient : 'vertical',
	 		        x : 'left',
	 		        data:['等待付款','已付款，等待发货','已经发货','订单完成','订单取消']
	 		    }, 
	 		    toolbox: {
	 		        show : true,
	 		        feature : {
	 		            mark : {show: true},
	 		            dataView : {show: true, readOnly: false},
	 		            magicType : {
	 		                show: true, 
	 		                type: ['pie','funnel'],
	 		                option: {
	 		                    funnel: {
	 		                        x: '25%',
	 		                        width: '50%',
	 		                        funnelAlign: 'left',
	 		                        max: 1548
	 		                    }
	 		                }
	 		            },
	 		            restore : {show: true},
	 		            saveAsImage : {show: true}
	 		        }
	 		    },
	 		    calculable : true,
	 		    series : [
	 		        {
	 		            name:'占比',
	 		            type:'pie',
	 		            radius : '55%',
	 		            center: ['50%', '60%'],
	 		            data:eval("${sessionScope.VKlist3}")
	 		        }
	 		    ]
	 		};
	 	 myChart4.setOption(option4);
	</script>
	
	<%@include file="../template/bottom.jsp" %>
</body>
</html>