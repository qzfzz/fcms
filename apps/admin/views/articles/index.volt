<!doctype html>
<html>
    <head>
        <link rel="stylesheet" href="/css/admin/base.css">
        <link rel="stylesheet" type="text/css" href="/bootstrap/3.3.0/css/bootstrap.min.css">
        <link rel="stylesheet"  href="/css/admin/font-awesome.min.css">
        <link rel="stylesheet" href="/bootstrap/datetimepicker/bootstrap-datetimepicker.min.css">
        <link rel="stylesheet" type="text/css" href="/bootstrap/toastr/toastr.min.css">
        <link href="/nprogress/nprogress.css" rel="stylesheet" />
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
	            left: -100%;
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
	        
	        #s_name{
				width:110px;
				display:inline-block;
				box-shadow:none;
				border-right:none;
				text-align:center;
	        }

	        
        </style>
    </head>
    <body class="wrap">
    	
    	<!-- 删除弹出框Modal -->
		<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<div class="modal-dialog self_modal_dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						<h4 class="modal-title" id="myModalLabel">
							<span class="glyphicon glyphicon-question-sign"></span>
							您确定要删除这条数据吗？
						</h4>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default self_modal_btn" data-dismiss="modal">取消</button>
						<button type="button" id="modal_confirm" class="btn btn-primary self_modal_btn" onclick="deleteData()">确定</button>
					</div>
				</div>
			</div>
		</div>
    	
        <ul class="nav nav-tabs" role="tablist">
            <li role="presentation" class="active"><a href="#articlesList">文章</a></li>
            <li role="presentation"><a href="/admin/articles/add">添加文章</a></li>
            
            <!-- 文章检索 -->
            <li style="float:right;">
           			<div class="input-group">
			            <input type="text" name="name" id="s_name" value="{%if art_title != false %}{{ art_title | e }}{% endif %}" class="form-control" placeholder="文章标题" aria-describedby="search_artical">
			            
				        <div class="dropdown" style="display:inline-block;">
				            <a id="dLabel" role="button" data-toggle="dropdown" class="btn btn-default" data-target="#" style="color:#999;border-left:none;border-top-left-radius:0em;border-bottom-left-radius:0em;">
				                <span id="cat_name" style="display:inline-block;width:122px;">{% if cat_name is defined and false != cat_name %}{{ cat_name | e }}{% else %}文章分类{% endif %}</span> 
				                <span class="caret"></span>
				            </a>
				            <ul class="dropdown-menu multi-level" role="menu" aria-labelledby="dropdownMenu">
				            	<li data-id="0" class=""><a href="javascript:;" tabindex="-1">全部分类</a></li>
				            {% for item in categorys %}
				                <li data-id="{{ item[ 'id' ] | e }}" class="{% if item['sub'] is defined and false != item['sub'] %}dropdown-submenu{% endif %}">
				                    <a tabindex="-1" href="javascript:;">{{ item['name'] | e }}</a>
				                    {% if item['sub'] is defined and false != item['sub'] %}
				                    <ul class="dropdown-menu">
				                    	{% for ch in item['sub'] %}
				                        <li data-id="{{ ch[ 'id' ] | e }}" class="{% if ch['sub'] is defined and false != ch['sub'] %}dropdown-submenu{% endif %}">
				                            <a href="javascript:;">{{ ch['name'] | e }}</a>
				                            {% if ch['sub'] is defined and false != ch['sub'] %}
				                            <ul class="{% if ch['sub'] is defined and false != ch['sub'] %}dropdown-menu{% endif %}">
				                            	{% for th in ch['sub'] %}
				                                <li data-id="{{ th[ 'id' ] | e }}"><a href="javascript:;">{{ th[ 'name' ] | e }}</a></li>
				                                {% endfor %}
				                            </ul>
				                            {% endif %}
				                        </li>
				                        {% endfor %}
				                    </ul>
				                    {% endif %}
				                </li>
				                {% endfor %}
				            </ul>
				        </div>
			            
			            <input type="hidden" id="s_catid" value="{%if art_cate != false %}{{art_cate}}{% endif %}">
	        			<span class="btn btn-default" style="display:inline-block" onclick="getSearchList();"><span class="glyphicon glyphicon-search"></span></span>
        			</div>
        	</li>
        </ul>
        
       <div class="tab-content" style="padding:20px 0px;">
            <div role="tabpannel" class="tab-pane active" id="userList">
                {% if page.items is defined and page.items is not empty %}
                <table class="table table-hover table-bordered">
                    <thead>
                    	<tr>
                    		<th colspan="6"></th>
                    		<th style="text-align:center"><a href="javascript:void( 0 );" id="staticPart" style="text-decoration: none" title="对未静态化的页面生成静态化html文件，忽略已静态化过的页面"><i class="fa fa-file-text"></i> 继续静态化</a></th>
                    		<th style="text-align:center"><a href="javascript:void( 0 );" id="staticSite" style="text-decoration: none" title="对所有页面生成最新的静态化html文件"><i class="fa fa-file"></i> 全站静态化</a></th>
                    	</tr>
                        <tr>
                        	<th>序号</th>
                        	<th>文章编号</th>
                            <th>文章标题</th>
                            <th>文章分类</th>
                            <th>是否置顶</th>
                            <th>发布日期</th>
                            <th>更新时间</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody id="self_content">
                        {% for i,item in page.items %}
                        <tr>
                        	<td>{{ i+1 }}</td>
                        	<td>{{ item.id | e }}</td>
                            <td><a href="/cms/index/detail/id/{{item.id | e}}" target="_blank" title="{{ item.title | e }}"><?php if( isset( $item->title ) ){ if( strlen( $item->title ) > 25 ) echo mb_substr( $item->title , 0 , 25, 'UTF-8' ) . '....'; else echo $item->title; } ?></a></td>
                            <td>{{ item.cat_name | e }}</td>
                            <td class="artTopHtml">{% if item.top %} 是 {% else %} 否 {% endif %}</td>
                            <td>{% if false == item.uptime %} / {% else %}{{ item.uptime | e }} {% endif %}</td>
                            <td>{{ item.uptime | e }}</td>
                            <td data-id = "{{ item.id | escape_attr }}" class="skinimg" style="padding-left:2%" >
                                <font size="4"><i class="glyphicon glyphicon-trash operate articlesDelete" title="删除"></i></font>
                                <a href="{{ url( 'admin/articles/edit?id=' ) }}{{ item.id | escape_attr }}"><font size="4"><i class="glyphicon glyphicon-pencil operate" title="修改"></i></font></a>
                                <font size="4"><i class="glyphicon glyphicon-file operate articlesStatics" title="静态化"></i></font>
                                {% if !item.top %}
                                <font size="4"><i class="glyphicon glyphicon-hand-up operate artTop" title="置顶文章"></i></font>
                                {% else %}
                                <font size="4"><i class="glyphicon glyphicon-hand-down operate artTop" title="取消置顶"></i></font>
                                {% endif %}
                            </td>
                        </tr>
                        {% endfor %}
                    </tbody>
                </table>
                {% else %}
                {% endif %}
                {% if page.total_pages > 1 %}
                <nav class="text-right" >
                    <ul class="pagination pagination-sm" style="margin-top:0"> 
                        <li class="{% if page.current == 1 %}disabled{% endif %}"><a href="/admin/articles/index/page/{{page.before}}/name/{{art_title}}/cid={{art_cate}}" >&laquo;</a></li>
                        {% if  1 != page.current and 1 != page.before %}
                        <li><a href="/admin/articles/index/name/{{art_title}}/cid/{{art_cate}}">1</a></li>
                        {% endif %}
                        {% if page.before != page.current  %}
                        <li><a href="/admin/articles/index/page/{{ page.before }}/name/{{art_title}}/cid/{{art_cate}}/"><span >{{ page.before }}</span></a></li>
                        {% endif %}
                        <li class="active"><a href="/admin/articles/index/page/{{ page.current }}/name/{{art_title}}/cid/{{art_cate}}"><span>{{ page.current }}</span></a></li>
                        {% if page.next != page.current %}
                        <li><a href="/admin/articles/index/page/{{ page.next }}/name/{{art_title}}/cid/{{art_cate}}">{{ page.next }}</a></li>
                        {% endif %}
                        {% if page.next  < page.last - 1 %}
                        <li><a>...</a></li>
                        {% endif %}
                        {% if page.last != page.next %}
                        <li><a href="/admin/articles/index/page/{{ page.last }}/name/{{art_title}}/cid/{{art_cate}}">{{ page.last }}</a></li>
                        {% endif %}
                        <li class="{% if page.current == page.last %}disabled{% endif %}"><a href="/admin/articles/index/page/{{page.next}}/name/{{art_title}}/cid/{{art_cate}}" >&raquo;</a></li>

                    </ul>
                </nav>
                {% endif %}
            </div>
        </div>
        <div class="alert alert-danger text-center col-xs-2" style="display:none;margin-left: 40%;">
            <span>删除失败</span>
        </div>
        
		<div class="modal fade" id="confirmModal" tabindex="-1" role="dialog" style="margin-top:20%">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
	 			<div class="modal-header">
        			<button type="button" class="close" data-dismiss="modal" aria-label="Close">
        				<span aria-hidden="true">&times;</span>
        			</button>
        			 <h4 class="modal-title">确认要进行全站静态化?</h4>
        		</div>
		      <div class="modal-body">
		       	<font size="3" style="padding-left:5%"><i class="fa fa-info-circle"></i></font>
		       	<span class="info">全站静态化：所有静态缓存文件将重新生成,之前生成的静态文件将全部被覆盖.</span>
		       	
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default" data-dismiss="modal">否</button>
		        <button type="button" class="btn btn-primary" id="continueBtn">是</button>
		      </div>
		    </div>
		  </div>
		</div>
		
	<div style="left: 30%;margin-left: -15px;margin-top: -15px;position: absolute;top: 15%; display:none;" class="text-center col-xs-4">
         	<div class="alert alert-dismissable ">
             <h4><i class="glyphicon glyphicon-info-sign"></i> 提示信息!</h4>
             <p id="dis_message"></p>
           </div>
   	</div>
		
<script src="/js/jquery/jquery-1.11.1.min.js"></script>
<script src="/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src="/js/admin/static/optStatic.js"></script>
<script src="/bootstrap/datetimepicker/bootstrap-datetimepicker.min.js"></script>
<script src="/bootstrap/datetimepicker/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script src="/bootstrap/toastr/toastr.min.js"></script>
<script src="/nprogress/nprogress.js"></script>
<script>

var page = <?php if( isset( $page ) && !empty( $page ) ) echo $page->current; else echo 0; ?>;
var key = "<?php echo $this->security->getTokenKey();?>";
var token = "<?php echo $this->security->getToken();?>";

/*--------------单条内容的删除-----------------*/
var dataId = 0;
$( 'i.articlesDelete' ).click( function(){
 	dataId = parseInt( $( this ).parents( 'td.skinimg' ).attr( 'data-id' ) );
 	$( '#deleteModal' ).modal( 'toggle' );
} );

function deleteData(){
	if( !dataId ){
		toastr.error( '参数错误！' );
		return;
  	}else{
  		var data = { 'id' : dataId, 'key' : key, 'token' : token };
  	    var _this = $( "td[data-id=" + dataId + "]" );
  	    $.post( '/admin/articles/delete', data, function( ret ){
  	        if( 1 != ret.status ){
  	        	success( ret.msg );
  	        	$( _this ).parents( 'tr' ).remove();
  	        }else{
  				error( ret.msg );
  	        }
            $( '#deleteModal' ).modal( 'hide' );
  	      	key = ret.key;
  	    	token = ret.token;
  	    }, 'json' ).error( function(){
  	        error( '网络不通' );
  	    } );
  	}
}
/*--------------单条内容的删除结束-----------------*/

$( function(){
   
   /*----------------搜索框内容填充-----------------*/
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
	    format: 'yyyy-mm-dd hh:ii:ss',
	   	fontAwesome:true,
	} );
   
   $( 'input#s_name' ).keydown(function( event ){
	   if( 13 == event.keyCode )
		   getSearchList();
   });
   
   $( 'i.artTop' ).click(function(){
	   var optId = $( this ).parents( 'td' ).attr( 'data-id' );
	   if( !optId )
	   {
		   toastr.error( '参数错误，请重新加载后再试...' );
		   return false;
	   }
	   else
	   {
		   var $_this = $( this );
	   		$.get( '/admin/articles/setTops/id/' + optId, function( ret ){
	   			if( 1 != ret.state )
   				{
	   				toastr.success( ret.msg );
	   				if( !ret.optType )
	   	   			{
	   					$_this.parents( 'tr' ).find( 'td.artTopHtml' ).html( '否' );
	   					$_this.removeClass( 'glyphicon-hand-down' ).addClass( 'glyphicon-hand-up' );
	   					$_this.attr( 'title' , '置顶文章' );
	   	   			}
	   	   			else
	   	   			{
	   	   				$_this.parents( 'tr' ).find( 'td.artTopHtml' ).html( '是' );
	   	   				$_this.removeClass( 'glyphicon-hand-up' ).addClass( 'glyphicon-hand-down' );
	   	   				$_this.attr( 'title' , '取消置顶' );
	   	   			}
   				}
	   			else
   				{
   					toastr.error( ret.msg );
   				}
	   		}, 'json' );
	   }
   });
   
} );

/*----------------输出正确信息-----------------*/
function success( msg ){
	$( '.alert span' ).text( msg );
	$( '.alert' ).removeClass( 'alert-danger' ).addClass( 'alert-success' );
	$( '.alert' ).show().fadeOut( 3000 );
}
/*----------------输出错误信息-----------------*/
function error( msg ){
	$( '.alert span' ).text( msg );
	$( '.alert' ).removeClass( 'alert-success' ).addClass( 'alert-danger' );
	$( '.alert' ).show().fadeOut( 3000 );
}

/*----------------获得搜索文章列表-----------------*/
function getSearchList(){
	var url = '/page/1';
	var s_name = $( '#s_name' ).val();
	var s_cateid = $( '#s_catid' ).val();
	if( false != s_name && s_name.length > 0 )
		url += '/name/' + s_name;
	if( false != s_cateid )
		url += '/cid/' + s_cateid;
	
	location.href='/admin/articles/index' + url;
}
</script>
</body>
</html>
