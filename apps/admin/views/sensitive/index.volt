<!doctype html>
<html>
    <head>
        <link rel="stylesheet" href="/css/admin/base.css">
        <link rel="stylesheet" type="text/css" href="/bootstrap/3.3.0/css/bootstrap.min.css">
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
    
        <ul class="nav nav-tabs" role="tablist">
            <li role="presentation" class="active"><a href="#sensitiveList">敏感词管理</a></li>
            <li role="presentation"><a href="/admin/sensitive/add">添加敏感词</a></li>
        </ul>
        
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
		
        <div class="tab-content" style="padding:20px 0px;">
            <div role="tabpannel" class="tab-pane active" id="sensitiveList">
                {% if page.items is defined and page.items is not empty %}
                <table class="table table-hover table-bordered table-striped">
                    <thead>
                        <tr>
                        	<th>序号</th>
                        	<th>编号</th>
                            <th>敏感词</th>
                            <th>创建时间</th>
                            <th>替换设置 ( 默认为 {{ default }} )</th>
                            <th>创建人</th>
                            <th>管理操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        {% for i,item in page.items %}
                        <tr id="sensitive{{item.id}}">
                        	<td style="text-align:center">{{i+1}}</td>
                            <td style="text-align:center">{{ item.id }}</td>
                            <td style="text-align:center">{{ item.word | e }}</td>
                            <td>{% if item.uptime is defined  %} {{item.uptime}} {% else %} {{ item.addtime }} {% endif %}</td>
                            <td class="replaceword">{{ item.rword | e }}</td>
                            <td style="text-align:center">{{ item.adminuser.name}}</td>
                            <td data-id = "{{ item.id | escape_attr }}" class="skinimg" style="padding-left:2%">
                                <font size="4"><i class="glyphicon glyphicon-trash operate sensDelete" title="删除"></i></font>
                                <font size="4"><i class="glyphicon glyphicon-pencil operate sensEditer" title="修改"></i></font>
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
                        <li class="{% if page.current == 1 %}disabled{% endif %}"><a href="{{ url( '/admin/sensitive/index?page=' ) }}{{page.before}}" >&laquo;</a></li>
                        {% if  1 != page.current and 1 != page.before %}
                        <li><a href="{{ url( '/admin/sensitive/index') }}">1</a></li>
                        {% endif %}
                        {% if page.before != page.current  %}
                        <li><a href="{{ url( '/admin/sensitive/index?page=') }}{{ page.before }}"><span >{{ page.before }}</span></a></li>
                        {% endif %}
                        <li class="active"><a href="{{ url( '/admin/sensitive/index?page=') }}{{ page.current }}"><span >{{ page.current }}</span></a></li>
                        {% if page.next != page.current %}
                        <li><a href="{{ url( '/admin/sensitive/index?page=') }}{{ page.next }}">{{ page.next }}</a></li>
                        {% endif %}
                        {% if page.next  < page.last - 1 %}
                        <li><a>...</a></li>
                        {% endif %}
                        {% if page.last != page.next %}
                        <li><a href="{{ url( '/admin/sensitive/index?page=') }}{{ page.last }}">{{ page.last }}</a></li>
                        {% endif %}
                        <li class="{% if page.current == page.last %}disabled{% endif %}"><a href="{{ url( '/admin/sensitive/index?page=' ) }}{{page.next}}" >&raquo;</a></li>

                    </ul>
                </nav>
                {% endif %}
            </div>
        </div>
        
       	<div style="left: 30%;margin-left: -15px;margin-top: -15px;position: absolute;top: 50%; display:none;" class="text-center col-xs-4">
          	<div class="alert alert-dismissable ">
              <h4><i class="glyphicon glyphicon-info-sign"></i> 提示信息!</h4>
              <p id="dis_message"></p>
            </div>
    	</div>
       
        <script src="/js/jquery/jquery-1.11.1.min.js"></script>
        <script src="/bootstrap/3.3.0/js/bootstrap.min.js"></script>
        <script type="text/javascript">
		
        /*--------------单条内容的删除-----------------*/
		var dataId = 0;
        $( 'i.sensDelete' ).click( function(){
         	dataId = parseInt( $( this ).parents( 'td.skinimg' ).attr( "data-id" ) );
         	$( '#deleteModal' ).modal( 'toggle' );
        } );
         
        function deleteData(){
        	if( !dataId ){
        		alert( '参数错误！' );
        		return;
          	}else{
          	    var _this = $( "td[ data-id=" + dataId + "]" );
				$.get( '/admin/sensitive/delete/id/' + dataId, function( ret ){
					switch ( parseInt( ret ) ){
						case 0:
							success( '删除成功' );
	          	            $( _this ).parents( 'tr' ).remove();
	          	            $( '#deleteModal' ).modal( 'hide' );
							break;
						case 1:
							error( '获取参数出错,请刷新后再试' );
							break;
						case 2:
							error( '删除失败,未找到该条信息' );
							break;
					}
          	    }, 'json' ).error( function(){
          	        error( '网络不通' );
          	    } );
          	}
        }
        /*--------------单条内容的删除结束-----------------*/
		$( function(){
	       	//点击编辑按钮 更改输入框输入
			$( 'i.sensEditer' ).click(function(){
				var id = $( this ).parent().parent( 'td' ).attr( 'data-id' );
                var target = $( '#sensitive' + id ).find( 'td.replaceword' );
				var oldReplace = $.trim( target.html() );
	       		var strType = '<div class="col-md-12"><div class="input-group input-group-sm"><input type="text" class="form-control" name="replace" value="'+oldReplace+'" /><input type="hidden" name="oldreplace" value="'+oldReplace+'" />';
	           	strType += '<span class="input-group-btn"><buttom class="btn btn-primary" type="button" onclick="saveChangeBtn( this, '+ id +' )" id="saveChange">确认</button></span></div></div>';
                
                if( ! target.find( '.col-md-12' ).length )
                {
                    target.empty();
                    target.html( strType );
                    target.find( 'input[type="text"]' ).focus();
                }
			} );
		} );
        
        var submitId = false;
		//点击保存
		function saveChangeBtn( item, id ){
			if( !submitId ){
				var strString = $( item ).parent().parent().find( 'input[name="replace"]' ).val();
				var strOldString = $( item ).parent().parent().find( 'input[name="oldreplace"]' ).val();
		       	 
				if( false == $.trim( strString ) || $.trim( strOldString ) == $.trim( strString ) ){
					$( '#dis_message' ).html( '您没有做任何修改' );
					 $( '#dis_message' ).parent().parent().addClass( 'alert-danger' ).removeClass( 'alert-success' );
					 $( '#dis_message' ).parent().parent().fadeIn( 500 );
					 setTimeout( function(){
					 	 $( '#dis_message' ).parent().parent().fadeOut( 1000 );
					 }, '2000' );
						
		       		 $( '#sensitive' + id ).find( 'td.replaceword' ).html( strOldString );
		       		 return;
		       	 }
		       	 
				submitId = true;
				$.get( '/admin/sensitive/replace/id/' + id +'/strreplace/' + strString, function( ret ){
					if( 1 != ret.state ){
						$( '#dis_message' ).html( ret.msg );
		       			$( '#dis_message' ).parent().parent().addClass( 'alert-success' ).removeClass( 'alert-danger' );
		   				$( '#dis_message' ).parent().parent().fadeIn( 500 );
		   				setTimeout( function(){
		   				 	$( '#dis_message' ).parent().parent().fadeOut( 1000 );
		   				}, '2000' );
		   				$( '#sensitive' + id ).find( 'td.replaceword' ).empty();
		   				$( '#sensitive' + id ).find( 'td.replaceword' ).html( ret.rword );
					}else{
		       			$( '#dis_message' ).html( ret.msg );
		       			$( '#dis_message' ).parent().parent().addClass( 'alert-danger' ).removeClass( 'alert-success' );
		   			 	$( '#dis_message' ).parent().parent().fadeIn( 500 );
		   				setTimeout( function(){
		   				 	$( '#dis_message' ).parent().parent().fadeOut( 1000 );
		   				}, '2000' );
		   				$( '#sensitive' + id ).find( 'td.replaceword' ).empty();
		   				$( '#sensitive' + id ).find( 'td.replaceword' ).html( strOldString );
					}
                    submitId = false;
				}, 'json');
			}
		}
		
		/*----------------输出正确信息-----------------*/
		function success( msg ){
			$( '.alert' ).parent( 'div' ).css( 'display', 'block' );
			$( '#dis_message' ).text( msg );
			$( '.alert' ).removeClass( 'alert-danger' ).addClass( 'alert-success' );
			$( '.alert' ).parent( 'div' ).fadeOut( 3000 );
		}
		/*----------------输出错误信息-----------------*/
		function error( msg ){
			$( '.alert' ).parent( 'div' ).css( 'display', 'block' );
			$( '#dis_message' ).text( msg );
			$( '.alert' ).removeClass( 'alert-success' ).addClass( 'alert-danger' );
			$( '.alert' ).parent( 'div' ).fadeOut( 3000 );
		}
		</script>
    </body>
</html>