<!Doctype html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link rel="stylesheet" href="/bootstrap/3.3.0/css/bootstrap.css" />
<link rel="stylesheet" href="/css/install/main.css" />
<link rel="stylesheet" type="text/css" href="/bootstrap/toastr/toastr.min.css">
<style type="text/css">
	.title{
		font-size:20px;
	}
	.align_center{
		text-align:center;
	}
	.align_left{
		text-align:left;
	}
	.align_right{
		text-align:right;
	}
	.content{
		text-indent:2em;
	}
	.font_bold{
		font-weight:bold;
	}
</style>
<title>阅读须知</title>
</head>
<body>
    
    <div class="container self_main">
    
        <!-- 标题 -->
        <div class="row">
            <div class="col-xs-12">
                <div class="page-header self_header">
                    <p><em>FCMS安装向导</em></p>
                    <!-- <img src="/images/install_logo.png"> -->
                </div>
            </div>
        </div>
        
        <!-- 内容 -->
        <div class="row">
        
            <!-- 流程 -->
            <div class="col-xs-3">
                <ul class="self_procedure">
                    <li><button class="self_btn_circular_active">安装须知</button></li>
                    <li><button class="self_btn_circular">环境检测</button></li>
                    <li><button class="self_btn_circular">数据创建</button></li>
                    <li><button class="self_btn_circular">完成安装</button></li>
                </ul>
            </div>
            
            <!-- 正文 -->
            <div class="col-xs-9">
            
                <!-- 安装须知 -->
                <div class="row">
                    <div class="col-xs-12">
                        <div class="self_license_content">
                        	<p class="align_center title font_bold">FCMS软件使用协议</p>
							<br/>
							<p class="content">感谢您选择FCMS，我们致力于为您提供更快，更好，更轻量化的内容管理系统！</p>
							<br>
							<p class="content">FCMS遵循Apache Licence 2开源协议发布，并提供免费使用。</p>
							<br>
							<p class="content">Apache Licence 2是著名的非盈利开源组织Apache采用的协议。</p>
							<br>
							<p class="content">该协议鼓励代码共享和尊重原作者的著作权，允许代码修改，再作为开源或商业软件发布。需要满足的条件： </p>
							<p class="content">1． 需要给代码的用户一份Apache Licence 2；</p>
							<p class="content">2． 如果你修改了代码，需要在被修改的文件中说明；</p>
							<p class="content">3． 在延伸的代码中（修改和有源代码衍生的代码中）需要带有原来代码中的协议，商标，专利声明和其他原来作者规定需要包含的说明；</p>
							<p class="content">4． 如果再发布的产品中包含一个Notice文件，则在Notice文件中需要带有本协议内容。你可以在Notice中增加自己的许可，但不可以表现为对Apache Licence 2构成更改。 </p>
							<br>
							<p class="content">具体的协议参考：http://www.apache.org/licenses/LICENSE-2.0</p>
							<br>
							<p class="content font_bold">FCMS免责声明</p>
							<p class="content">1、使用FCMS构建的网站的任何信息内容以及导致的任何版权纠纷和法律争议及后果，FCMS官方不承担任何责任。</p>
							<p class="content">2、您一旦安装使用FCMS，即被视为完全理解并接受本协议的各项条款，在享有上述条款授予的权力的同时，受到相关的约束和限制。</p>
                        	<br><br>
                        </div>
                    </div>
                    
                </div>
                
                <div class="row self_choose_step">
                    
                    <!-- 继续安装 -->
                    <div class="col-xs-12 text-right">
                        <a href="/install/index/check" class="btn btn-danger btn-lg self_btn_normal">继续安装</a>
                    </div>
                </div>
                
            </div>
            
        </div>
        
    </div>


<script src="/js/jquery/jquery-1.11.1.min.js"></script>
<script src="/bootstrap/3.3.0/js/bootstrap.js"></script>
<script src="/js/install/html5shiv.js"></script>
<script src="/js/install/respond.js"></script>
<script src="/bootstrap/toastr/toastr.min.js"></script>
<script>
$( document ).ready( function(){
	//判断浏览器
	var agentInfo = navigator.userAgent;
	var serverNum = parseInt( agentInfo.substring( 30, 31 ) );//这里截取的是字符串，必须转化成数字才可以在switch中进行判断
	if( agentInfo.indexOf( "MSIE" ) > 0 ){
	    switch ( serverNum ){
    	    case 5:
    	    case 6:
    	    case 7:
    	    case 8:
    		    toastr.error( '您的浏览器兼容性不好，请使用IE9及以上版本或其他浏览器打开！' );
    		    break;
	    }
	}
} );

</script>
</body>
</html>