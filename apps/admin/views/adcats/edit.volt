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
            <li role="presentation" class=""><a href="{{ url( 'admin/adCats/index' ) | escape_attr }}">广告分类</a></li>
            <li role="presentation"class=""><a href="{{ url( 'admin/adCats/add' ) | escape_attr }}" >添加广告分类</a></li>
            <li role="presentation" class="active"><a href="#adCatsEdit">编辑广告分类</a></li>
        </ul>
        <div class="tab-content">
            <div role="tabpannel" class="tab-pane active" id="adCatsEdit" style="padding-top:20px;">
                {% if adCats is defined and adCats is not empty %}
                <form class="form-horizontal">
                    <div class="form-group has-feedback text-right">
                        <label class="col-xs-2 control-label">分类名</label>
                        <div class="col-xs-3">
                            <input class="form-control" type="text" id="cateName" name="cateName" placeholder="请输入分类" value='{{ adCats[ 'name' ]|escape_attr}}'/>
                        </div>
                        <span class="alertMsg col-xs-2"></span>
                    </div>
                    <div class="form-group has-feedback text-right">
                        <label class="col-xs-2 control-label">分类宽度</label>
                        <div class="col-xs-3">
                            <input class="form-control" type="text" id="width" name="width" placeholder="请输入宽度" value='{{ adCats[ 'width' ]|escape_attr}}'/>
                        </div>
                        <span class="alertMsg col-xs-2"></span>
                    </div>
                    <div class="form-group has-feedback text-right">
                        <label class="col-xs-2 control-label">分类高度</label>
                        <div class="col-xs-3">
                            <input class="form-control" type="text" id="height" name="height" placeholder="请输入高度" value='{{ adCats[ 'height' ]|escape_attr}}'/>
                        </div>
                        <span class="alertMsg col-xs-2"></span>
                    </div>
                    <div class="form-group has-feedback text-right">
                        <label class="col-xs-2 control-label">上级分类</label>
                        <div class="col-xs-3">
                            <select class="form-control" id="parentId" name="parentId" value="">
                                <option value="0" class="text-center">无上级分类</option>
                                {% if allCats is not empty %}
                                {% for first in allCats %}
                                <option  value="{{ first[ 'id' ] | escape_attr }}" 
                                         {% if adCats[ 'pid' ] == first[ 'id' ] %}selected{% endif %}>{{ first[ 'name' ] | e }}</option>
                                {% if first[ 'sub' ] is defined %}
                                {% for second in first[ 'sub' ] %}
                                <option value="{{ second[ 'id' ] | escape_attr }}" style="padding-left:20px;" 
                                        {% if adCats[ 'pid' ] == second[ 'id' ] %}selected{% endif %}>--{{ second[ 'name' ] | e }}</option>
                                {% if second[ 'sub' ] is defined %}
                                {% for third in second[ 'sub' ] %}
                                <option value="{{ third[ 'id' ] | escape_attr }}" disabled style="padding-left:40px;" 
                                        {% if adCats[ 'pid' ] is third[ 'id' ] %}selected{% endif %}>---{{ third[ 'name' ] | e }}</option>
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
                            <button type="button" class="btn btn-success btn-sm" id="adCatsUpdate" style="margin-right: 50px;width:70px;">保存</button>
                            <button type="button" class="btn btn-default btn-sm" id="cancel" style="width:70px;" >取消</button>
                        </div>
                    </div>
                    <input type="hidden" name="id" value="{{ adCats['id'] | e }}" />
                </form>
                {% else %}
                <div class="col-xs-12 text-center text-danger">没有数据</div>
                {% endif %}
            </div>
        </div>
        <div class="alert alert-danger col-xs-2 text-center" style="margin-left:40%;display:none;">
            <span>网络错误</span>
        </div>
        <script src="/js/jquery/jquery-1.11.1.min.js"></script>
        <script>
        var key = "<?php echo $this->security->getTokenKey();?>";
		var token = "<?php echo $this->security->getToken();?>";
		var oldName = "<?php if( isset( $adCats[ 'name' ] ) ) echo $adCats[ 'name' ]; else echo ''; ?>";
$( function(){
    /*-------------表单数据验证---------------*/
    $( ':text' ).blur( function(){
    	var objParent = $( this ).parents( '.form-group' );
        objParent.find( 'div > span' ).remove();
        var value = $( this ).val();
        if( value === '' ){
        	//数据不能为空
        	error( objParent );
        	errorAlert( objParent, '数据不能为空' );
        }else{
        	//数据不为空，则进行后续判断
        	if( 'cateName' == $( this ).attr( 'id' ) ){
        		//如果是分类名称
        		if( oldName != $( this ).val() ){
        			$.get( "/admin/Adcats/checkUpdate/id/{% if adCats is not empty %}{{ adCats[ 'id' ] | e }}{% else %}0{% endif %}/name/" + value, function( ret ){
            			switch ( parseInt(ret) ){
            				case 0:
           						//广告分类名称在数据库中不存在，可创建
               					success( objParent );
           						successAlert( objParent );
            					break;
            				case 1:
            					//广告分类名称已存在，请更换
            					error( objParent );
            					errorAlert( objParent, '广告分类名称已存在，请更换' );
            					break;
            				case 2:
            					//该广告分类信息在数据库中不存在
            					error( objParent );
            					errorAlert( objParent, '该广告分类信息在数据库中不存在' );
            					break;
            				case 3:
            					//未找到现有分类的id或为传递成功
            					error( objParent );
            					errorAlert( objParent, '未找到现有分类的id或参数未传递成功' );
            					break;
            			}
            		} );
        			oldName = $( this ).val();
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
    } ).keydown( function(){
    	$( '#adCatsUpdate' ).attr( 'disabled', false );
    } );
	
    /*-----------更新数据-----------*/
    $( '#adCatsUpdate' ).click( function(){
    	$( this ).attr( 'disabled', true );
        $( ':text' ).blur(); //重新检验一下数据
		if( !$( ':checked' ).length ){
			errorMsg( '请选择用户组' );
            return false;
		}

        if( !$( 'form div.form-group' ).hasClass( 'has-error' ) ){ //数据正确可以提交表单了
			var data = $( 'form' ).serialize();
			data += "&id={% if adCats is not empty %}{{ adCats[ 'id' ] | e }}{% else %}0{% endif %}&name=" + $( '#catName' ).val() + "&"+key+"=" + token;

            $.post( '/admin/adCats/update', data, function( ret ){
            	var objParent = $( '#catName' ).parents( 'div.form-group' );
            	switch ( parseInt( ret.state ) ){
				case 0:
					//广告分类名称在数据库中不存在，可创建
   					success( objParent );
					successAlert( objParent );
					successMsg( '更新成功' );
					location = '/admin/adCats/index';
					break;
				case 1:
					//广告分类名称已存在，请更换
					error( objParent );
					errorAlert( objParent, '广告分类名称已存在，请更换' );
					errorMsg( '广告分类名称已存在，请更换' );
					$( '#adCatsUpdate' ).attr( 'disabled', 'false' );
					break;
				case 2:
					//该广告分类信息在数据库中不存在
					error( objParent );
					errorAlert( objParent, '该广告分类信息在数据库中不存在' );
					errorMsg( '该广告分类信息在数据库中不存在' );
					$( '#adCatsUpdate' ).attr( 'disabled', 'false' );
					break;
				case 3:
					//未找到现有分类的id或为传递成功
					error( objParent );
					errorAlert( objParent, '未找到现有分类的id或参数未传递成功' );
					errorMsg( '未找到现有分类的id或参数未传递成功' );
					$( '#adCatsUpdate' ).attr( 'disabled', 'false' );
					break;
				case 4:
					//更新失败
					errorMsg( '更新失败' );
					$( '#adCatsUpdate' ).attr( 'disabled', 'false' );
					break;
            	}
            	
            	key = ret.key;
            	token = ret.token;
            	
            }, 'json' ).error( function(){
                errorMsg( '网络不通' );
                $( '#adCatsUpdate' ).attr( 'disabled', 'false' );
            } );
        }
        else{
	        return false;
        }
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
    obj.addClass( 'has-error' ).removeClass( 'has-success' );
    obj.find( '.form-control' ).after( '<span class="glyphicon glyphicon-remove form-control-feedback"></span>' );
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