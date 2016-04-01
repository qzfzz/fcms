<!doctype html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="chrome=1,IE=edge" />
<meta name="renderer" content="webkit">
<link rel="stylesheet" href="/css/admin/base.css">
<link rel="stylesheet" href="/bootstrap/3.3.0/css/bootstrap.min.css">
<style>
body {
	font-family: "Arial", "微软雅黑", sans-serif;
}

.num {
	font-size: 20px;
	margin: 0 5px;
}

.glyphicon{
	margin-right: 5px;
}
.welcome_info{
	padding:10px 15px;
	font-size:16px;
	background-color:#DFF0D8;
	margin-bottom:10px;
	border:1px solid #C6DBBC;
	border-radius:3px;
}
</style>
</head>
<body class="wrap">
<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">

	<div class="welcome_info">欢迎您使用FCMS内容管理系统 (v1.0)，尽情感受飞一般的速度！</div>

	
	<div class="panel panel-warning">
		<div class="panel-heading" role="tab" id="headingTwo">
			<h4 class="panel-title"> 系统信息  </h4>
		</div>
		<div id="collapseTwo" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingTwo">
			<div class="panel-body">
				<table class="table">
			<tbody>
				<tr>
					<td>操作系统</td>
					<td><?php echo $this->sysinfo->getos(); ?></td>
				</tr>
				<tr>
					<td>运行环境</td>
					<td><?php echo $this->sysinfo->getevn(); ?></td>
				</tr>
				<tr>
					<td>PHP版本</td>
					<td><?php echo $this->sysinfo->getphpversion(); ?></td>
				</tr>
				<tr>
					<td>PHP运行方式</td>
					<td><?php echo $this->sysinfo->getphprunway(); ?></td>
				</tr>
				<tr>
					<td>MYSQL版本</td>
					<td> <?php echo $this->sysinfo->getsqlversion(); ?> </td>
				</tr>
				<tr>
					<td>程序版本</td>
					<td><?php echo $this->sysinfo->getcmsversion(); ?></td>
				</tr>
				<tr>
					<td>上传附件限制</td>
					<td><?php echo $this->sysinfo->getuploadlimit(); ?></td>
				</tr>
				<tr>
					<td>执行时间限制</td>
					<td><?php echo $this->sysinfo->getexecutelimit(); ?></td>
				</tr>
				<tr>
					<td>剩余空间大小</td>
					<td><?php echo $this->sysinfo->getsurplusspace(); ?></td>
				</tr>
			</tbody>
        </table>
      </div>
    </div>
  </div>
	<div class="panel panel-info">
		<div class="panel-heading" role="tab" id="headingThree">
			<h4 class="panel-title"> 开发团队 </h4>
		</div>
		<div id="collapseThree" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingThree">
			<div class="panel-body">
				<p>
		      		<span>产品策划:</span>
		      		<span style="margin-left:1em;">钱志锋</span>
	    		</p>
	      		<p>
		      		<span>开</span><span style="margin-left:2em;">发:</span>
		      		<span style="margin-left:1em;">黄奉灿 牛志伟 钱志锋 田涛 周立文</span>
	      		</p>
			</div>
		</div>
	</div>
  
	<div class="panel panel-danger">
		<div class="panel-heading" role="tab" id="headingThree">
			<h4 class="panel-title">  鸣谢 </h4>
		</div>
    	<div id="contributor" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingThree">
			<div class="panel-body">云锋公司其他默默的奉献者</div>
		</div>
	</div>
  
</div>
</body>
<script src="/js/jquery/jquery-1.11.1.min.js"></script>
<script src="/bootstrap/3.3.0/js/bootstrap.min.js"></script>
</html>