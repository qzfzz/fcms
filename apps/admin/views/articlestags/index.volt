<!doctype html>
<html>
    <head>
        <link rel="stylesheet" href="/css/admin/base.css">
        <link rel="stylesheet" type="text/css" href="/bootstrap/3.3.0/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="/bootstrap/toastr/toastr.min.css">
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
							<span class=" glyphicon glyphicon-question-sign"></span>
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
            <li role="presentation" class="active"><a href="#tagsList">Tags 列表</a></li>
        </ul>
        <div class="input-group input-group-sm col-xs-2 pull-right" style="margin-top:-35px;">
			<input id="searchKey" class="form-control" type="text" placeholder="输入标签名或文章标题">
			<div id="search" class="input-group-addon">
				 <i class="glyphicon glyphicon-search" title="点击查询" style="cursor:pointer"></i>
			</div>
		</div>
        <div class="tab-content" style="padding:20px 0px;">
            <div role="tabpannel" class="tab-pane active" id="tagsList">
                {% if page.items is defined and page.items is not empty %}
                <table class="table table-hover table-bordered table-striped">
                    <thead>
                        <tr>
                        	<th>序号</th>
                        	<th>编号</th>
                            <th>标签名</th>
                            <th>文章编号</th>
                            <th>文章标题</th>
                            <th>创建时间</th>
                            <th>拼音</th>
                            <th>当前状态</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        {% for i,item in page.items %}
                        <tr id="tags{{item.id}}">
                        	<td style="text-align:center">{{i+1}}</td>
                            <td style="text-align:center">{{ item.id }}</td>
                            <td>{{ item.name | e }}</td>
                            <td>{% if item.aid is defined %}{{ item.aid }}{% endif %}</td>
                            <td>{% if item.articletags is not empty and item.articletags.title is defined  %}{{ item.articletags.title }}{% endif %}</td>
                            <td>{% if item.uptime is defined  %} {{item.uptime}} {% else %} {{ item.addtime }} {% endif %}</td>
                            <td>{{ item.pinyin | e }}</td>
                            <td style="text-align:center">{% if 1 != item.display %} 显示  {% else %} 不显示 {% endif %}</td>
                            <td data-id = "{{ item.id | escape_attr }}" class="skinimg" style="padding-left:2%">
                                <font size="4"><i class="glyphicon glyphicon-trash operate tagsDelete" title="删除"></i></font>
                                <a href="{{ url( '/admin/ArticlesTags/optionPage/id/' ) }}{{ item.id | escape_attr }}"><font size="4"><i class="glyphicon glyphicon-pencil operate"  title="修改"></i></font></a>
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
                        <li class="{% if page.current == 1 %}disabled{% endif %}"><a href="{{ url( '/admin/ArticlesTags/index?page=' ) }}{{page.before}}" >&laquo;</a></li>
                        {% if  1 != page.current and 1 != page.before %}
                        <li><a href="{{ url( '/admin/ArticlesTags/index') }}">1</a></li>
                        {% endif %}
                        {% if page.before != page.current  %}
                        <li><a href="{{ url( '/admin/ArticlesTags/index?page=') }}{{ page.before }}"><span >{{ page.before }}</span></a></li>
                        {% endif %}
                        <li class="active"><a href="{{ url( '/admin/ArticlesTags/index?page=') }}{{ page.current }}"><span >{{ page.current }}</span></a></li>
                        {% if page.next != page.current %}
                        <li><a href="{{ url( '/admin/ArticlesTags/index?page=') }}{{ page.next }}">{{ page.next }}</a></li>
                        {% endif %}
                        {% if page.next  < page.last - 1 %}
                        <li><a>...</a></li>
                        {% endif %}
                        {% if page.last != page.next %}
                        <li><a href="{{ url( '/admin/ArticlesTags/index?page=') }}{{ page.last }}">{{ page.last }}</a></li>
                        {% endif %}
                        <li class="{% if page.current == page.last %}disabled{% endif %}"><a href="{{ url( '/admin/ArticlesTags/index?page=' ) }}{{page.next}}" >&raquo;</a></li>

                    </ul>
                </nav>
                {% endif %}
            </div>
        </div>
        <div class="alert text-center col-xs-4" style="display:none;margin-left: 40%;">
            <span id="dis_message">删除失败</span>
        </div>
        <script src="/js/jquery/jquery-1.11.1.min.js"></script>
        <script src="/bootstrap/3.3.0/js/bootstrap.min.js"></script>
        <script src="/bootstrap/toastr/toastr.min.js"></script>
        <script type="text/javascript">

        /*--------------单条内容的删除-----------------*/
		var dataId = 0;
        $( 'i.tagsDelete' ).click( function(){
         	dataId = parseInt( $( this ).parents( 'td.skinimg' ).attr( "data-id" ) );
         	$( '#deleteModal' ).modal( 'toggle' );
        } );
        function deleteData()
        {
        	if( !dataId ){
        		toastr.error( '参数错误！' );
        		return;
          	}else{
          	    var _this = $( "td[data-id=" + dataId + "]" );
          	    $.get( '/admin/ArticlesTags/delete/id/' + dataId, function( ret ){
          	        if( 0 === parseInt( ret ) ){
          	        	success( 'Tag标记删除成功' );
          	            $( _this ).parents( 'tr' ).remove();
          	            $( '#deleteModal' ).modal( 'hide' );
          	        }else{
          				error( '操作失败,数据未找到' );
          	        }
          	    }, 'json' ).error( function(){
          	        error( '网络不通' );
          	    } );
          	}
        }
        
		$(function(){
			$( '#search' ).click(function(){
        		var keys = $( '#searchKey' ).val();
        		
        		if( keys )
        			var url = '/admin/articlestags/search/key/' + keys;
        		else
        			var url = '/admin/articlestags/search';
        		
        		$.get( url , function( ret ){
        			$( '#searchKey' ).val( ret.key );
        			if( 1 != ret.state )
        			{
        				$( '#tagsList table tbody' ).remove();
        				$( '#tagsList nav ul li' ).remove();
        				var iLen = ret.res.length;
        				if( iLen > 0 )
       					{
        					var strApp = '<tbody>';
	        				for( var i=0; i<iLen; i++ )
        					{
	        					if( false != ret.res[i].aid )
	        						var strAid = ret.res[i].aid;
	        					else
	        						var strAid = '';
	        					
	        					if( false != ret.res[i].title )
	        						var strAtitle = ret.res[i].title;
	        					else
	        						var strAtitle = '';
	        					
	        					if( ret.res[i].uptime )
	        						var strTime = ret.res[i].uptime;
	        					else
	        						var strTime = ret.res[i].addtime;
	        					
	        					if( 1 != ret.res[i].display )
	        						var strDis = '显示';
	        					else
	        						var strDis = '不显示';
	        					
	        					if( false != ret.res[i].pinyin )
	        						var strPinyin = ret.res[i].pinyin;
	        					else
	        						var strPinyin = '';
	        					
        						strApp += '<tr id="tags'+ ret.res[i].tid +'">' + 
        									'<td style="text-align:center">'+ parseInt( i+1 ) +'</td>' +
        									'<td style="text-align:center">'+ ret.res[i].tid +'</td>' +
        									'<td>'+ ret.res[i].name +'</td>' +
        									'<td>'+strAid+'</td>' +
        									'<td>'+ strAtitle +'</td>' +
        									'<td>'+ strTime +'</td>' +
        									'<td>'+ $.trim( strPinyin ) +'</td>' +
        									'<td style="text-align:center">'+ strDis +'</td>' +
        									'<td data-id = "'+ ret.res[i].tid +'" class="skinimg" style="padding-left:2%">'+
        											'<i class="glyphicon glyphicon-trash operate tagsDelete" title="删除"></i>'+
        	                                		'<a href="/admin/ArticlesTags/optionPage/id/'+ ret.res[i].tid +'"><i class="glyphicon glyphicon-pencil operate" title="修改"></i></a>'+
        									'</td>' +
        								'</tr>';
        					}
	        				strApp += '</tbody>';
	        				$( '#tagsList table' ).append( strApp );
       					}
        				else
        					location.reload();
        			}
        			else
       				{
        				$( '#dis_message' ).html( ret.msg );
    					$( '#dis_message' ).parent().addClass( 'alert-danger' ).removeClass( 'alert-success' );
    					$( '#dis_message' ).parent().fadeIn( 500 );
    					setTimeout( function(){
    						$( '#dis_message' ).parent().fadeOut( 1000 );
    					}, '3000' );
       				}
        		}, 'json');
        	 });
        	 //Enter or Ctrl + Enter 出发查找事件
        	 $( '#searchKey' ).keyup(function( event ){
        		if( 13 == event.keyCode || ( event.ctrlKey && 13 == event.keyCode ) )
        		{
        			$( '#search' ).trigger( 'click' );
        		}
        	 });
         });
        
		/*----------------输出正确信息-----------------*/
		function success( msg )
		{
         	$( '.alert span' ).text( msg );
         	$( '.alert' ).removeClass( 'alert-danger' ).addClass( 'alert-success' );
         	$( '.alert' ).show().fadeOut( 3000 );
		}
		/*----------------输出错误信息-----------------*/
		function error( msg )
		{
			$( '.alert span' ).text( msg );
         	$( '.alert' ).removeClass( 'alert-success' ).addClass( 'alert-danger' );
         	$( '.alert' ).show().fadeOut( 3000 );
		}
         
        </script>
    </body>
</html>