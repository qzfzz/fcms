<!doctype html>
<html>
    <head>
        <link rel="stylesheet" href="/css/admin/base.css">
        <link rel="stylesheet" type="text/css" href="/bootstrap/3.3.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="/bootstrap/datetimepicker/bootstrap-datetimepicker.min.css">
        <link rel="stylesheet"  href="/css/admin/font-awesome.min.css" >
    </head>
    <body class="wrap">
        <ul class="nav nav-tabs" role="tablist" id="tabs">
            <li role="presentation"><a href="/admin/staticcache/list">列表配置</a></li>
            <li role="presentation"class="active"><a href="#cacheAdd" >{% if res.id is defined %}修改配置项{% else %}添加配置项{% endif %}</a></li>
        </ul>
        <div class="tab-content">
            <div role="tabpannel" class="tab-pane active" id="adAdd" style="padding-top:20px;">
                <form class="form-horizontal" action="/admin/staticcache/saveList" method="post" onsubmit="return checkFormVals();">
                    <div class="form-group has-feedback text-right">
                        <label class="col-xs-2 control-label">配置名称</label>
                        <div class="col-xs-3">
                            <input class="form-control required engname" type="text" id="name" name="name" placeholder="配置项名称" value="{% if res.name is defined  %}{{res.name}}{% endif %}"/>
                        </div>
                    </div>
                    
                    <div class="form-group has-feedback text-right">
                        <label class="col-xs-2 control-label">配置前缀</label>
                        <div class="col-xs-3">
                            <input class="form-control required urlpatt" type="text" id="pre_name" name="pre_name" placeholder="配置项前缀"  value="{% if res.prefix is defined  %}{{res.prefix}}{% endif %}"/>
                        </div>
                        <span class="col-xs-4 col-md-5 alert alert alert-warning text-left" style="padding: 0px; font-size: 12px; margin-top: 0.7%;"><i class="fa fa-info-circle"></i> 格式 模块名称+控制器名+动作名称+参数名称  用 / 隔开 eg: /module/controller/action/params </span>
                    </div>
                    
                    <div class="form-group">
                        <label class="col-xs-2 control-label"> 缓存类型</label>
                        <div class="col-xs-8">
                            <label class="radio-inline"><input type="radio" name="type" value="1" {% if res.type is defined and 1 == res.type  %} checked="true" {% elseif res.type is not defined  %} checked="true" {% endif %} />File</label>
                            <label class="radio-inline"><input type="radio" name="type" value="2" {% if res.type is defined and 2 == res.type  %} checked="true" {% endif %} disabled data-toggle="tooltip" data-placement="top" title="该功能正开发中..."/>Memcache</label>
                        </div>
                    </div>
                     <div class="form-group has-feedback text-right">
                        <label class="col-xs-2 control-label">缓存时间</label>
                        <div class="col-xs-3">
                            <input class="form-control form_datetime required number" type="text" id="cache_time" name="cache_time" placeholder="请输缓存时间" 
                                   value="{% if res.cache_time is defined  %}{{res.cache_time}}{% endif %}"/>单位（分钟）
                        </div>
                    </div>

                    <div class="form-group" style="margin-top: 30px;">
                        <div class="col-sm-offset-2 col-sm-10">
                        	<input type="hidden" name="<?php echo $this->security->getTokenKey();?>" value="<?php echo $this->security->getToken();?>" />
                        	<input type="hidden" name="id" value="{% if res.id is defined  %}{{res.id}}{% endif %}" />
                            <button type="submit" class="btn btn-success btn-sm" id="cacheInsert" style="margin-right: 50px;width:70px;">保存</button>
                            <button type="button" class="btn btn-default btn-sm" onclick="javascript:location.href='/admin/staticcache/list'" style="width:70px;">取消</button>
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
	        $( function(){
	    		$( 'input' ).change( function(){
	    			$( '#cacheInsert' ).removeAttr( 'disabled' );
	    		} );
	    	} );
	    	$( '#cacheInsert' ).click( function(){
	    		$( this ).attr( 'disabled', 'disabled' );
	    	} );
	    	
	    	/*--------------------------------- input  必填移除错误特效 ---------------------------*/
	    	$( 'form.form-horizontal input.required' ).each(function( index ){
	    		$( this ).focus(function(){
	    			$( this ).parent( 'div' ).parent( 'div.form-group' ).removeClass( 'has-error' );
    				$( this ).parent( 'div' ).find( 'span.glyphicon' ).removeClass( 'glyphicon-remove' ).addClass( 'glyphicon-pencil' );
    				
    				if( $( this ).parent( 'div' ).next( 'div').hasClass( 'error' ) )
    				{
    					$(this).parent( 'div' ).next( 'div').remove();
    				}
    				
	    			$( 'button#cacheInsert' ).removeAttr( 'disabled' );
	    		});
	    	});
	    	
	    	function checkFormVals()
	    	{
	    		var status = true;
	    		/*-------------------------------input - 不能为空-------------------------------------*/
	    		$( 'form.form-horizontal input.required' ).each(function(){
	    			if( false == $(this).val() || $(this).length < 0 )
	    			{
	    				/*------------------------设置错误标识------------------------------*/
	    				$( this ).parent( 'div' ).find( 'span' ).remove();
	    				var errorIcon = '<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>'+
	    								'<span class="sr-only">(error)</span>';
	    				
	    				$( this ).after( errorIcon );
	    				$( this ).parents( 'div.form-group' ).addClass( 'has-error' );
	    				
	    				status = false;
	    			}
	    		});
	    		
	    		/*-------------------------------input 数字 整数匹配-------------------------------------*/
	    		$( 'form.form-horizontal input.number' ).each(function(){
	    			if( false != $(this).val() && $(this).length > 0 )
	    			{
	    				if( $(this).hasClass( 'zero' ) )
	    					var regExNumber 	= /^\d+$/;
	    				else
	    					var regExNumber 	= /^[1-9]\d*$/;
	    				
	    				if( !regExNumber.test( $(this).val() ) )
	    				{
	    					/*------------------------设置错误标识------------------------------*/
	    					$( this ).parent( 'div' ).find( 'span' ).remove();
	    					if( !$(this).next( 'div' ).hasClass( 'input-group-addon' ) )
	    					{
	    						var errorIcon = '<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>'+
	    										'<span class="sr-only">(error)</span>';
	    						
	    						$( this ).after( errorIcon );
	    						$( this ).parent( 'div' ).parent( 'div.form-group' ).addClass( 'has-error' );
	    					}
	    					else
	    						$( this ).parent( 'div' ).parent( 'div' ).parent( 'div.form-group' ).addClass( 'has-error' );
	    					
	    					/*-------------------------设置错误信息-----------------------------*/
	    					var obj = $(this).parent( 'div' );
	    					if( !$(obj).parent( 'div' ).find( 'div' ).hasClass( 'error' ) )
	    					{
	    						var errorMgs = '请输入正确的'+ $.trim( $( obj ).prev( 'label' ).text().replace( '*' , '' ) );
	    						var errorContent = '<div class="text-danger text-left error"><i class="glyphicon glyphicon-info-sign"></i> '+errorMgs+'</div>';
	    						$( obj ).after( errorContent );
	    					}
	    					
	    					status = false;
	    				}
	    			}
	    		});
	    		
	    		/*-------------------------------input  英文  字母匹配-------------------------------------*/
	    		$( 'form.form-horizontal input.engname' ).each(function(){
	    			if( false != $(this).val() && $(this).length > 0 )
	    			{
	    				var regExEng	= /^[A-Za-z]+$/;
	    				if( !regExEng.test( $(this).val() ) )
	    				{
	    					/*------------------------设置错误标识------------------------------*/
	    					$( this ).parent( 'div' ).find( 'span' ).remove();
	    					if( !$(this).next( 'div' ).hasClass( 'input-group-addon' ) )
	    					{
	    						var errorIcon = '<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>'+
	    										'<span class="sr-only">(error)</span>';
	    						
	    						$( this ).after( errorIcon );
	    						$( this ).parent( 'div' ).parent( 'div.form-group' ).addClass( 'has-error' );
	    					}
	    					else
	    						$( this ).parent( 'div' ).parent( 'div' ).parent( 'div.form-group' ).addClass( 'has-error' );
	    					
	    					/*-------------------------设置错误信息-----------------------------*/
	    					var obj = $(this).parent( 'div' );
	    					if( !$(obj).parent( 'div' ).find( 'div' ).hasClass( 'error' ) )
	    					{
	    						var errorMgs = '输入信息有误,该栏目只支持英文并大小写不限制';
	    						var errorContent = '<div class="text-danger text-left error"><i class="glyphicon glyphicon-info-sign"></i> '+errorMgs+'</div>';
	    						$( obj ).after( errorContent );
	    					}
	    					
	    					status = false;
	    				}
	    			}
	    		});
	    			
	    		/*-------------------------------input 特定url -------------------------------------*/
	    		$( 'form.form-horizontal input.urlpatt' ).each(function(){
	    			if( false != $(this).val() && $(this).length > 0 )
	    			{
	    				var regExSelfPatt	= /^\/([A-Za-z]+)\/([A-Za-z]+)\/([A-Za-z]+)(.*)/;
	    				if( !regExSelfPatt.test( $(this).val() ) )
	    				{
	    					/*------------------------设置错误标识------------------------------*/
	    					$( this ).parent( 'div' ).find( 'span' ).remove();
	    					if( !$(this).next( 'div' ).hasClass( 'input-group-addon' ) )
	    					{
	    						var errorIcon = '<span class="glyphicon glyphicon-remove form-control-feedback" aria-hidden="true"></span>'+
	    										'<span class="sr-only">(error)</span>';
	    						
	    						$( this ).after( errorIcon );
	    						$( this ).parent( 'div' ).parent( 'div.form-group' ).addClass( 'has-error' );
	    					}
	    					else
	    						$( this ).parent( 'div' ).parent( 'div' ).parent( 'div.form-group' ).addClass( 'has-error' );
	    					
	    					status = false;
	    				}
	    			}
	    		});
	    		
	    		return status;
	    	}
        </script>
    </body>
</html>
