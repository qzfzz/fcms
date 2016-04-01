<!DOCTYPE html>
<html lang="zh_CN">
<head>
	<title>FCMS</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="chrome=1,IE=edge" />
	<meta name="renderer" content="webkit">
	<meta charset="utf-8" />
	<meta name="description" content="This is page-header" />
	<meta name="keywords" content="后台主页" />
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	<link rel='icon' href='/public/favicon.ico' mce_href='/public/favicon.ico' type='image/x-icon' />
	<link rel='shortcut icon' href='/public/favicon.ico' mce_href='/public/favicon.ico' type='image/x-icon' />
	<link rel="stylesheet" href="/bootstrap/3.3.0/css/bootstrap.css" />
	<link rel="stylesheet" type="text/css" href="/public/css/fcmsindex/basic.css" />
	<link rel="stylesheet" href="/public/bootstrap/jqueryConfirm/2.5.0/jquery-confirm.css">
	<style>
.bsc_user .img {
    border-radius: 50%;
	margin-left:21%;
    height: 100px;
    width: 100px;
	cursor:pointer;
}
.bsc_user .img::before {
    border-radius: 50%;
    content: "";
    display: block;
    position: absolute;
    transition: all 0.35s ease-in-out 0s;
    width: 100%;
}
.bsc_user .img img {
    border-radius: 50%;
}
.bsc_user img {
    height: 100%;
    width: 100%;
}
</style>
</head>

<body>
	<!-- 主框架 -->
	<div class="bsc_frame container-fluid">
	
		<!-- 头部导航栏 -->
		<div class="bsc_header">
			<!-- logo -->
			<div class="bsc_logo">
				<img src='/public/img/admin/fcms/logo1.png' title="首页">
			</div>
			<!-- 头部选项按钮 -->
			<div class="bsc_top_buttons">
				<!-- 查看前台 -->
				<div class="bsc_op_btn bsc_op_back" title='回到前台'>
					<span><img src='/public/img/admin/fcms/circle_logo.png'></span>
				</div>
				<!-- 消息框 -->
				<div class="bsc_op_btn" box="msg" title="消息"><span class="glyphicon glyphicon-envelope"></span></div>
				<div class="bsc_dropdown_menu_msg">
					<div><!-- 消息框尖嘴 --></div>
					<ul>
						<li><i class="glyphicon glyphicon-envelope"></i>您有5条消息</li>
						<li><a>系统消息</a></li>
						<li><a>云锋服务</a></li>
						<li><a>推荐消息</a></li>
						<li>查看全部消息<i class="glyphicon glyphicon-chevron-right"></i></li>
					</ul>
				</div>
				<!-- 设置框 -->
				<div class="bsc_op_btn" box="set" title="设置"><span class="glyphicon glyphicon-cog"></span></div>
				<div class="bsc_dropdown_menu_set">
					<div><!-- 设置框尖嘴 --></div>
					<ul>
						<li><i class="glyphicon glyphicon-cog"></i>设置</li>
						<li class="bsc_set_site"><a>站点管理</a></li>
						<li class="bsc_set_static"><a>静态化中心</a></li>
					</ul>
				</div>
				<!-- 用户信息框 -->
				<div class="bsc_op_btn" box="user" title="用户信息"><span class="glyphicon glyphicon-user"></span></div>
				<div class="bsc_dropdown_menu_user">
					<div><!-- 用户信息框尖嘴 --></div>
					<ul>
						<li><i class="glyphicon glyphicon-user"></i>用户管理</li>
						<li class="bsc_op_userinfo"><a>个人资料</a></li>
						<li class="bsc_op_logout"><a>退出登录</a></li>
					</ul>
				</div>
			</div>
		</div><!-- bsc_header -->
		
		
		<!-- 面包屑 -->
		<div class="bsc_nav">
			<div>
				<i class="glyphicon glyphicon-map-marker"></i>
				<span style="">&nbsp;&nbsp;您所在的位置：</span>
			</div>
			<div class="bsc_nav_position"></div>
		</div><!-- bsc_nav -->
		
		
		<!-- 页面主体 -->
		<div class="bsc_main">
			<!-- 左侧菜单框 -->
			<div class="bsc_sidebar">
				<!-- 用户信息 -->
				<div class="bsc_user">
					<div class="img">
						<img alt="我的头像" src="{% if avatar is defined %}{{avatar}}{%else%}/public/img/home/avatar_male.png{% endif %}" />
					</div>
					<div class="bsc_user_info" title='{% if userInfo != empty %}{{ userInfo[ "nickname" ] | e }}{% else %}visitor{% endif %}'>
						Dear <span id='bsc_user_nickname'>{% if nickName != empty %}{{ nickName | e }}{% else %}visitor{% endif %}</span>
					</div>
					<div class="bsc_user_info">Welcome Back!</div>
				</div>
				<!-- 左侧菜单栏 -->
				<div class="bsc_menu">
					<!-- 一级菜单 -->
			        <ul id="bsc_menu_first" class="bsc_menu_first">
						<!-- 菜单展示区域 -->
					</ul>
					<!-- 右侧高亮边框 -->
					<div class="bsc_highlight_border"><div></div></div>
				</div>
			</div><!-- bsc_sidebar -->
			
			<!-- 右侧内容 -->
			<div class="bsc_content container-fluid"></div>
		</div><!-- bsc_main -->
		
	</div><!-- bsc_frame -->
	
	<script src="/js/jquery/jquery-1.11.1.min.js"></script>
	<script src="/bootstrap/3.3.0/js/bootstrap.js"></script>
	<script>
	/*------------从后台取到左侧菜单信息-----------*/
	var leftMenu = {% if leftMenu != empty %}{{ leftMenu | json_encode }}
		{% else %}{{ [] | json_encode }}{% endif %};
		
	</script>
	<script src="/bootstrap/jqueryConfirm/2.5.0/jquery-confirm.js"></script>
	<script src="/js/fcmsIndex/basic.js"></script>
	<script src="/js/fcmsIndex/accordion.js"></script>
	
</body>
</html>