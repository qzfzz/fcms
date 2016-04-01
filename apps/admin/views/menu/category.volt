<!doctype html>
<html>
    <head>
        <link rel="stylesheet" href="/css/admin/base.css">
        <link rel="stylesheet" href="/bootstrap/3.3.0/css/bootstrap.min.css">
        <link rel="stylesheet"  href="/css/admin/font-awesome.min.css" >
        <link rel="stylesheet" type="text/css" href="/bootstrap/toastr/toastr.min.css">
        <style>
            .fa, .glyphicon {
                margin-right:15px;
            }
            tr.first .fa-plus-square-o, tr.first .fa-mins {
                margin-right:10px;
            }
            tr.second, tr.third {
                display:none;
            }
            tr.second .fa-plus-square-o,  tr.second .fa-minus-square-o {
                margin-left:20px;
            }
            tr.third .fa-minus-square-o {
                margin-left:40px;
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
            <li role="presentation" ><a href="/admin/menu/frontend">菜单管理</a></li>
            <li role="presentation" class="active"><a href="#categoryList">菜单分类</a></li>
        </ul>
        <div class="tab-content" style="padding:20px 0px;">
            <div role="tabpannel" class="tab-pane active" id="categoryList">
                <table class="table table-hover table-bordered">
                    <thead>
                    	<tr>
                    		<th colspan="5"></th>
                    		<th style="text-align:center"><a href="/admin/menu/addCategory"><i class="fa fa-plus-square" title="添加分类"> 添加分类</i></a></th>
                    	</tr>
                        <tr>
                            <th>序号</th>
                            <th>分类编号</th>
                            <th>分类名称</th>
                            <th>描述</th>
                            <th>上一次操作时间</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    {% if page.items is defined and page.items is not empty %} 
                    <tbody>
                        {% for i,item in page.items %}
                        	<tr id="cate{{item.id}}">
                        		<td style="text-align:center">{{ i+1 }}</td>
                        		<td style="text-align:center">{{ item.id }}</td>
                        		<td style="text-align:center">{{ item.name }}</td>
                        		<td style="text-align:center" id="descr_{{item.id}}">{{ item.descr }}</td>
                        		<td style="text-align:center">{% if item.uptime is defined %}{{ item.uptime }}{% else %}{{item.addtime }}{% endif %}</td>
                        		<td data-id = "{{ item.id | escape_attr }}" class="skinimg" style="padding-left:4%">
	                                <font size="4"><i class="glyphicon glyphicon-trash operate sensDelete" title="删除"></i></font>
	                                <a href="/admin/menu/upcmenus/id/{{item.id}}"><font size="4"><i class="glyphicon glyphicon-pencil operate sensEditer" title="修改"></i></font></a>
                           	 	</td>
                        	</tr>
                        {% endfor %}
                    </tbody>
                    {% endif %}
                </table>
                {% if page.total_pages > 1 %}
                <nav class="text-right" >
                    <ul class="pagination pagination-sm" style="margin-top:0"> 
                        <li class="{% if page.current == 1 %}disabled{% endif %}"><a href="{{ url( '/admin/menu/category?page=' ) }}{{page.before}}" >&laquo;</a></li>
                        {% if  1 != page.current and 1 != page.before %}
                        <li><a href="{{ url( '/admin/menu/category') }}">1</a></li>
                        {% endif %}
                        {% if page.before != page.current  %}
                        <li><a href="{{ url( '/admin/menu/category?page=') }}{{ page.before }}"><span >{{ page.before }}</span></a></li>
                        {% endif %}
                        <li class="active"><a href="{{ url( '/admin/menu/category?page=') }}{{ page.current }}"><span >{{ page.current }}</span></a></li>
                        {% if page.next != page.current %}
                        <li><a href="{{ url( '/admin/menu/category?page=') }}{{ page.next }}">{{ page.next }}</a></li>
                        {% endif %}
                        {% if page.next  < page.last - 1 %}
                        <li><a>...</a></li>
                        {% endif %}
                        {% if page.last != page.next %}
                        <li><a href="{{ url( '/admin/menu/category?page=') }}{{ page.last }}">{{ page.last }}</a></li>
                        {% endif %}
                        <li class="{% if page.current == page.last %}disabled{% endif %}"><a href="{{ url( '/admin/menu/category?page=' ) }}{{page.next}}" >&raquo;</a></li>
                    </ul>
                </nav>
                {% endif %}
            </div>
        </div>
        <div class="alert text-center col-xs-2" style="display:none;margin-left:40%;">
            <span id="dis_message">删除失败</span>
        </div>
        <script src="/js/jquery/jquery-1.11.1.min.js"></script>
        <script src="/bootstrap/3.3.0/js/bootstrap.min.js"></script>
        <script src="/bootstrap/toastr/toastr.min.js"></script>
        
        <script type="text/javascript">
		
		var key = "<?php echo $this->security->getTokenKey();?>";
        var token = "<?php echo $this->security->getToken();?>";
        
		/*--------------单条内容的删除-----------------*/
		var dataId = 0;
		$( 'i.sensDelete' ).click( function(){
         	dataId = parseInt( $( this ).parent().parent().attr( "data-id" ) );
         	$( '#deleteModal' ).modal( 'toggle' );
        } );
         
        function deleteData(){
        	if( !dataId ){
        		alert( '参数错误！' );
        		return;
          	}else{
          		var data = { 'id' : dataId, 'key' : key, 'token' : token };
          	    var _this = $( "td[data-id=" + dataId + "]" );
          	    $.post( '/admin/menu/delete', data, function( ret ){
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
        </script>
    </body>
</html>