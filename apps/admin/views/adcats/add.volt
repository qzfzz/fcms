<!doctype html>
<html>
    <head>
        <link rel="stylesheet" href="/css/admin/base.css">
        <link rel="stylesheet" type="text/css" href="/bootstrap/3.3.0/css/bootstrap.min.css">
        <style>
			.alertMsg{
				color:#A94442;
            	height:34px;
            	line-height:34px;
            	text-align:left;
            }
			.catMsg{
            	height:34px;
            	line-height:34px;
            	text-align:left;
            }
		</style>
    </head>
    <body class="wrap">
        <ul class="nav nav-tabs" role="tablist">
            <li role="presentation" class=""><a href="/admin/adCats/index">广告分类</a></li>
            <li role="presentation"class="active"><a href="#adCatsAdd" >添加广告分类</a></li>
        </ul>
        <div class="tab-content">
            <div role="tabpannel" class="tab-pane active" id="adCatsAdd" style="padding-top:20px;">
                <form class="form-horizontal">
                    <div class="form-group has-feedback text-right">
                        <label class="col-xs-2 control-label">分类名称</label>
                        <div class="col-xs-3">
                            <input class="form-control" type="text" id="cateName" name="cateName" placeholder="请输入分类名称"/>
                        </div>
                        <span class="alertMsg col-xs-2"></span>
                    </div>
                     <div class="form-group has-feedback text-right">
                        <label class="col-xs-2 control-label">分类宽度</label>
                        <div class="col-xs-3">
                            <input class="form-control" type="text" id="width" name="width" placeholder="请输入分类宽度"/>
                        </div>
                        <span class="alertMsg col-xs-2"></span>
                    </div>
                     <div class="form-group has-feedback text-right">
                        <label class="col-xs-2 control-label">分类高度</label>
                        <div class="col-xs-3">
                            <input class="form-control" type="text" id="height" name="height" placeholder="请输入分类高度"/>
                        </div>
                        <span class="alertMsg col-xs-2"></span>
                    </div>
                    <div class="form-group has-feedback text-right">
                        <label class="col-xs-2 control-label">上级分类</label>
                        <div class="col-xs-3">
                            <select class="form-control" id="parentId" name="parentId" value="">
                                <option value="0" class="text-center">无上级分类</option>
                                {% if adCats is not empty %}
                                {% for first in adCats %}
                                <option value="{{ first[ 'id' ] | escape_attr }}" >{{ first[ 'name' ] | e }}</option>
                                {% if first[ 'sub' ] is defined %}
                                    {% for second in first[ 'sub' ] %}
                                        <option value="{{ second[ 'id' ] | escape_attr }}" style="padding-left:20px;" >--{{ second[ 'name' ] | e }}</option>
                                         {% if second[ 'sub' ] is defined %}
                                            {% for third in second[ 'sub' ] %}
                                            <option value="{{ third[ 'id' ] | escape_attr }}" style="padding-left:40px;" disabled>---{{ third[ 'name' ] | e }}</option>
                                            {% endfor %}
                                        {% endif %}
                                    {% endfor %}
                                {% endif %}
                                {% endfor %}
                                {% endif %}
                            </select>
                        </div>
                        <span class="catMsg col-xs-2">最高支持3级分类</span>
                    </div>
               
                    <div class="form-group" style="margin-top: 30px;">
                        <div class="col-sm-offset-2 col-sm-10">
                            <button type="button" class="btn btn-success btn-sm" id="cateInsert" style="margin-right: 50px;width:70px;">保存</button>
                            <button type="button" class="btn btn-default btn-sm" id="cancel" style="width:70px;">取消</button>
                        </div>
                    </div>
                </form>
                
            </div>
        </div>
        <div class="alert alert-danger text-center col-xs-2" style="margin-left:40%;display:none;">
            <span>网络错误</span>
        </div>
        <script src="/js/jquery/jquery-1.11.1.min.js"></script>
        <script>
        	
			var key = "<?php echo $this->security->getTokenKey();?>";
			var token = "<?php echo $this->security->getToken();?>";
        	
            $( function(){
                var is_check = false;
                var oldName = '';
             	/*-------------表单数据验证---------------*/
                $( ':text' ).blur( function(){
                	var objParent = $( this ).parents( '.form-group' );
                    objParent.find( 'div > span' ).remove();
                    var value = $( this ).val();
                    var oldState = '';
                    if( value === '' ){
                    	//数据不能为空
                    	error( objParent );
                    	errorAlert( objParent, '数据不能为空' );
                    }else{
                    	//数据不为空，则进行后续判断
                    	if( 'cateName' == $( this ).attr( 'id' ) ){
                    		if( oldName != $( this ).val() ){
	                    		//如果是分类名称
	                    		$.get( "/admin/Adcats/checkInsert/name/" + value, function( ret ){
	                    			switch ( parseInt(ret) ){
	                    				case 0:
	                   						//广告分类名称在数据库中不存在，可创建
	                       					success( objParent );
	                   						successAlert( objParent );
	                   						oldState = 0;
	                    					break;
	                    				case 1:
	                    					//广告分类名称已存在，请更换
	                    					error( objParent );
	                    					errorAlert( objParent, '广告分类名称已存在，请更换' );
	                    					oldState = 1;
	                    					break;
	                    				case 2:
	                    					//未找到现有分类的id或未传递成功
	                    					error( objParent );
	                    					errorAlert( objParent, '未找到现有分类的id或未传递成功' );
	                    					oldState = 1;
	                    					break;
	                    			}
	                    		} );
	                    		oldName = $( this ).val();
                    		}else{
                    			//解决再次点击错号或对号消失的问题
                    			if( oldState ){
                    				error( objParent );
                    			}else{
                    				success( objParent );
                    			}
                    		}
                    	}else{
                    		//如果是宽、高
                    		var pattern = /^[1-9]{1}\d*$/;
                    		if( pattern.test( value ) ){
                    			success( objParent );
                    			successAlert( objParent );
                    		}else{
                    			error( objParent );
                    			errorAlert( objParent, '请输入正整数' );
                    		}
                    	}
                    }
                	
                } );
             	
                /*-----------提交数据-----------*/
                $( '#cateInsert' ).click( function(){
            		$( ':text' ).blur(); //重新检验一下数据
                    
                  if( $( '#parentId' ).val() === '' ){
                        errorMsg( '请选择上级分类' );
                        return false;
                    }
                    
                    if( ! $( 'form span' ).hasClass( 'glyphicon-remove') ){ //数据正确可以提交表单了
						var data = $( 'form' ).serialize();
						data +=  '&key='+key+'&token='+token;
                        
	                    $( '#cateInsert' ).attr( 'disabled', 'disabled' );
                        $.post( '/admin/adCats/insert', data, function( ret ){
                            if( ! ret.status )
                                location = '/admin/adCats/index';
                            else
                            {
                            	errorMsg( ret.msg );
                                $( '#cateInsert' ).removeAttr( 'disabled' );
                            }
                            
                            key = ret.key;
                            token = ret.token;
                             
                        }, 'json').error(function(){
                            errorMsg( '网络不通' );
                            $( '#roleInsert' ).removeAttr( 'disabled' );
                        } );
                    }
                  
                    return false;
				} );
                
				/* ----------取消---------------*/
				$( '#cancel' ).click( function(){
					location = '/admin/adCats/index';
					return false;
                } );
				
            } );
            function success( obj ){
                 obj.addClass( 'has-success' ).removeClass( 'has-error' );
                 obj.find( '.form-control' ).after( '<span class="glyphicon glyphicon-ok form-control-feedback"></span>' );
            }
            function error( obj ){
                 obj.addClass( 'has-error').removeClass('has-success');
                 obj.find('.form-control').after( '<span class="glyphicon glyphicon-remove form-control-feedback"></span>' );
            }
            function successMsg( msg ){
            	$( '.alert' ).removeClass( 'alert-danger' ).addClass( 'alert-success' );
            	$( '.alert span' ).text( msg );
                $( '.alert' ).show().fadeOut( 3000 );
            }
            function errorMsg( msg ){
            	$( '.alert' ).removeClass( 'alert-success' ).addClass( 'alert-danger' );
                $( '.alert span' ).text( msg );
                $( '.alert' ).show().fadeOut( 3000 );
            }
            function successAlert( obj ){
            	obj.find( 'span.alertMsg' ).empty();
            }
            function errorAlert( obj, msg ){
            	obj.find( 'span.alertMsg' ).empty();
            	obj.find( 'span.alertMsg' ).html( msg );
            }
        </script>
    </body>
</html>