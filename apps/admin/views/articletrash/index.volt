<!doctype html>
<html>
    <head>
        <link rel="stylesheet" href="/css/admin/base.css">
        <link rel="stylesheet" type="text/css" href="/bootstrap/3.3.0/css/bootstrap.min.css">
        <link rel="stylesheet"  href="/css/admin/font-awesome.min.css" >
        <link rel="stylesheet" href="/bootstrap/datetimepicker/bootstrap-datetimepicker.min.css">
        <link rel="stylesheet" href="/public/bootstrap/jqueryConfirm/2.5.0/jquery-confirm.css">
        <style>
            .operate {
                margin-right: 10px;
            }
            .operate:hover {
                cursor:pointer;
                color:green;
            }
		.skinimg i:hover{-webkit-animation: tada 1s .2s ease both;-moz-animation: tada 1s .2s ease both;}
		@-webkit-keyframes tada{
			0%{-webkit-transform:scale(1);}
			10%, 
			20%{-webkit-transform:scale(0.9) rotate(-3deg);}
			30%, 50%, 70%, 
			90%{-webkit-transform:scale(1.1) rotate(3deg);}
			40%, 60%, 
			80%{-webkit-transform:scale(1.1) rotate(-3deg);}
			100%{-webkit-transform:scale(1) rotate(0);}
		}
		@-moz-keyframes tada{
			0%{-moz-transform:scale(1);}
			10%, 
			20%{-moz-transform:scale(0.9) rotate(-3deg);}
			30%, 50%, 70%, 
			90%{-moz-transform:scale(1.1) rotate(3deg);}
			40%, 60%, 
			80%{-moz-transform:scale(1.1) rotate(-3deg);}
			100%{-moz-transform:scale(1) rotate(0);}
		}
		span.info{
				font-size: 14px;
				color:#95a5a6;
		}
		.dropdown-submenu {
            position: relative;
        }
        .dropdown-submenu > .dropdown-menu {
            top: 0;
            left: 100%;
            margin-top: -6px;
            margin-left: -1px;
            -webkit-border-radius: 0 6px 6px 6px;
            -moz-border-radius: 0 6px 6px;
            border-radius: 0 6px 6px 6px;
        }
        .dropdown-submenu:hover > .dropdown-menu {
            display: block;
        }
        .dropdown-submenu > a:after {
            display: block;
            content: " ";
            float: right;
            width: 0;
            height: 0;
            border-color: transparent;
            border-style: solid;
            border-width: 5px 0 5px 5px;
            border-left-color: #ccc;
            margin-top: 5px;
            margin-right: -10px;
        }
        .dropdown-submenu:hover > a:after {
            border-left-color: #fff;
        }
        .dropdown-submenu.pull-left {
            float: none;
        }
        .dropdown-submenu.pull-left > .dropdown-menu {
            left: -100%;
            margin-left: 10px;
            -webkit-border-radius: 6px 0 6px 6px;
            -moz-border-radius: 6px 0 6px 6px;
            border-radius: 6px 0 6px 6px;
        }
        i#recover_select{
			margin-right:10px;
        }
        i#recover_all,i#recover_select{
			cursor:pointer;
        }
        
        </style>
    </head>
    <body class="wrap">
    	
    	<!-- 恢复弹出框Modal -->
		<div class="modal fade" id="recoverModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog self_modal_dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						<h4 class="modal-title" id="myModalLabel">
							<span class="glyphicon glyphicon-question-sign"></span>
							<span class="modal_alert_info">您确定要恢复所选数据吗？</span>
						</h4>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default self_modal_btn" data-dismiss="modal">取消</button>
						<button type="button" id="modal_confirm" class="btn btn-primary self_modal_btn" onclick="recoverData()">确定</button>
					</div>
				</div>
			</div>
		</div>
    	
    	
        <ul class="nav nav-tabs" role="tablist">
            <li role="presentation" class="active"><a href="#articlesList">已删文章</a></li>
        </ul>
        
        <div class="tab-content" style="padding:20px 0px;">
            <div role="tabpannel" class="tab-pane active" id="userList">
                {% if page.items is defined and page.items is not empty %}
                <table class="table table-hover table-bordered">
                    <thead>
                    	<tr>
                    		<th colspan="7"></th>
                    		<th style="text-align:center;font-size:16px;width:100px;" class="skinimg">
	                    		<i class="glyphicon glyphicon-repeat" title="恢复本页中已选中文章" id="recover_select"></i>
	                    		<i class="glyphicon glyphicon-share-alt" title="恢复所有文章" id="recover_all"></i>
	                    	</th>
                    	</tr>
                        <tr>
                        	<th>序号</th>
                        	<th><input class="all_checkbox" type="checkbox"> 选择</th>
                        	<th>文章编号</th>
                            <th>文章标题</th>
                            <th>文章分类</th>
                            <th>发布日期</th>
                            <th>更新时间</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody id="self_content">
                        {% for i,item in page.items %}
                        <tr id="article{{item.id}}" data-catid="{{item.artcate.id}}">
                        	<td>{{ i + 1 }}</td>
                        	<td><input class="self_checkbox" type="checkbox" checkbox-id="{{ item.id | escape_attr }}" data-catid="{{item.artcate.id}}"></td>
                        	<td>{{ item.id | e }}</td>
                            <td>{{ item.title | e }}</td>
                            <td>{{ item.artcate.name | e }}</td>
                            <td>{% if false == item.uptime %} / {% else %}{{ item.uptime | e }} {% endif %}</td>
                            <td>{{ item.uptime | e }}</td>
                            <td data-id="{{ item.id | escape_attr }}" data-catid="{{item.artcate.id}}" class="skinimg" style="padding-left:2%;font-size:16px;" >
                                <i class="glyphicon glyphicon-repeat operate recover_one" title="恢复"></i>
                                {% if item.artcate.delsign is defined and 1 == item.artcate.delsign %}
                                	 <i class="glyphicon glyphicon-cog operate art_setting" title="设置"></i>
                                {% endif %}
                            </td>
                        </tr>
                        {% endfor %}
                    </tbody>
                </table>
                {% else %}
                <div style="height:150px;line-height:150px;text-align:center;">无已删除文章，请刷新重试！</div>
                {% endif %}
                
                <!-- 分页 -->
                {% if page.total_pages > 1 %}
                <nav class="text-right" >
                    <ul class="pagination pagination-sm" style="margin-top:0"> 
                        <li class="{% if page.current == 1 %}disabled{% endif %}"><a href="/admin/articletrash/index/page/{{page.before}}" >&laquo;</a></li>
                        {% if  1 != page.current and 1 != page.before %}
                        <li><a href="/admin/articletrash/index">1</a></li>
                        {% endif %}
                        {% if page.before != page.current  %}
                        <li><a href="/admin/articletrash/index/page/{{ page.before }}"><span >{{ page.before }}</span></a></li>
                        {% endif %}
                        <li class="active"><a href="/admin/articletrash/index/page/{{ page.current }}"><span>{{ page.current }}</span></a></li>
                        {% if page.next != page.current %}
                        <li><a href="/admin/articletrash/index/page/{{ page.next }}">{{ page.next }}</a></li>
                        {% endif %}
                        {% if page.next  < page.last - 1 %}
                        <li><a>...</a></li>
                        {% endif %}
                        {% if page.last != page.next %}
                        <li><a href="/admin/articletrash/index/page/{{ page.last }}">{{ page.last }}</a></li>
                        {% endif %}
                        <li class="{% if page.current == page.last %}disabled{% endif %}"><a href="/admin/articletrash/index/page/{{page.next}}" >&raquo;</a></li>

                    </ul>
                </nav>
                {% endif %}
            </div>
        </div>
        <div class="alert alert-danger text-center col-xs-2" style="display:none;margin-left: 40%;">
            <span>删除失败</span>
        </div>
        
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" style="margin-top:20%">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
	 			<div class="modal-header">
        			<button type="button" class="close" data-dismiss="modal" aria-label="Close">
        				<span aria-hidden="true">&times;</span>
        			</button>
        		</div>
		      <div class="modal-body">
		       <div class="progress">
				  <div class="progress-bar progress-bar-success progress-bar-striped" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width:40%">
				    <span class="sr-only">40% Complete (success)</span>
				  </div>
				</div>
		      </div>
		    </div>
		  </div>
		</div>
		
		<div style="left:30%;margin-left:-15px;margin-top:-15px;position:absolute;top:50%;display:none;" class="text-center col-xs-4">
          	<div class="alert alert-dismissable ">
              <h4><i class="glyphicon glyphicon-info-sign"></i> 提示信息!</h4>
              <p id="dis_message"></p>
            </div>
    	</div>
    	
    	<div class="modal fade" id="setting" tabindex="-1">
		  <div class="modal-dialog" role="document" style="width:400px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 class="modal-title" id="myModalLabel">分类配置</h4>
				</div>
				<div class="modal-body">
					<div class="form-group has-feedback">
                        <label class="control-label">分类名:</label>
                        <input class="form-control" type="text" id="catname" name="catname"/>
                        <input type="hidden" id="catid" name="catid" />
                    </div>
				</div>
				<div class="modal-footer" style="border:none;">
					<button type="button" class="btn btn-primary" id="art_category_recover" style="width:70px">确认</button>
					<button type="button" class="btn btn-default" data-dismiss="modal" style="width:70px">取消</button>
				</div>
			</div>
		</div>
	</div>
		
<script src="/js/jquery/jquery-1.11.1.min.js"></script>
<script src="/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src="/js/admin/static/optStatic.js"></script>
<script src="/bootstrap/jqueryConfirm/2.5.0/jquery-confirm.js"></script>
<script src="/bootstrap/datetimepicker/bootstrap-datetimepicker.min.js"></script>
<script src="/bootstrap/datetimepicker/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script>
var page = <?php if( isset( $page ) && !empty( $page ) ) echo $page->current; else echo 0; ?>;

var key = "<?php echo $this->security->getTokenKey();?>";
var token = "<?php echo $this->security->getToken();?>";

var dataId = '';
var dataCatIds = '';
$( 'i.recover_one' ).click( function(){
 	dataId = parseInt( $( this ).parents( 'td.skinimg' ).attr( "data-id" ) );
 	dataCatIds = parseInt( $( this ).parents( 'td.skinimg' ).attr( "data-catid" ) );
 	$( '#recoverModal' ).modal( 'toggle' );
} );
$( 'i#recover_select' ).click( function(){
	dataId = '';
	dataCatIds = '';
	$( "input.self_checkbox" ).each( function( index ){
		if( true == $( this ).prop( 'checked' ) ){
			dataId += $( this ).attr( 'checkbox-id' ) + ',';
			dataCatIds += $( this ).attr( 'data-catid' ) + ',';
		}
	} );
	$( '#recoverModal' ).modal( 'toggle' );
} );
	
/*----------------单篇文章恢复-----------------*/
function recoverData()
{
	if( !dataId )
	{
		alert( '参数错误！' );
		return;
  	}
	else
	{
	    var data = '&catids=' + dataCatIds + '&ids=' + dataId + '&key=' + key + '&token=' + token;
  		//如果是数字，则恢复单条数据
  		if( $.isNumeric( dataId ) ){
  			var _this = $( 'td[ data-id=' + dataId + ' ]' );
  	        $.post( '/admin/articleTrash/recoverSelect', data, function( ret ){
  	            if( !ret.status )
  	            {
  	            	success( ret.msg );
  	                $( _this ).parents( 'tr' ).remove();
  	            }
  	            else
  	            {
  					error( ret.msg );
  					var iLen = ret.optids.length;
  					for( var i=0; i<iLen; ++i )
					{
  						$( '#article' + ret.optids[i] ).addClass( 'danger' );
					}
  	            }
  	            $( '#recoverModal' ).modal( 'hide' );
  	            key = ret.key;
  	            token = ret.token;
  	        }, 'json' ).error( function(){ //网络不通
  	            error( '网络不通' );
  			} );
  		}
  		else
  		{//如果不是数字，则是恢复选中的文章
			$.post( '/admin/articleTrash/recoverSelect', data, function( ret ){
				if( !ret.status )
				{
  	            	var ids = dataId.split( ',' );
  					ids.pop();
  					for( var i = 0; i < ids.length; i++ ){
  						$( 'td[ data-id=' + ids[ i ] + ' ]' ).parents( 'tr' ).remove();
  					}
  					success( ret.msg );
  	            }
				else
  	            {
  					error( ret.msg );
  					var iLen = ret.optids.length;
  					for( var i=0; i<iLen; ++i )
					{
  						$( '#article' + ret.optids[i] ).addClass( 'danger' );
					}
  	            }
  	            $( '#recoverModal' ).modal( 'hide' );
  	            key = ret.key;
  	            token = ret.token;
            }, 'json' ).error( function(){ //网络不通
                error( '网络不通' );
			} );
  		}
	}
}
$( function(){
	/*----------------所有文章恢复-----------------*/
	$( '#recover_all' ).click( function(){
		$.confirm( { title: '是否恢复所有文章?', confirm: function(){
			var params = '&type=all&key=' + key + '&token=' + token;
			$.post( '/admin/articleTrash/recoverSelect', params, function( ret ){
                if( !ret.status )
                {
                    var iLens = ret.optids.length;
                    if( iLens > 0 )
                    {
                   		for( var i=0; i<iLens; i++ ){
                   			$( '#article' + ret.optids[i] ).remove();
              			}
                   	}
                }
                else
               {
                	error( ret.msg );
               		var iLens = ret.optids.length;
                    if( iLens > 0 )
                    {
                   		for( var i=0; i<iLens; i++ ){
                   			$( '#article' + ret.optids[i] ).addClass( 'danger' );
              			}
                   	}
               	}
                key = ret.key;
                token = ret.token;
            }, 'json').error( function(){ //网络不通
                error( '网络不通' );
			} );
		} } );
	} );
	
   	/*----------------搜索框内容填充---------------*/
   	$( 'ul.multi-level' ).find( 'a' ).each( function(){
	  	$( this ).click( function(){
			var cat_id = $( this ).parent( 'li' ).attr( 'data-id' );
			var cat_name = $( this ).html();
		  	$( '#s_catid' ).val( cat_id );
		  	$( '#cat_name' ).html( cat_name );
	  	} );
  	 } );
   
   	/*----------------时间插件-----------------*/
  	 $( '#s_pubtime' ).datetimepicker( {
		language: 'zh-CN',
	    autoclose: true,
	    todayBtn: true,
	    pickerPosition: "bottom-right",
	    minView:'month',
	 	startView:3,
	    format: 'yyyy-mm-dd',
	   	fontAwesome:true,
	} );
   	
   	$(  'input.all_checkbox').click(function(){
   		if( true == $( this ).prop( 'checked' ) )
   			$( 'table.table tbody' ).find( 'input.self_checkbox' ).prop( 'checked' , true );
   		else
   			$( 'table.table tbody' ).find( 'input.self_checkbox' ).prop( 'checked' , false );
   	});
   	
   	$( 'i.art_setting' ).click(function(){
   		var catId = $( this ).parent( 'td' ).attr( 'data-catid' );
   		if( !catId )
   		{
   			error( '参数错误,请刷新后再试...' );
   			return false;
   		}
   		$( '#setting' ).modal( 'show' );
   		$.get( '/admin/articletrash/getCatId/id/' + catId, function( ret ){
			if( 1 != ret.state )
			{
				$( 'input#catname' ).val( ret.title );
				$( 'input#catid' ).val( ret.optid );
			}
			else
				error( ret.msg );
		
		}, 'json' );
   	});
   	
   	$( 'button#art_category_recover' ).click(function(){
   		var catname = $( 'input#catname' ).val();
		var optid  = $( 'input#catid' ).val();
   		if( !optid )
		{
   			error( '对不起,参数获取失败,请刷新后再试...' );
   			return false;
		}
		
		var objParams = { 'name':catname,'id':optid, 'key':key, 'token':token };
   		$.post( '/admin/articletrash/recoveryCate' , objParams, function( ret ){
   			$( '#setting' ).modal( 'hide' );
   			if( 1 != ret.state )
			{
				$( '#self_content tr' ).each(function(){
					if( ret.optid == $(this).attr( 'data-catid' ) )
					{
						$( this ).removeClass( 'danger' );
						$( this ).find( 'td i.art_setting' ).remove();
					}
				});
			}
   			else
			{
   				error( ret.msg );
			}
   			key = ret.key;
   			token = ret.token;
   		}, 'json' );
   	});
} );

/*----------------输出正确信息-----------------*/
function success( msg ){
	$( '#dis_message' ).text( msg );
	$( '.alert' ).removeClass( 'alert-danger' ).addClass( 'alert-success' );
	$( '.alert' ).parent( 'div' ).show().fadeOut( 3000 );
}
/*----------------输出错误信息-----------------*/
function error( msg ){
	$( '#dis_message' ).text( msg );
	$( '.alert' ).removeClass( 'alert-success' ).addClass( 'alert-danger' );
	$( '.alert' ).parent( 'div' ).show().fadeOut( 8000 );
}

</script>
</body>
</html>