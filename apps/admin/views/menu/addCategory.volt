<!Doctype html>
<html>
    <head>
        <link rel="stylesheet" href="/css/admin/base.css">
        <link rel="stylesheet" type="text/css" href="/bootstrap/3.3.0/css/bootstrap.min.css">
        <style>
            .articles-pic-operate {
                position:absolute;bottom: 0; width:100%; text-align: center;background:gainsboro; display:none;
            }
             .col-xs-2 {
                padding-right: 0;
            }
			.alertMsg{
				color:#A94442;
            	height:34px;
            	line-height:34px;
            	text-align:left;
            }
        </style>
    </head>
    <body class="wrap">
        <ul class="nav nav-tabs" role="tablist" id="tabs">
            <li role="presentation"><a href="/admin/menu/category">菜单分类</a></li>
            <li role="presentation" class="active"><a href="#menuCateAdd" >{% if res.id is defined  %}修改分类{% else %}添加分类{% endif %}</a></li>
        </ul>
        <div class="tab-content">
            <div role="tabpannel" class="tab-pane active" id="menuCateAdd" style="padding-top:20px;">
                <form class="form-horizontal">
                	<div class="form-group has-feedback text-right" >
                        <label class="col-xs-1 control-label" style="padding-top:0px;line-height:34px;height:34px;">分类名</label>
                        <div class="col-xs-3">
                            <input class="form-control" type="text" id="name" name="name" required="required" value="{% if res.name is defined  %}{{res.name}}{% endif %}" />
                        </div>
                        <span class="alertMsg col-xs-2"></span>
                    </div>
                    <div class="form-group has-feedback " >
                        <label class="col-xs-1 control-label" style="padding-top:0px;line-height:34px;height:34px;">主菜单</label>
                        <div class="col-xs-3">
                            <input style="height:34px;line-height:34px;margin-top:0;" type="checkbox" id="is_main" name="is_main" {% if res.is_main is defined and 1 == res.is_main  %} {% else %}checked="true"{% endif %} />
                        </div>
                    </div>
                    <div class="form-group" style="margin-top: 30px;">
                        <div class="col-sm-offset-1 col-sm-6">
                           	<input type="hidden" name="id" value="{% if res.id is defined  %}{{res.id}}{% endif %}" />
                           	<input type="button" value="提交" name="submit" class="btn btn-info col-sm-6 col-xs-3" id="has_submit">
                        </div>
                    </div>
                </form>
            </div>
        </div>
        
        <div class="alert alert-danger text-center col-xs-2" style="position:fixed; bottom:0; margin-left:40%;display:none;">
            <span>网络错误</span>
        </div>
     
        <script src="/js/jquery/jquery-1.11.1.min.js"></script>
        <script src="/bootstrap/3.3.0/js/bootstrap.min.js"></script>
        <script>
	    	var key = "<?php echo $this->security->getTokenKey();?>";
    		var token = "<?php echo $this->security->getToken();?>";
    		
	        $( function(){
	    		$( 'input' ).keydown( function(){
	    			$( '#has_submit' ).removeAttr( 'disabled' );
	    		} ).change( function(){
	    			$( '#has_submit' ).removeAttr( 'disabled' );
	    		} );
	    	} );
	    	$( '#has_submit' ).click( function(){
	    		$( this ).attr( 'disabled', 'disabled' );
	    	} );
    		
	    	$( '#has_submit' ).click( function(){
	    		var objParent = $( '#name' ).parents( 'div.has-feedback' );
	    		objParent.find( 'span.form-control-feedback' ).remove();
	    		
	    		var data = $( 'form' ).serialize();
	    		data += '&key=' + key + '&token=' + token;
	    		
	    		$.post( '/admin/menu/saveBiz', data, function( ret ){
	    			if( ret.status ){
	    				errorMsg( ret.msg );
	    			}else{
	    				switch( parseInt( ret.state ) ){
		    				case 0:
		    					successMsg( '操作成功' );
		    					//location.href="/admin/menu/category";
		    					break;
		    				case 1:
		    					errorMsg( '操作失败' );
		    					break;
		    				case 2:
		    					errorMsg( '未找到该条记录' );
		    					break;
		    				case 3:
		    					errorMsg( '分类名重复，请修改' );
		    					break;
		    			}
    				}
	    			key = ret.key;
	    			token = ret.token;
	    		}, 'json' );
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
	    		$( '.alert span' ).text( msg );
	    		$( '.alert' ).removeClass( 'alert-danger' ).addClass( 'alert-success' );
	    		$( '.alert' ).show().fadeOut( 3000 );
	    	}
	    	function errorMsg( msg ){
	    		$( '.alert span' ).text( msg );
	    		$( '.alert' ).removeClass( 'alert-success' ).addClass( 'alert-danger' );
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
