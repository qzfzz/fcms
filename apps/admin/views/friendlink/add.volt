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
            .input_name{
				width:120px;
            }
            .input_content{
            	min-width:100px;
				max-width:350px;
            }
            
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
            <li role="presentation" ><a href="/admin/friendlink/index">友情链接</a></li>
            <li role="presentation" class="active"><a href="#friendLink">{% if res.id is defined  %}修改友情链接{% else %}添加友情链接{% endif %}</a></li>
        </ul>
        <div class="tab-content">
            <div role="tabpannel" class="tab-pane active" id="friendLink" style="padding-top:20px;">
                <form class="form-horizontal" method="post" action="/admin/friendlink/save" onsubmit="return checkInput()">
                    <div class="form-group has-feedback text-right" >
                        <label class="col-xs-1 control-label input_name">链接名称</label>
                        <div class="col-xs-3">
                            <input class="form-control input_content" type="text" id="name" name="form[name]" required="required" value="{% if res.name is defined  %}{{res.name}}{% endif %}" />
                        </div>
                    </div>
                    
                    <div class="form-group has-feedback text-right" >
                        <label class="col-xs-1 control-label input_name">窗口标题</label>
                        <div class="col-xs-3">
                            <input class="form-control input_content" type="text" id="title" name="form[title]" value="{% if res.title is defined  %}{{res.title}}{% endif %}" />
                        </div>
                    </div>
                    
                    <div class="form-group has-feedback text-right" >
                        <label class="col-xs-1 control-label input_name">链接位置</label>
                        <div class="col-xs-2">
                        	<select class="form-control" id="urltype" name="form[urltype]" >
                       			<option value="0" {% if res.urltype is defined and res.urltype === '0' %}selected{% endif %}>站内链接</option>
                       			<option value="1" {% if res.urltype is defined and res.urltype === '1' %}selected{% endif %}>站外链接</option>
                        	</select>
                        </div>
                    </div>
                    
                    <div class="form-group has-feedback text-right" >
                        <label class="col-xs-1 control-label input_name">链接地址</label>
                        <div class="col-xs-3">
                            <input class="form-control input_content" type="text" id="url" name="form[url]" value="{% if res.url is defined %}{{ res.url | escape_attr }}{% endif %}" />
                        </div>
                        <span class="col-xs-3 text-left alertMsg" style="height:34px;line-height:34px;color:#BA4442;"></span>
                    </div>
                    
                    <div class="form-group has-feedback text-right" >
                        <label class="col-xs-1 control-label input_name">打开方式</label>
                        <div class="col-xs-2">
                            <select name="form[target]" class="form-control">
                            	<option value="0" {% if res.target is defined and 0==res.target %}selected{% endif %}>新标签页打开</option>
                            	<option value="1" {% if res.target is defined and 1==res.target %}selected{% endif %}>本窗口打开</option>
                            </select>
                        </div>
                    </div>
                    
                    <div class="form-group has-feedback text-right" >
                        <label class="col-xs-1 control-label input_name">logo</label>
                        <div class="col-xs-3 text-left">
                        	<div style="{% if res.icon is defined %} display:inline-block; {% else %}display:none;{% endif %}" class="goods-img-wrap">
                                <div style="{% if res.icon is defined %} display:inline-block; {% else %}display:none;{% endif %}" class="goods-pic goods-img">
                                    <img src="{% if res.icon is defined %}{{ res.icon }}{% endif %}">
                                    <input type="hidden" id="icon" class="form-control input_content" name="form[icon]" value="{% if res.icon is defined and false != res.icon %}{{res.icon}}{% endif %}">
                                    <div class="goods-pic-operate">
                                        <i style="margin-right:10px;" class="glyphicon glyphicon-trash"></i>
                                        <i style="margin-right:10px;" class="glyphicon glyphicon-edit"></i>
                                        <i class="glyphicon glyphicon-arrow-right"></i>
                                    </div>
                                </div>
                            </div>
          					<div class="goods-pic goods-pic-add" style="{% if res.icon is defined %}display:none;{% else %}display:block;{% endif %}">
                                <i style="margin-top:40%;" class="glyphicon glyphicon-plus"></i>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-group has-feedback" >
                        <label class="col-xs-1 control-label input_name text-right">是否允许抓取</label>
                        <div class="col-xs-3">
                        	<label class="radio-inline">
							    <input type="radio" name="form[nofollow]" value="0" {% if res.nofollow is defined and 0 == res.nofollow %} checked="checked" {% endif %}> 不允许
							</label>
							<label class="radio-inline">
							    <input type="radio" name="form[nofollow]" value="1" {% if res.nofollow is defined and 1 == res.nofollow %} checked="checked" {% elseif res.nofollow is not defined %} checked="checked"{% endif %}> 允许
							</label>
                        </div>
                    </div>
                    
                    <div class="form-group has-feedback text-right" >
                        <label class="col-xs-1 control-label input_name">排序</label>
                        <div class="col-xs-2">
                            <input class="form-control input_content" type="text" id="sort" name="form[sort]" value="{% if res.sort is defined  %}{{res.sort}}{% else %}50{% endif %}" />
                        </div>
                    </div>
                    
                    <div class="form-group" style="margin-top: 30px;">
                        <div class="col-sm-offset-1 col-sm-10">
                        	<input type="hidden" name="<?php echo $this->security->getTokenKey();?>" value="<?php echo $this->security->getToken();?>" />
                        	<input class="input_content" type="hidden" name="form[id]" value="{% if res.id is defined  %}{{res.id}}{% endif %}" />
                            <button type="submit" class="btn btn-success btn-sm" style="margin-right: 50px;width:70px;" id="has_submit">保存</button>
                            <button type="button" class="btn btn-default btn-sm" style="width:70px;" onclick="javascript:location.href='/admin/friendlink/index'">取消</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        
        <div class="alert alert-danger text-center col-xs-2" style="position:fixed; bottom:0; margin-left:40%;display:none;">
            <span>网络错误</span>
        </div>
		
     	<script type="text/plain" id="upload_ue" style="display:none;"></script>
        <script src="/js/jquery/jquery-1.11.1.min.js"></script>
        <script src="/u/ueditor.config.js"></script>
        <script src="/u/ueditor.all.js"></script>
        <script type="text/javascript" charset="utf-8" src="/u/lang/zh-cn/zh-cn.js"></script>
        <script src="/bootstrap/3.3.0/js/bootstrap.min.js"></script>
        <script src="/js/fcmsIndex/iframeStyle.js"></script>
        
        <script type="text/javascript">
        /*---------------图片添加-------*/    
        var _editor = UE.getEditor('upload_ue',{ 
  			bizt:'user',//上传到的文件夹名 Upload->image->logo,
            serverUrl:'/common/upload/ctrl.php'
         });
        
         _editor.ready(function () {
            _editor.hide();
 			_editor.addListener( 'beforeInsertImage', function( t, arg ){ //侦听图片上传
 				$( 'div.goods-img' ).find( 'img' ).attr( 'src' , arg[ 0 ].src );
             	$( 'div.goods-img' ).find( 'input[type="hidden"]' ).val( arg[ 0 ].src );
             	$( 'div.goods-img' ).show();
             	$( 'div.goods-img-wrap' ).show();
             	$( '.goods-pic-add' ).hide();
 				window.parent.iframeStyle( 0 );
             } );
             _editor.setDisabled( [ 'insertimage' ] );
		});
       	 
		/*-----------------图片点击操作--------------------*/
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
        
 		
        $( function(){
    		$( 'input, select' ).keydown( function(){
    			$( '#has_submit' ).removeAttr( 'disabled' );
    		} ).change( function(){
    			$( '#has_submit' ).removeAttr( 'disabled' );
    		} );
    	} );
        
        var urltype = $( '#urltype' ).val();
        
        $( '#urltype' ).change( function(){
        	urltype = $( '#urltype' ).val();
        	var obj = $( '#url' ).parents( 'div.form-group' );
        	clear( obj );
			successAlert( obj );
        } );
        
        $( '#url' ).blur( function(){
    		var url = $( 'input#url' ).val();
    		var urlPattern = /^(((https|http|ftp|rtsp|mms){1}\:\/\/)|(\/))?[\d\w\-]{1,}([\.\/\?\&\=]{1}[\d\w\-]{1,}){1,}$/;
            var outerPattern = /^((https|http|ftp|rtsp|mms){1}\:\/\/){1}/;
            var innerPattern = /^\/[^\/]{1,}/;//以/开头
    		var obj = $( '#url' ).parents( 'div.form-group' );
    		if( url ){//如果有数据
    			if( !urlPattern.test( url ) ){
        			error( obj );
    				errorAlert( obj, 'url格式不正确' );
    				return;
        		}else{
        			if( 1 == urltype ){//如果是站外链接
            			if( !outerPattern.test( url ) ){//如果url中没有头，则默认加上http://
            				if( innerPattern.test( url ) ){
            					$( 'input#url' ).val( 'http:/' + url );
            				}else{
	            				$( 'input#url' ).val( 'http://' + url );
            				}
            				clear( obj );
            				successAlert( obj );
            			}
            		}else{//如果是站内链接
            			if( innerPattern.test( url ) ){//如果url中有http://头，则提示删掉
            				clear( obj );
            				successAlert( obj );
            			}else{
            				error( obj );
            				errorAlert( obj, '站内链接只能以/开头，且不能只有/' );
            			}
            		}
        		}
    		}else{//如果URL为空
    			error( obj );
				errorAlert( obj, 'url不能为空' );
    		}
        } );
        
    	$( '#has_submit' ).click( function(){
    		$( '#url' ).blur();
    		if( !$( 'div.form-group' ).hasClass( 'has-error' ) ){
    			$( '#has_submit' ).attr( 'disabled', 'true' );
    		}
    	} );
    	
    	function checkInput(){
    		if( $( 'div.form-group' ).hasClass( 'has-error' ) ){
    			return false;
    		}else{
    			return true;
    		}
    	}
    	
    	function success( obj ){
			obj.addClass( 'has-success' ).removeClass( 'has-error' );
	    }
	    
	    function error( obj ){
	        obj.addClass( 'has-error' ).removeClass( 'has-success' );
	    }
	    
	    function clear( obj ){
	    	obj.removeClass( 'has-error' ).removeClass( 'has-success' );
	    }
	    	    
	    function successAlert( obj ){
	    	obj.find( '.alertMsg' ).empty();
	    }
	    
	    function errorAlert( obj, msg ){
	    	obj.find( '.alertMsg' ).html( msg );
	    }
    	
        </script>
    </body>
</html>
