<!doctype html>
<html>
    <head>
    	<link rel="stylesheet" href="/css/admin/base.css">
        <link rel="stylesheet" type="text/css" href="/bootstrap/3.3.0/css/bootstrap.min.css">
        <style>
            .articles-pic-operate {
                position:absolute;bottom: 0; width:100%; text-align: center;background:gainsboro; display:none;
            }
            .col-xs-2{
                padding-right: 0;
            }
            div .position i{
				color: #b2b2b2;
			    line-height: 34px;
			    margin: 0;
            	font-size:12px;
            }
			/* 图片上传 */
			.goods-pic{
                position:relative;margin:0 20px 20px 0;width:100px;height:100px;
                border:none;display:inline-block; vertical-align: middle;text-align: center;color:gray;cursor:pointer;
            }
            .goods-pic-add{
                border:1px dashed gray;
            }
            .goods-img:nth-child(2) .glyphicon-arrow-left{
                display:none;
            }
            .goods-img:last-child .glyphicon-arrow-right{
                display:none;
            }
            .goods-pic img{
               width:100px;height:100px;
            }
            .goods-pic-operate{
                position:absolute;bottom: 0; width:100%; text-align: center;background:gainsboro; display:none;
            }
        </style>
    </head>
    <body class="wrap">
        <ul class="nav nav-tabs" role="tablist" id="tabs">
            <li role="presentation"><a href="/admin/sitesetting/index" >基本设置</a></li>
            <li role="presentation"><a href="/admin/sitesetting/siteList">站点管理</a></li>
            <li role="presentation"class="active"><a href="#optWebsite">{% if site.id is defined  %}修改站点{% else %}添加站点{% endif %}</a></li>
        </ul>
        <div class="tab-content">
            <div role="tabpannel" class="tab-pane active" id="optWebsite" style="padding-top:20px;">
                <form class="form-horizontal" method="post" action="/admin/sitesetting/saveBiz">
                    <div class="form-group has-feedback" >
                        <label class="col-xs-1 control-label">网站名称</label>
                        <div class="col-xs-3">
                            <textarea class="form-control" rows="3" cols="60" id="name" name="form[name]" required="true">{% if site.name is defined  %}{{site.name}}{% endif %}</textarea>
                        </div>
                        <div class="col-xs-3 position"><i class="glyphicon glyphicon-info-sign"> 一般不超过80个字符</i></div>
                    </div>
                    
                    <div class="form-group has-feedback text-right" >
                        <label class="col-xs-1 control-label">网站域名</label>
                        <div class="col-xs-3">
                            <textarea class="form-control" rows="3" cols="60" id="domain" name="form[domain]" {% if site.domain is defined  %}readonly{% endif %} >{% if site.domain is defined  %}{{site.domain}}{% endif %}</textarea>
                        </div>
                    </div>
                    
                    <div class="form-group has-feedback text-right">
                        <label class="col-xs-1 control-label">网站logo</label>
                        <div class="col-xs-10 text-left">
                            <div style="{% if false == site.logo %} display:none; {% else %}display:inline-block;{% endif %}" class="goods-img-wrap">
                                <div style="{% if false == site.logo %} display:none; {% else %}display:inline-block;{% endif %}" class="goods-pic goods-img">
                                    <img src="{% if site.logo is defined  %}{{site.logo}}{% endif %}" />
                                    <input type="hidden" id="logo" name="form[logo]" value="{{site.logo}}" />
                                    <div class="goods-pic-operate">
                                        <i style="margin-right:10px;" class="glyphicon glyphicon-trash"></i>
                                        <i style="margin-right:10px;" class="glyphicon glyphicon-edit"></i>
                                        <i class="glyphicon glyphicon-arrow-right"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="goods-pic goods-pic-add" style="{% if false == site.logo %} display:block; {% else %}display:none;{% endif %}">
                                <i style="margin-top:40%;" class="glyphicon glyphicon-plus"></i>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group has-feedback" >
                        <label class="col-xs-1 control-label">SEO关键字</label>
                        <div class="col-xs-3">
                            <textarea class="form-control" rows="3" cols="60" id="seokey" name="form[seokey]">{% if site.seokey is defined  %}{{site.seokey}}{% endif %}</textarea>
                        </div>
                        <div class="col-xs-3 position"><i class="glyphicon glyphicon-info-sign"> 一般不超过100个字符，关键词用英文逗号隔开</i></div>
                    </div>
                    
                    <div class="form-group has-feedback" >
                        <label class="col-xs-1 control-label">SEO描述</label>
                        <div class="col-xs-3">
                            <textarea class="form-control" rows="3" cols="60" id="seodescr" name="form[seodescr]">{% if site.seodescr is defined  %}{{site.seodescr}}{% endif %}</textarea>
                        </div>
                        <div class="col-xs-3 position"><i class="glyphicon glyphicon-info-sign"> 一般不超过200个字符</i></div>
                    </div>
                    
                    <div class="form-group has-feedback text-right">
                        <label class="col-xs-1 control-label">版权信息</label>
                        <div class="col-xs-3">
                            <textarea class="form-control" required="true" rows="3" cols="60" name="form[copyright]">{% if site.copyright is defined  %}{{site.copyright}}{% endif %}</textarea>
                        </div>
                    </div>
                    
                    <div class="form-group has-feedback text-right" >
                        <label class="col-xs-1 control-label">访问统计代码</label>
                        <div class="col-xs-3">
                            <textarea class="form-control" rows="3" cols="60" name="form[static_code]">{% if site.static_code is defined  %}{{site.static_code}}{% endif %}</textarea>
                        </div>
                    </div>
                    
                    <div class="form-group has-feedback" >
                        <label class="col-xs-1 control-label">是否默认</label>
                        <div class="col-xs-3">
                        	<label class="radio-inline">
							  <input type="radio" name="form[is_main]" value="0" {% if site.is_main is defined and 0 == site.is_main %} checked="checked" {% endif %}> 是
							</label>
							<label class="radio-inline">
							  <input type="radio" name="form[is_main]" value="1" {% if site.is_main is defined and 1 == site.is_main %} checked="checked" {% elseif site.is_main is not defined %} checked="checked"{% endif %}> 否
							</label>
                        </div>
                    </div>
                    
                    <div class="form-group" style="margin-top:30px;">
                        <div class="col-sm-offset-1 col-sm-12">
                        	<input type="hidden" name="<?php echo $this->security->getTokenKey();?>" value="<?php echo $this->security->getToken();?>" />
                        	<input type="hidden" id="id" name="form[id]" value="{% if site.id is defined  %}{{site.id}}{% endif %}" />
                           	<input type="submit" value="提交" name="submit" id="submit" class="btn btn-info col-sm-3 col-xs-3" />
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
        <script src="/bootstrap/3.3.0/js/bootstrap.min.js"></script>
        <script src="/u/ueditor.config.js"></script>
        <script src="/u/ueditor.all.js"></script>
        <script type="text/javascript" charset="utf-8" src="/u/lang/zh-cn/zh-cn.js"></script>
        <script src="/js/fcmsIndex/iframeStyle.js"></script>
        <script type="text/javascript">
		/*------------图片添加-----------*/
		var _editor = UE.getEditor( 'upload_ue',{ 
			bizt:'user',
            serverUrl:'/common/upload/ctrl.php'
		} );
        
        _editor.ready( function () {
            _editor.hide();
            _editor.addListener('beforeInsertImage', function ( t, arg ) {     //侦听图片上传
				$( 'div.goods-img' ).find( 'img' ).attr( 'src' , arg[0].src );
            	$( 'div.goods-img' ).find( 'input[type="hidden"]' ).val( arg[0].src );
            	$( 'div.goods-img-wrap' ).show();
            	$( 'div.goods-img' ).show();
            	$( '.goods-pic-add' ).hide();
            	window.parent.iframeStyle( 0 );
            });
            _editor.setDisabled( [ 'insertimage' ]);
        });
        
		$( '.goods-pic-add' ).click( function(){ //图片的添加
			var myImage = _editor.getDialog("insertimage");
			myImage.open();
		});

        $( 'div.goods-pic-operate i.glyphicon-edit' ).click(function(){
    	    var myImage = _editor.getDialog("insertimage");
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
        $( 'input#submit' ).click( function(){
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
   		} ).keydown( function(){
   			$( "#submit" ).attr( 'disabled', false );
   		} );
       	
        function success( obj ){
        	obj.parents( 'div.form-group' ).removeClass( 'has-error' ).addClass( 'has-success' );
        }
        function error( obj ){
        	obj.parents( 'div.form-group' ).removeClass( 'has-success' ).addClass( 'has-error' );
        }
        </script>
       
    </body>
</html>
