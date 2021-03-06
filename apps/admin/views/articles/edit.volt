<!doctype html>
<html>
    <head>
        <link rel="stylesheet" href="/css/admin/base.css">
        <link rel="stylesheet" type="text/css" href="/bootstrap/3.3.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="/bootstrap/datetimepicker/bootstrap-datetimepicker.min.css">
        <link rel="stylesheet" type="text/css" href="/bootstrap/toastr/toastr.min.css">
        <style>

            .articles-pic-operate {
                position:absolute;bottom: 0; width:100%; text-align: center;background:gainsboro; display:none;
            }
             .col-xs-2 {
                padding-right: 0;
            }
			div#d_tag2{
			   float: left;
			    left: 20px;
			    position: absolute;
			    top: 4px;
			    z-index: 101;
                 	}
			#d_tag2 p {
			    background-color: #ffffcc;
			    border: 1px solid #ccc;
			    border-radius: 5px;
			    cursor: default;
			    display: inline-block;
			    margin-right: 4px;
			    padding: 1px 4px;
			}
			#tag2box {
			    border: 1px solid #ffcccc;
			    border-radius: 4px;
			    margin-top: 1px;
			    padding: 10px;
			   	width: 100%;
			}
			#tag2box a {
			    border: 1px solid #ccc;
			    border-radius: 5px;
			    cursor: pointer;
			    display: block;
			    float: left;
			    margin: 0 10px 10px 0;
			    padding: 4px 6px;
			}
			a {
			    color: #3b5998;
			    text-decoration: none;
			}
			#tag2box a:hover {
			    background-color: #eee;
			    text-decoration: none;
			}
			#tag2box a.act {
			    background-color: #ffffcc;
			}
			#tag2box th {
			    font-weight: normal;
			    padding-top: 4px;
			    vertical-align: top;
			    width: 80px;
			}
			#d_tag2 {
			    float: left;
			    left: 4px;
			    position: absolute;
			    top: 2px;
			    z-index: 101;
			}
			#d_tag2 span {
			    background-color: #ffffcc;
			    border: 1px solid #ccc;
			    border-radius: 5px;
			    cursor: default;
			    display: inline-block;
			    margin-right: 4px;
			    padding: 2px 4px;
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
            .goods-address div.col-xs-2 {
                padding-right:0;
            }
			.hide{
				display:none;
            }
        </style>
    </head>
    <body class="wrap">
        <ul class="nav nav-tabs" role="tablist" id="tabs">
            <li role="presentation"><a href="/admin/articles/index">文章</a></li>
            <li role="presentation" class="active"><a href="#articleEdit" >编辑文章</a></li>
            <li role="presentation" id="artcontent"><a href="#articleContent">编辑文章内容</a></li>
        </ul>
        <div class="tab-content">
        
            <div role="tabpannel" class="tab-pane active" id="articleEdit" style="padding-top:20px;">
                <form class="form-horizontal">
                    <div class="form-group has-feedback text-right">
                        <label class="col-xs-2 control-label">文章分类</label>
                        <div class="col-xs-2">
                            <select class="form-control" id="categoryId" name="categoryId" value="" required="required">
                               {% if categorys is not empty %}
                                {% for first in categorys %}
                                <option value="{{ first[ 'id' ] | e }}" 
                                {% if article[ 'cat_id' ] == first[ 'id'] %} selected {% endif %}>{{ first[ 'name' ] | e }}</option>
                                {% if first[ 'sub' ] is defined %}
                                    {% for second in first[ 'sub' ] %}
                                        <option value="{{ second[ 'id' ] | e }}" style="padding-left:20px;" 
                                        {% if article[ 'cat_id' ] == second[ 'id'] %} selected {% endif %} >--{{ second[ 'name' ] | e }}</option>
                                        {% if second[ 'sub' ] is defined %}
                                            {% for third in second[ 'sub' ] %}
                                            <option value="{{ third[ 'id' ] | e }}" style="padding-left:40px;" 
                                            {% if article[ 'cat_id' ] == third[ 'id'] %} selected {% endif %} >---{{ third[ 'name' ] | e }}</option>
                                            {% endfor %}
                                        {% endif %}
                                    {% endfor %}
                                {% endif %}
                                {% endfor %}
                                {% endif %}
                            </select>
                        </div>
                    </div>
                    <div class="form-group has-feedback text-right">
                        <label class="col-xs-2 control-label">文章标题</label>
                        <div class="col-xs-3">
                            <input class="form-control" type="text" id="title" name="title" placeholder="请输入文章标题" required="required" value="{{ article[ 'title' ] | escape_attr }}"/>
                        </div>
                    </div>
                    
                    <div class="form-group has-feedback text-right">
                        <label class="col-xs-2 control-label">文章封面</label>
                         <div class="col-xs-10 text-left">
                            <div style="{% if false == article[ 'face' ] %} display:none; {% else %}display:inline-block;{% endif %}" class="goods-img-wrap">
                                <div style="{% if false != article[ 'face' ] %} display:block; {% else %}display:none;{% endif %}" class="goods-pic goods-img">
                                    <img src="{{ article[ 'face' ]}}">
                                    <input type="hidden" id="face" name="face" value="{{ article[ 'face' ]}}">
                                    <div class="goods-pic-operate">
                                        <i style="margin-right:10px;" class="glyphicon glyphicon-trash"></i>
                                        <i style="margin-right:10px;" class="glyphicon glyphicon-edit"></i>
                                        <i class="glyphicon glyphicon-arrow-right"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="goods-pic goods-pic-add" style="{% if false == article[ 'face' ] %} display:block; {% else %}display:none;{% endif %}">
                                <i style="margin-top:40%;" class="glyphicon glyphicon-plus"></i>
                            </div>
                        </div>
                    </div>
                  
                    <div class="form-group has-feedback text-right">
                        <label class="col-xs-2 control-label">文章关键字</label>
                        <div class="col-xs-3">
                            <input class="form-control" type="text" id="keywords" name="keywords" placeholder="请输文章关键字" value="{{ article[ 'keywords' ] | escape_attr }}"/>
                        </div>
                    </div>
                   
                     <div class="form-group has-feedback text-right" >
                        <label class="col-xs-2 control-label">文章描述</label>
                        <div class="col-xs-3">
                            <textarea class="form-control" cols='2' type="text" id="description" name="description"  >{{ article[ 'description' ] | e }}</textarea>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="col-xs-2 control-label">发布时间</label>
                        <div class="col-xs-2">
                        	<input class="form-control"  type="text" id="pubtime" name="pubtime" value="{{ article[ 'pubtime' ] | escape_attr }}" />
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="col-xs-2 control-label"> 是否置顶</label>
                        <div class="col-xs-8">
                            <label class="radio-inline"><input type="radio" name="top" value="1" {% if article[ 'top'] %} checked {% endif %} />是</label>
                            <label class="radio-inline"><input type="radio" name="top" value="0" {% if ! article[ 'top' ] %} checked {% endif %}/>否</label>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label class="col-xs-2 control-label">文章标签</label>
                        <div class="col-xs-5">
                           <div id="d_tag2">
                           	{% if tags is defined and tags is not empty %}
                           		{% for item in tags %}
                           			<p title="单击删除该标签" onclick="removeBtn(this)">{{ item.name | e }}</p>
                           		{% endfor %}
                           	{% endif %}
                           </div>
                           <input type="text" class="form-control" name="tags" maxlength="100" onblur="splitValues( this );" onkeydown="delTagsBtn( this , event );" onfocus="showMoreInfo( this );" />
                           <input type="hidden" name="strtags" value="" />
                           <div id="tag2box"  style="display:none">
							<table>
								<tbody>
									<tr>
										<th>常用标签</th>
										<td id="td_tag21" class="tracking-ad" data-mod="popu_133">
										{% if alltags is defined and alltags is not empty %}
											{% for atags in alltags %}
				                           		<a target="_blank" class="" onclick="setTag2(this);return false;">{{ atags }}</a>
											{% endfor %}
										{% endif %}
										</td>
									</tr>
									<tr>
										<th>推荐标签</th>
										<td id="td_tag22" class="tracking-ad" data-mod="popu_73">
											
										</td>
									</tr>
								</tbody>
							</table>
						</div>
                        </div>
                        <p class="col-xs-3" style="margin-top:1%; padding:0;font-size: 12px;">（最多添加5个标签，多个标签之间用空格分隔） </p>
                    </div>
                    
                    <div class="form-group" style="margin-top: 30px;">
                        <div class="col-sm-offset-3 col-sm-10">
                        	<input type="hidden" id="articleId" name='articleId' value="{{ article[ 'id' ] | e }}"/>
                            <button type="button" class="btn btn-success btn-sm" id="articleUpdate" style="margin-right: 50px;width:70px;">保存</button>
                    		<button type="button" class="btn btn-default btn-sm" id="articleCancel" style="width:70px;">取消</button>
                        </div>
                    </div>
                </form>
            </div>
            
            <div role="tabpannel" class="tab-pane" id="articleContent" style="padding-top:20px;height:auto;" onresize="alert(2111);">
                <script type="text/plain" id="articleContentEdit" >{% if article is defined %} {{ article[ "content"] }}{% endif %}</script>
              
                <div class="col-sm-6 text-center" style="margin:30px 0">
                    <button type="button" class="btn btn-success btn-sm" id="articleContentSave" style="margin-right: 50px;width:70px;">保存</button>
                    <button type="button" class="btn btn-default btn-sm" id="articleContentCancel" style="width:70px;">取消</button>
                </div>
            </div>
        </div>
        
        <div class="alert alert-danger text-center col-xs-2" style="position:fixed; bottom:0; margin-left:40%;display:none;">
            <span>网络错误</span>
        </div>
        
        <script src="/js/jquery/jquery-1.11.1.min.js"></script>
        <script src="/u/ueditor.config.js"></script>
        <script src="/u/ueditor.all.js"></script>
        <script type="text/javascript" charset="utf-8" src="/u/lang/zh-cn/zh-cn.js"></script>
        <script src="/bootstrap/3.3.0/js/bootstrap.min.js"></script>
        <script src="/bootstrap/datetimepicker/bootstrap-datetimepicker.min.js"></script>
		<script src="/bootstrap/datetimepicker/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
        <script src="/bootstrap/toastr/toastr.min.js"></script>
        <script type="text/javascript">
		var submitId = false;
		var key = "<?php echo $this->security->getTokenKey();?>";
     	var token = "<?php echo $this->security->getToken();?>";
		/*---------------防止重复点击-------------*/
		$( 'input, select' ).change( function(){
			if( submitId ){
				submitId = false;
			}
		} ).keydown( function(){
			if( submitId ){
				submitId = false;
			}
		} );
        /*---------------图片添加-------*/    
		var _editor = UE.getEditor( 'articleContentEdit',{ 
            initialFrameWidth: 800,
            initialFrameHeight: 400,
            minFrameHeight: 400,
            initialStyle: 'body{font-size:12px}',
            topOffset: 200,
			bizt:'user',
            autoHeightEnabled:false,
            serverUrl:'/common/upload/ctrl.php'
		} );
        
        _editor.ready( function () {
            $( '#articleContent iframe').contents().find( 'body').attr( 'onresize', 'window.parent.parent.iframeStyle( 0 );');
            _editor.addListener('beforeInsertImage', function ( t, arg ) {     //侦听图片上传
                if( isCover )
                {
                    $( 'div.goods-img' ).find( 'img' ).attr( 'src' , arg[0].src );
                    $( 'div.goods-img' ).find( 'input[type="hidden"]' ).val( arg[0].src );
                    $( 'div.goods-img-wrap' ).show();
                    $( 'div.goods-img' ).show();
                    $( '.goods-pic-add' ).hide();
                    isCover = false;
                    return true;
                }
            });
        });
        var isCover = false;
		$( '.goods-pic-add' ).click( function(){ //图片的添加
			var myImage = _editor.getDialog("insertimage");
			myImage.open();
            isCover = true;
		});
        $( 'div.goods-pic-operate i.glyphicon-edit' ).click(function(){
    	    var myImage = _editor.getDialog("insertimage");
            myImage.open();
            isCover = true;
        });
        $( 'form' ).delegate( '.goods-img img', 'click', function(){ //图片修改
			var myImage = _editor.getDialog("insertimage");
			myImage.open();
			$( 'form' ).data( 'changePic', this );
            isCover = true;
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
	    	var paddLeft = document.getElementById( 'd_tag2' ).offsetWidth;
	    	$( 'input[name="tags"]' ).css( 'padding-left' , ( paddLeft + 5 ) + 'px' );
	        
	        /*--------------分页切换----------------------*/
	        $( '#tabs a' ).click( function( e ) {
	            if( $( this ).parent().index() === 0 ){ //第一个分页是商品列表
	                return;
	            }
	            e.preventDefault();
	            $( this ).tab( 'show' );
			} );
	          
	        /*-------------添加文章内容------------*/
	        $( '#articleContentSave' ).click( function() { 
	            var articleId = $( '#articleId' ).val();
	            if( !articleId ){
	                errorMsg( '请先添加文章' );
	                return false;
	            }
	            var articleContent = _editor.getContent();
	            if( ! articleContent ){
	                errorMsg( '请添加文章内容' );
	                return false;
	            }
	            $.post( '/admin/articles/saveArticle', { content : articleContent, articleId: articleId, key:key, token:token }, function( ret ) {
	                var objRet = eval( '(' + ret + ')' );
	                if( ! objRet.status )
	                {
	                    successMsg( objRet.msg );
	                    location.href = '/admin/articles/index';
	                }
	                else
	                    errorMsg( objRet.msg );
	                
	                key = objRet.key;
                    token = objRet.token;
                    
	            } ).error( function(){
	                errorMsg( '网络不通' );
	            } );
	        } );
	        
	        /*-------------文章取消   跳转到商品添加网页------------*/
			$( '#articleContentCancel,#articleCancel' ).click( function() { 
				location = '/admin/articles/index';
	            return false;
			} );
	       
	        /*-------------数据检验------------*/
	        $( ':text' ).blur( function(){
	            var objParent = $( this ).parents( '.form-group' );
	            objParent.find( 'span' ).remove();
	            var value = $( this ).val();
	            if ( !$( this ).attr( 'required') )
	                return false;
	            
	            if( value ){
	                success( objParent );
				}else{
					error( objParent );
				}
	        });
	        /*-----------添加文章-----------*/
	        $( '#articleUpdate' ).click( function(){
	        	if( !submitId ){
	        		$( ':text' ).blur(); //重新检验一下数据
		           if( ! $( '#categoryId' ).val() ){
		                errorMsg( '请选择分类' );
		                return false;
		            }
		           
		            if( ! $( 'form span' ).hasClass( 'glyphicon-remove') ){ //数据正确可以提交表单了
		            	var strTags = '';
		            	$( '#d_tag2 p' ).each( function(){
		            		strTags += $( this ).html() + ',';
		            	} );
		            	$( 'input[name="strtags"]' ).val( strTags );
		            	
		                var data = $( 'form' ).serialize();
		                data += '&key=' + key + '&token=' + token;
		                submitId = true;
		                $.post( '/admin/articles/update', data, function( ret ){
		                    if( ! ret.status )
		                    {
		                        $( '#articleId' ).val( ret.id ); //新添加的文章id 保存下
		                        successMsg( ret.msg );
		                    }
		                    else
		                        errorMsg( ret.msg );
		                    
		                    $( 'li#artcontent a' ).removeClass( 'hide' );
		                    $( 'li#artcontent' ).addClass( 'active' ).siblings( 'li' ).removeClass( 'active' );
		                    $( '#articleEdit' ).removeClass( 'active' );
		                    $( '#articleContent' ).addClass( 'active' );
		                    
		                    key = ret.key;
		                    token = ret.token;
		                }, 'json').error(function(){
		                    errorMsg( '网络不通' );
		                } );
		            }
		
		            return false;
	        	}
	        	else{
	        		toastr.error( '数据已提交，请勿重复点击！' );
	        	}
	        });
	       /* ----------取消---------------*/
	       $( '#cancel' ).click( function(){
	            location = '/admin/articles/index';
	            return false;
	       });
	       
	       /* ----------- 日历插件 ------------*/
	       $( '#pubtime' ).datetimepicker( {
	   			language: 'zh-CN',
	    	    autoclose: true,
	    	    todayBtn: true,
	    	    pickerPosition: "bottom-right",
	    	    format: 'yyyy-mm-dd HH:ii:ss',
	    	   	fontAwesome:true,
	   		} );
	       
	    });
	    
	    /*-----------隐藏tag ----------*/
	    $ ( document ).click( function( e ){
	        var target = $( e.target );
	        var pos = $( '#tag2box' ).parent( 'div' );
	        if( target.closest( pos ).length == 0 ){
	        	$( '#tag2box' ).hide();
	        }
	    } );
	    
	    function success( obj ){
	         obj.addClass( 'has-success').removeClass('has-error');
	         obj.find('.form-control').after( '<span class="glyphicon glyphicon-ok form-control-feedback"></span>' );
	    }
	    function error( obj ){
	         obj.addClass( 'has-error').removeClass('has-success');
	         obj.find('.form-control').after( '<span class="glyphicon glyphicon-remove form-control-feedback"></span>' );
	    }
	    function errorMsg( msg ){
	        $( '.alert' ).removeClass( 'alert-success' ).addClass( 'alert-danger' );
	        $( '.alert span' ).text( msg );
	        $( '.alert' ).show().fadeOut( 3000 );
	    }
	    function successMsg( msg ){
	        $( '.alert' ).addClass( 'alert-success' ).removeClass( 'alert-danger' );
	        $( '.alert span' ).text( msg );
	        $( '.alert' ).show().fadeOut( 3000 );
	    }
	    //设置tag
	    function splitValues( item ){
	    	//先判断tag是否已经超过设置
	    	var tagsLen = $( '#d_tag2 p' ).length;
	    	if( tagsLen >= 5 ){
	    		return false;
	    	}
	    	var strReplace = $.trim( item.value );
	    	var arrReplace = unique( strReplace.split( ' ' ) );
	    	var iLen = arrReplace.length;
	    	if( iLen > 0 ){
	    		var iHasNum = $( 'div#d_tag2 p' ).length;
	    		for( var i =0; i<iLen; i++ ){
	    			if( iHasNum++ < 5 && false != $.trim( arrReplace[i] ) ){
	      	    		$( '#d_tag2' ).append( '<p title="单击删除该标签" onclick="removeBtn( this )">'+ $.trim( arrReplace[i] ) +'</p>' );
	      	    		var oldStr = $( item ).next( 'input' ).val();
	      	    		var strWidth = document.getElementById( 'd_tag2' ).offsetWidth;
	      	    		$( item ).css( 'padding-left' , ( strWidth + 5 )+'px' );
	          		}
	    		}
	    	}
	    	
	    	$( item ).val( '' );
	    }
	    
	    //移除
	    function removeBtn( item ){
	    	var strTag = $.trim( $( '#d_tag2 p' ).last().html() );
			$( '#td_tag21 a' ).each(function(){
				if( $.trim( $(this).html() ) == strTag || $(this).hasClass( 'act' ) )
					$(this).removeClass( 'act' );
			} );
			
	    	var strItemWidth = $( item ).outerWidth();
	    	var strCurrWidth = $( 'input[name="tags"]' ).css( 'padding-left' );
	  		$( item ).parent().next( 'input[name="tags"]' ).css( 'padding-left' , parseInt( parseInt( strCurrWidth ) - strItemWidth ) + 'px' );
	    	$( item ).remove();
	    	$( item ).parent().next( 'input[name="tags"]' ).focus();
	    }
	    
	    //去重
	    function unique( arr ) 
	    {
	        var result = [], hash = {};
	        for (var i = 0, elem; (elem = arr[i]) != null; i++) {
	            if ( !hash[ elem ] ){
	                result.push(elem);
	                hash[elem] = true;
	            }
	        }
	        return result;
	    }
	    //删除键删除
	    function delTagsBtn( item , e )
	    {
	    	var iLen = $( '#d_tag2 p' ).length;
	    	if( 8 == e.keyCode && false != iLen ){
	    		var strTag = $.trim( $( '#d_tag2 p' ).last().html() );
	    		$( '#td_tag21 a' ).each(function(){
	    			if( $.trim( $(this).html() ) == strTag ||  $(this).hasClass( 'act' ) ){
	    				$(this).removeClass( 'act' );
	    			}
	    		} );
	    		var strItemWidth = $( '#d_tag2 p' ).last().outerWidth();
	        	var strCurrWidth = $( 'input[name="tags"]' ).css( 'padding-left' );
	      		$( item ).css( 'padding-left' , parseInt( parseInt( strCurrWidth ) - ( strItemWidth  + 3 ) ) + 'px' );
	      		$( '#d_tag2 p' ).last().remove();
	        	$( item ).focus();
	    	}
	    }
	    
	    function showMoreInfo( item ){
	    	$( '#tag2box' ).show();
	    }
	    
	    function setTag2( item ){
	    	//先判断tag是否已经超过设置
	    	var tagsLen = $( '#d_tag2 p' ).length;
	    	if( tagsLen >= 5 ){
	    		return false;
	    	}
	    	var isRemove = false;
	    	var clkItem = $.trim( $( item ).html() );
	    	$( '#d_tag2 p' ).each( function(){
	    		if( $.trim( $( this ).html() ) == clkItem )
	    			isRemove = true;
	    	} );
	    	
	    	if( $( item ).hasClass( 'act' ) || true == isRemove ){//移除
	    		var strRemove = $.trim( $( item ).html() );
				var strItemWidth;
				var strCurrWidth = $( '#tag2box' ).parent( 'div' ).find( 'input[name="tags"]' ).css( 'padding-left' );
				var removeIndex;
				$( '#d_tag2 p' ).each( function( index ){
					if( $.trim( $( this ).html() ) == strRemove ){
						strItemWidth = $( this ).outerWidth();
						removeIndex = index;
					}
				} );
	    		$( '#tag2box' ).parent( 'div' ).find( 'input[name="tags"]' ).css( 'padding-left' , parseInt( parseInt( strCurrWidth ) - ( strItemWidth  + 3 ) ) + 'px' );
				$( '#d_tag2 p:eq(' + removeIndex + ')' ).remove();
	        	$( item ).removeClass( 'act' );
			}else{
	  			if( false != $.trim( $( item ).html() )  ){
	  				$( '#d_tag2' ).append( '<p title="单击删除该标签" onclick="removeBtn(this)">'+ $.trim( $(item).html() ) +'</p>' );
	  	      		var strWidth = document.getElementById( 'd_tag2' ).offsetWidth;
	  	      		$( '#tag2box' ).parent( 'div' ).find( 'input[name="tags"]' ).css( 'padding-left' , ( strWidth + 5 )+'px' );
	  	      		$( item ).addClass( 'act' );
	  	    	}
	  		}
	    }
	    

    </script>
    </body>
</html>