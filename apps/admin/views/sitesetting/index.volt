<!doctype html>
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
            div .position i{
				color: #b2b2b2;
			    line-height: 34px;
			    margin: 0;
            	font-size:12px;
            }
            textarea.text_size{
				height:50px;
            }
            /* 图片上传 */
			.goods-pic {
                position:relative;margin:0 20px 20px 0;width:100px;height:100px;
                border:none;display:inline-block; vertical-align: middle;text-align: center;color:gray;cursor:pointer;
            }
            .goods-pic-add {
                border:1px dashed gray;
            }
            .goods-img:nth-child(2) .glyphicon-arrow-left {
                display:none;
            }
            .goods-img:last-child .glyphicon-arrow-right {
                display:none;
            }
            .goods-pic img {
               width:100px;height:100px;
            }
            .goods-pic-operate {
                position:absolute;bottom: 0; width:100%; text-align: center;background:gainsboro; display:none;
            }
        </style>
    </head>
    <body class="wrap">
        <ul class="nav nav-tabs" role="tablist" id="tabs">
            <li role="presentation" class="active"><a href="#base_setting" >基本设置</a></li>
            <!-- <li role="presentation"><a href="/admin/sitesetting/siteList">站点管理</a></li> -->
        </ul>
        <div class="tab-content">
            <div role="tabpannel" class="tab-pane active" id="base_setting" style="padding-top:20px;">
                <form class="form-horizontal" method="post" action="/admin/sitesetting/save" onsubmit="return checkFormsDatas();">
                    <div class="form-group has-feedback" >
                        <label class="col-xs-1 control-label">网站名称</label>
                        <div class="col-xs-3">
                            <textarea class="form-control text_size" rows="4" cols="60" id="name" name="form[name]" required="true">{% if mian_site.name is defined %}{{mian_site.name}}{% endif %}</textarea>
                        </div>
                        <div class="col-xs-3 position"><i class="glyphicon glyphicon-info-sign"> 一般不超过80个字符</i></div>
                    </div>
                    
                    <div class="form-group has-feedback text-right" >
                        <label class="col-xs-1 control-label">网站域名</label>
                        <div class="col-xs-3">
                            <textarea class="form-control text_size" rows="4" cols="60" id="domain" name="form[domain]">{% if mian_site.domain is defined  %}{{mian_site.domain}}{% endif %}</textarea>
                        </div>
                    </div>
                    
                    <div class="form-group has-feedback text-right">
                        <label class="col-xs-1 control-label">网站logo</label>
                        <div class="col-xs-10 text-left">
                            <div style="{% if mian_site.logo is not defined %} display:none; {% else %}display:inline-block;{% endif %}" class="goods-img-wrap">
                                <div style="{% if mian_site.logo is not defined %} display:none; {% else %}display:inline-block;{% endif %}" class="goods-pic goods-img">
                                    <img src="{% if mian_site.logo is defined %}{{ mian_site.logo | e }}{% endif %}" />
                                    <input type="hidden" id="logo" value="{% if mian_site.logo is defined %}{{ mian_site.logo | e }}{% endif %}" name="form[logo]" />
                                    <div class="goods-pic-operate">
                                        <i style="margin-right:10px;" class="glyphicon glyphicon-trash"></i>
                                        <i style="margin-right:10px;" class="glyphicon glyphicon-edit"></i>
                                        <i class="glyphicon glyphicon-arrow-right"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="goods-pic goods-pic-add" style="{% if mian_site.logo is not defined %} display:block; {% else %}display:none;{% endif %}">
                                <i style="margin-top:40%;" class="glyphicon glyphicon-plus"></i>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group has-feedback" >
                        <label class="col-xs-1 control-label">SEO关键字</label>
                        <div class="col-xs-3">
                            <textarea class="form-control text_size" rows="4" cols="60" id="seokey" name="form[seokey]">{% if mian_site.seokey is defined  %}{{mian_site.seokey}}{% endif %}</textarea>
                        </div>
                        <div class="col-xs-3 position"><i class="glyphicon glyphicon-info-sign"> 一般不超过100个字符，关键词用英文逗号隔开</i></div>
                    </div>
                    
                    <div class="form-group has-feedback" >
                        <label class="col-xs-1 control-label">SEO描述</label>
                        <div class="col-xs-3">
                            <textarea class="form-control text_size" rows="4" cols="60" id="seodescr" name="form[seodescr]">{% if mian_site.seodescr is defined  %}{{mian_site.seodescr}}{% endif %}</textarea>
                        </div>
                        <div class="col-xs-3 position"><i class="glyphicon glyphicon-info-sign"> 一般不超过200个字符</i></div>
                    </div>
                    
                    <div class="form-group has-feedback text-right" >
                        <label class="col-xs-1 control-label">版权信息</label>
                        <div class="col-xs-3">
                            <textarea class="form-control text_size" required="true" rows="4" cols="60" name="form[copyright]">{% if mian_site.copyright is defined  %}{{mian_site.copyright}}{% endif %}</textarea>
                        </div>
                    </div>
                    
                    <div class="form-group has-feedback text-right" >
                        <label class="col-xs-1 control-label">访问统计代码</label>
                        <div class="col-xs-3">
                            <textarea class="form-control" rows="6" cols="70" name="form[static_code]">{% if mian_site.static_code is defined  %}{{mian_site.static_code}}{% endif %}</textarea>
                        </div>
                    </div>
                    
                    <div class="form-group" style="margin-top: 30px;">
                        <div class="col-sm-offset-1 col-sm-12">
                        	<input type="hidden" name="<?php echo $this->security->getTokenKey();?>" value="<?php echo $this->security->getToken();?>" />
                        	<input type="hidden" id="id" name="form[id]" value="{% if mian_site.id is defined  %}{{mian_site.id}}{% endif %}" />
                           	<input type="submit" value="提交" name="submit" id="submit" class="btn btn-info col-xs-2">
                        </div>
                    </div>
                </form>
            </div>
        </div>
        
        <div class="alert alert-danger text-center col-xs-2" style="position:fixed; bottom:0; margin-left:40%;display:none;">
            <span>网络错误</span>
        </div>
     
     	<script type="text/plain" id="upload_ue" style="display:none"></script>
        <script src="/js/jquery/jquery-1.11.1.min.js"></script>
        <script src="/u/ueditor.config.js"></script>
        <script src="/u/ueditor.all.js"></script>
        <script type="text/javascript" charset="utf-8" src="/u/lang/zh-cn/zh-cn.js"></script>
        <script src="/bootstrap/3.3.0/js/bootstrap.min.js"></script>
        <script src="/js/fcmsIndex/iframeStyle.js"></script>
        <script type="text/javascript">
        /*------------图片添加-----------*/
		var _editor = UE.getEditor( 'upload_ue',{ 
			bizt:'user',
            serverUrl:'/common/upload/ctrl.php'
		} );
        
        _editor.ready( function () {
            _editor.hide();
            _editor.addListener( 'beforeInsertImage', function ( t, arg ) {     //侦听图片上传
				$( 'div.goods-img' ).find( 'img' ).attr( 'src' , arg[0].src );
            	$( 'div.goods-img' ).find( 'input[type="hidden"]' ).val( arg[0].src );
            	$( 'div.goods-img-wrap' ).show();
            	$( 'div.goods-img' ).show();
            	$( '.goods-pic-add' ).hide();
            	window.parent.iframeStyle( 0 );
            });
            _editor.setDisabled( [ 'insertimage' ] );
        });
        
		$( '.goods-pic-add' ).click( function(){ //图片的添加
			var myImage = _editor.getDialog( "insertimage" );
			myImage.open();
		});

        $( 'div.goods-pic-operate i.glyphicon-edit' ).click(function(){
    	    var myImage = _editor.getDialog( "insertimage" );
            myImage.open();
        });
        $( 'form' ).delegate( '.goods-img img', 'click', function(){ //图片修改
			var myImage = _editor.getDialog("insertimage");
			myImage.open();
			$( 'form' ).data( 'changePic', this );
		});
       
		/*-----------------显示对图片的操作--------------------*/
		$( 'form' ).delegate ( '.goods-img', 'mouseover', function(){ //显示对图片的操作
			$( this ).find( '.goods-pic-operate' ).show();
			return true;
		});
		$( 'form' ).delegate ( '.goods-img', 'mouseout', function(){ 
           $( this ).find( '.goods-pic-operate' ).hide();
        });
        $( 'form' ).delegate ( '.goods-pic-operate .glyphicon', 'mouseover', function(){ //显示对图片的操作
            $( this ).css( 'color', 'black' ); 
        });
        $( 'form' ).delegate ( '.goods-pic-operate .glyphicon', 'mouseout', function(){ 
			$( this ).css( 'color', 'gray' );
        });
        $( 'form' ).delegate( '.glyphicon-trash', 'click', function(){
        	$( 'div.goods-img' ).find( 'img' ).attr( 'src' , '' );
            $( 'div.goods-img' ).find( 'input[type="hidden"]' ).val( '' );
            $( this ).parents( '.goods-pic' ).hide();
            $( '.goods-pic-add' ).show();
        });
        
        /*-----------------提交判断--------------------*/
        $( '#submit' ).click( function(){
       		$( this ).attr( 'disabled', true );
       		$( 'textarea:required' ).each( function(){
       			if( '' == $( this ).val() ){
       				error( $( this ) );
       			}else{
       				success( $( this ) );
       			}
       		} );
       	} );
        
       	$( 'textarea:required' ).blur( function(){
  			if( '' == $( this ).val() ){
    			error( $( this ) );
    		}else{
    			success( $( this ) );
    		}
   		} );
       	
       	$( 'textarea, input' ).keydown( function(){
   			$( "#submit" ).attr( 'disabled', false );
   		} );
       	
       	$( '#domain' ).focus( function(){
       		if( $(this).parents( '.form-group' ).hasClass( 'has-error' ) )
  			{
       			$(this).parents( '.form-group' ).removeClass( 'has-error' );
       			$( this ).parent( 'div' ).next( 'div.text-danger' ).remove();
       			$( "#submit" ).attr( 'disabled', false );
  			}
        });
       	
        function checkFormsDatas()
        {
        	var status = true;
        	var reg	= /^(?:https?:\/\/)?(?:(?:[-a-zA-Z0-9]+)\.){1,}(?:[-a-zA-Z0-9]+)$/;
        	var domain = $( '#domain' ).val();
        	if( !domain || domain.length < 0 )
       		{
        		/*------------------------设置错误标识------------------------------*/
				$( '#domain' ).parent( 'div' ).find( 'span' ).remove();
				$( '#domain' ).parent( 'div' ).parent( 'div.form-group' ).addClass( 'has-error' );
				status = false;
       		}
        	else if( !reg.test( domain ) )
        	{
        		/*------------------------设置错误标识------------------------------*/
				$( '#domain' ).parent( 'div' ).find( 'span' ).remove();
				$( '#domain' ).parent( 'div' ).parent( 'div.form-group' ).addClass( 'has-error' );
				/*-------------------------设置错误信息-----------------------------*/
				var obj = $( '#domain' ).parent( 'div' );
				if( !$(obj).parent( 'div' ).find( 'div' ).hasClass( 'error' ) )
				{
					var errorMgs = $.trim( $( obj ).prev( 'label' ).text().replace( '*' , '' ) ) + '填写有误.';
					var errorContent = '<div class="text-danger text-left col-xs-3 position"><i class="glyphicon glyphicon-info-sign" style="color:color: #a94442"></i> '+errorMgs+'</div>';
					$( obj ).after( errorContent );
				}
				
				status = false;
        	}
        	
        	return status;
        }
        function success( obj ){
        	obj.parents( 'div.form-group' ).removeClass( 'has-error' ).addClass( 'has-success' );
        }
        function error( obj ){
        	obj.parents( 'div.form-group' ).removeClass( 'has-success' ).addClass( 'has-error' );
        }
        </script>
       
    </body>
</html>
