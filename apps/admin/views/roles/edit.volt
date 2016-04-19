<!doctype html>
<html>
    <head>
        <link rel="stylesheet" href="/css/admin/base.css">
        <link rel="stylesheet" href="/bootstrap/3.3.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="/css/admin/font-awesome.min.css" >
        <link rel="stylesheet" href="/bootstrap/toastr/toastr.min.css">
        <style>
            dd{
                margin-left:50px;
            }
            dl{
                margin-bottom:10px;
            }
            dl label{
                width:105px;
            }
        </style>
    </head>
    <body class="wrap">
        <ul class="nav nav-tabs" role="tablist">
            <li role="presentation" class=""><a href="{{ url( 'admin/roles/index' ) }}">角色</a></li>
            <li role="presentation"class="active"><a href="#" >{% if role['id'] is empty %}添加角色{% else %}编辑角色{% endif %}</a></li>
        </ul>
        <div class="tab-content">
            <div role="tabpannel" class="tab-pane active" id="roleEdit" style="padding-top:20px;">
                {% if pris is not empty %}
                <form class="form-horizontal">
                    <div class="form-group has-feedback text-right">
                        <label class="col-xs-2 control-label">角色名</label>
                        <div class="col-xs-3">
                            <input class="form-control" type="text" name="roleName" id="roleName" maxlength="20" placeholder="请输入角色名" value="{% if role[ 'name' ] is not empty %}{{ role[ 'name' ] | e }}{% endif %}">
                        </div>
                    </div>
                    <div class="form-group has-feedback text-right">
                        <label class="col-xs-2 control-label">角色描述</label>
                        <div class="col-xs-3">
                            <input class="form-control" type="text"  name="roleDescr" id="roleDescr" placeholder="请输入角色描述" value="{% if role[ 'descr' ] is not empty %}{{ role[ 'descr' ] | e }}{% endif %}">
                        </div>
                    </div>
                    <div class="form-group has-feedback text-right">
                        <label class="col-xs-2 control-label">权限项</label>
                         <div class="col-xs-10 text-left" id="selectRole">
                            <dl>
                                <dt>
                                	<label class="checkbox-inline">
                                		<input class="allSelect" type="checkbox" value="">全选
                                	</label>
                                </dt>
                            </dl>
                            {% if pris is not empty %}
                            {% for first in pris[1] %}
                            <dl class="all_authorities">
                                <dt> 
                                    <label class='checkbox-inline first'>
                                        <input type="checkbox" class="first" name="pris[]" value="{{ first[ 'id' ] | escape_attr }}" 
                                               {% if rolePris[ first[ 'id' ] ] is not empty %}
                                               data-id="{{ rolePris[ first[ 'id' ]] | escape_attr }}" checked {% endif %}/>
                                        {{ first[ 'name' ] | e }}
                                    </label>
                                </dt>
                                {% if pris[ first[ 'id' ] ] is not empty %}
                                    {% for second in pris[ first[ 'id' ]] %}
                                    <dd>
										<label class="checkbox-inline second">
                                            <input type="checkbox" class="second" name="pris[]" value="{{ second[ 'id' ] | escape_attr }}"
                                                {% if rolePris[ second[ 'id' ] ] is not empty  %} 
                                                data-id="{{ rolePris[ second[ 'id' ]] | escape_attr }}" checked {% endif %}/>
												{{ second[ 'name' ] | e }}
										</label>
                                        <br>
                                        <span style="margin-left:3em"></span>
                                        {% if pris[ second[ 'id' ] ] is not empty %}
                                            {% for third in pris[ second[ 'id' ] ] %}
                                            <label class="checkbox-inline third">
                                                <input type="checkbox" class="third" name="pris[]" value="{{ third[ 'id' ] | escape_attr }}"
                                               {% if rolePris[ third[ 'id' ] ] is not empty  %} 
                                                data-id="{{ rolePris[ third[ 'id' ]] | escape_attr }}" checked {% endif %}/>
                                                {{ third[ 'name' ] | e }}
                                            </label>
                                            {% endfor %}
                                        {% endif %}
                                    </dd>
                                    {% endfor %}
                                {% endif %}
                            </dl>
                            {% endfor %}
                            {% endif %}
                        </div>
                    </div>
                    <div class="form-group" style="margin-top: 30px;">
                        <div class="col-sm-offset-2 col-sm-10">
                            <button type="button" class="btn btn-success btn-sm" id="roleSave" style="margin-right: 50px;width:70px;">保存</button>
                            <button type="button" class="btn btn-default btn-sm" id="cancel" style="width:70px;" >取消</button>
                           
                        </div>
                        <div class="col-xs-12 text-center loading"  style="margin-top:-20px; display:none;"> 
                            <i class="fa fa-pulse fa-spinner  fa-2x"  > </i>
                        </div>
                    </div>
                    <input type="hidden" id="roleId" name="roleId" value="{% if role['id'] is not empty %}{{ role['id'] | escape_attr }}{% endif %}" />
                </form>
                {% else %}
                <div class="col-xs-12 text-center text-danger">没有数据</div>
                {% endif %}
            </div>
        </div>
        <div class="alert alert-danger col-xs-2 text-center" style="position:fixed;bottom:0;margin-left:40%;display:none;">
            <span>网络错误</span>
        </div>
        <script src="/js/jquery/jquery-1.11.1.min.js"></script>
        <script src="/bootstrap/toastr/toastr.min.js"></script>
        <script>
            $( function(){
            	var iThirdLen = 0;
            	var iThirdCheckedLen = 0;
            	var iSecondLen = 0;
            	var iSecondCheckedLen = 0;
            	var iSecondHalfLen = 0;
            	//遍历所有的dl（即1级菜单）
            	$( 'div#selectRole dl.all_authorities' ).each( function(){
            		$( this ).find( 'dd' ).each( function(){
            			//三级对二级菜单的影响
            			iThirdLen = $( this ).find( 'input.third' ).size();
            			iThirdCheckedLen = $( this ).find( 'input.third:checked' ).size();
            			var $this = $( this ).find( 'input.second' );
            			if( 0 != iThirdLen ){//二级对应的三级菜单数不为0
            				if( iThirdLen == iThirdCheckedLen ){//全选对应二级
            					$this.prop( 'indeterminate', false );
            					$this.prop( 'checked', true );
            				}else if( 0 != iThirdCheckedLen && iThirdLen != iThirdCheckedLen ){//半选对应二级
            					$this.prop( 'checked', false );
            					$this.prop( 'indeterminate', true );
            				}else if( 0 === iThirdCheckedLen ){//不选对应二级
            					$this.prop( 'indeterminate', false );
            					$this.prop( 'checked', false );
            				}
            			}
            		} );
            		
            		/*-------------二级对一级菜单的影响---------------*/
        			iSecondLen = $( this ).find( 'input.second' ).size();
        			iSecondCheckedLen = $( this ).find( 'input.second:checked' ).size();
        			iSecondHalfLen = $( this ).find( 'input.second:indeterminate' ).size();
        			var $this = $( this ).find( 'dt > label > input.first' );
        			if( 0 != iSecondLen ){//一级对应的二级菜单数不为0
        				if( iSecondLen == iSecondCheckedLen ){//全选对应一级
        					$this.prop( 'indeterminate', false );
        					$this.prop( 'checked', true );
        				}else if( 0 !== ( iSecondCheckedLen + iSecondHalfLen ) && iSecondLen != iSecondCheckedLen ){//半选对应一级
        					$this.prop( 'checked', false );
        					$this.prop( 'indeterminate', true );
        				}else if( 0 === ( iSecondCheckedLen + iSecondHalfLen ) ){//不选对应一级
        					$this.prop( 'indeterminate', false );
        					$this.prop( 'checked', false );
        				}
        			}
            	} );
            	
            	/*-------------表单全选---------------*/
    			var iFirstLen = $( '.all_authorities input.first' ).size();
    			var iFirstCheckedLen = $( '.all_authorities input.first:checked' ).size();
    			var iFirstHalfLen = $( '.all_authorities input.first:indeterminate' ).size();
   				if( iFirstLen == iFirstCheckedLen ){//全选总选按纽
   					$( 'input.allSelect' ).prop( 'indeterminate', false );
   					$( 'input.allSelect' ).prop( 'checked', true );
   				}else if( 0 !== ( iFirstCheckedLen + iFirstHalfLen ) && iFirstLen != iFirstCheckedLen ){//半选总选按钮
   					$( 'input.allSelect' ).prop( 'checked', false );
   					$( 'input.allSelect' ).prop( 'indeterminate', true );
   				}else if( 0 === ( iFirstCheckedLen + iFirstHalfLen ) ){//不选总选按钮
   					$( 'input.allSelect' ).prop( 'indeterminate', false );
   					$( 'input.allSelect' ).prop( 'checked', false );
   				}
            	
                /*-------------表单数据验证---------------*/
                $( ':text' ).blur( function(){
                    var objParent = $( this ).parents( '.form-group' );
                    objParent.find( 'span' ).remove();
                    var value = $( this ).val();
                    if( value ){
                        success( objParent );
                    }else{
						error( objParent );
					}
                });
                
                var csrf = { key: '{{ security.getTokenKey()}}', token: '{{ security.getToken()}}'};
                $( '#roleSave' ).click( function(){
            		$( ':text' ).blur(); //重新检验一下数据
                    
					if( ! $( ':checked').length ){
                        toastr.error( '请选择权限项' );
                        return false;
                    }
                    
                    if( ! $( 'form span' ).hasClass( 'glyphicon-remove') ){//数据正确可以提交表单了
                       
                        var roleName = $( '#roleName' ).val(),roleDescr = $( '#roleDescr' ).val();
                        var roleId = $( '#roleId' ).val();
                        var url = roleId ? '/admin/roles/update' : '/admin/roles/insert';
                        
                        recordCheck(); //变化的权限
                        var data = { roleId: roleId, add: add, del: del, roleName: roleName, roleDescr: roleDescr };
                        data = $.extend( csrf,data);
                        $( this ).attr( 'disabled', 'disabled' ); //防止重复提交
                        var _this = this;
                        $( '.loading' ).show();
                        
                        $.post( url, data, function( ret ){
                            if( ! ret.status ){
                                location = '/admin/roles/index';
                            }else{
                                toastr.error(  ret.msg, '', { positionClass: 'toast-bottom-right'} );
                                $( '.loading' ).hide();
                                $( _this ).removeAttr( 'disabled' ); //防止重复提交
                            }
                            csrf = { key: ret.key, token: ret.token };
                        }, 'json').error( function(){
                            toastr.error( '网络不通' );
                        } );
                    }
					return false;
                });
                
                /* ----------取消---------------*/
                $( '#cancel' ).click( function(){
                     location = '/admin/roles/index';
                     return false;
                });
                
              	//所有checkbox数目（除了全选框）
				var allNums = $( ".all_authorities input[type='checkbox']" ).size();
				//所有被选中的checkbox数目（除了全选框）
				var selectedNums = '';
                
				/*-------------------角色全选-------------------*/
				$( '.allSelect' ).click( function(){
					var checked = $( this ).prop( 'checked' ); 
					$( ':checkbox' ).prop( 'indeterminate', false );
					$( ':checkbox' ).prop( 'checked', checked );
					
					selectedNums = $( ".all_authorities input[type='checkbox']:checked" ).size() + $( ".all_authorities input[type='checkbox']:indeterminate" ).size();
				} );
                
                /*-----------一级角色的选择------------*/
                $( '#selectRole' ).delegate( 'input.first', 'change', function(){
                     var second = $( this ).parents( 'dl' ).find( '.second' );
                     if( second ){//不存在
						var checked  = $( this ).prop( 'checked' );
						second.prop( 'indeterminate', false );
						second.prop( 'indeterminate', false ).prop( 'checked', checked );
						var third = second.parents( 'dd' ).find( '.third' );
                        
						if( third ){
							third.each( function(){
								$( this ).prop( 'indeterminate', false );
								$( this ).prop( 'checked', checked );
							} );
						}
					}
                    selectedNums = $( ".all_authorities input[type='checkbox']:checked" ).size() + $( ".all_authorities input[type='checkbox']:indeterminate" ).size();
				});
                
                /*-----------二级角色的选择------------*/
                $( '#selectRole' ).delegate( 'input.second', 'change', function(){
                	var $this = $( this );
					var allSecondNums = selectItems( $this, 'dl', 'dd input.second' ).size();
					var selectedSecondNums = selectItems( $this, 'dl', 'dd input.second:checked' ).size() + selectItems( $this, 'dl', 'dd input.second:indeterminate' ).size();
					var selectedWholeSecondNums = selectItems( $this, 'dl', 'dd input.second:checked' ).size();
					var selectedHalfSecondNums = selectItems( $this, 'dl', 'dd input.second:indeterminate' ).size();
					                        
					if( selectedWholeSecondNums == allSecondNums ){
						selectItems( $this, 'dl', '.first' ).prop( 'indeterminate', false );
						selectItems( $this, 'dl', '.first' ).prop( 'checked', true ); //选中对应一级
					}else if( selectedWholeSecondNums != allSecondNums && 0 != selectedSecondNums ){
						selectItems( $this, 'dl', '.first' ).prop( 'checked', false ); 
						selectItems( $this, 'dl', '.first' ).prop( 'indeterminate', true ); //半选对应一级
					}else if( 0 == selectedSecondNums ){
						selectItems( $this, 'dl', '.first' ).prop( 'indeterminate', false );
						selectItems( $this, 'dl', '.first' ).prop( 'checked', false ); //取消对应一级
					}
					var third = $( this ).parents( 'dd' ).find( '.third' );
					
					if( third ){
					    var checked  = $( this ).prop( 'checked' );
					    third.each( function(){
					    	$( this ).prop( 'indeterminate', false );
					        $( this ).prop( 'checked', checked );
					    })
					}
					
					selectedNums = $( ".all_authorities input[type='checkbox']:checked" ).size() + $( ".all_authorities input[type='checkbox']:indeterminate" ).size();
				} );
                
				/*-----------三级角色的选择------------*/
				$( '#selectRole' ).delegate( 'input.third', 'change', function(){
					var $this = $( this );
					var checked  = $( this ).prop( 'checked');
					var allThirdNums = selectItems( $this, 'dd', 'label' ).size() - 1;
					var selectedThirdNums = selectItems( $this, 'dd', 'input.third:checked' ).size();
					if( allThirdNums == selectedThirdNums ){
						selectItems( $this, 'dd', 'input.second' ).prop( 'indeterminate', false );
						selectItems( $this, 'dd', 'input.second' ).prop( 'checked', true ); //选中对应二级
					}else if( 0 == selectedThirdNums ){
						selectItems( $this, 'dd', 'input.second' ).prop( 'indeterminate', false );
						selectItems( $this, 'dd', 'input.second' ).prop( 'checked', false ); //取消对应二级
					}else{
						selectItems( $this, 'dd', 'input.second' ).prop( 'checked', false ); 
						selectItems( $this, 'dd', 'input.second' ).prop( 'indeterminate', true ); //半选对应二级
					}
					
					var allSecondNums = selectItems( $this, 'dl', 'dd input.second' ).size();
					var selectedSecondNums = selectItems( $this, 'dl', 'dd input.second:checked' ).size() + $( this ).parents( 'dl' ).find( '.second:indeterminate' ).size();
					var selectedWholeSecondNums = selectItems( $this, 'dl', 'dd input.second:checked' ).size();
					var selectedHalfSecondNums = selectItems( $this, 'dl', 'dd input.second:indeterminate' ).size();
					if( selectedWholeSecondNums == allSecondNums ){
						selectItems( $this, 'dl', '.first' ).prop( 'indeterminate', false );
						selectItems( $this, 'dl', '.first' ).prop( 'checked', true ); //选中对应一级
					}else if( selectedWholeSecondNums != allSecondNums && 0 != selectedSecondNums ){
						selectItems( $this, 'dl', '.first' ).prop( 'checked', false ); 
						selectItems( $this, 'dl', '.first' ).prop( 'indeterminate', true ); //半选对应一级
					}else if( 0 == selectedSecondNums ){
						selectItems( $this, 'dl', '.first' ).prop( 'indeterminate', false );
						selectItems( $this, 'dl', '.first' ).prop( 'checked', false ); //取消对应一级
					}
					
					selectedNums = $( ".all_authorities input[type='checkbox']:checked" ).size() + $( ".all_authorities input[type='checkbox']:indeterminate" ).size();
				} );
                
                /*-----------1、2、3级选框对总选框的影响------------*/
                $( '#selectRole' ).delegate( 'input.first,input.second,input.third', 'change', function(){
                	if( selectedNums == 0 ){
                		$( ".allSelect" ).prop( "indeterminate", false );
                		$( ".allSelect" ).prop( "checked", false );
                	}else if( selectedNums != allNums ){
                		$( ".allSelect" ).prop( "checked", false );
                		$( ".allSelect" ).prop( "indeterminate", true );
                	}else if( selectedNums == allNums ){
                		$( ".allSelect" ).prop( "indeterminate", false );
                		$( ".allSelect" ).prop( "checked", true );
                	}else{
                		$( ".allSelect" ).prop( "checked", false );
                		$( ".allSelect" ).prop( "indeterminate", true );
                	}
                } );
            });
            
            /*------------封装选择器-------------*/
			function selectItems( $this, parents, find ){
				return $this.parents( parents ).find( find );
            }
            
            function success( obj )
            {
                 obj.addClass( 'has-success').removeClass('has-error');
                 obj.find('.form-control').after( '<span class="glyphicon glyphicon-ok form-control-feedback"></span>' );
     
            }
            function error( obj )
            {
                 obj.addClass( 'has-error').removeClass('has-success');
                 obj.find('.form-control').after( '<span class="glyphicon glyphicon-remove form-control-feedback"></span>' );
            }
            function errorMsg( msg )
            {
                $( '.alert span' ).text( msg );
                $( '.alert' ).show().fadeOut( 3000 );
            }
            
            /*-------------记录当前更改---------------*/
            var  del = [], add = [];
            function recordCheck( ){
                $( ':checkbox' ).each( function() {
                    var priId = $( this ).val(), id = $( this ).attr( 'data-id' );//id中间表id
                    var checked = $( this ).prop( 'checked' ), indeterminate = $( this ).prop( 'indeterminate' );
                    var isAdd = checked || indeterminate;
                    var delIndex =  del.indexOf( id ), addIndex =  add.indexOf( priId );      //del 存的中间表id, add 里面存的是 priId
                    
                    if( !priId ) //权限id 不能为空
                    {
                       return true;
                    }
                    if( id  && ( ! isAdd ) &&　 delIndex === -1　) //老的 删除
                    {
                        del.push( id );
                    }
                    if( id  && ( isAdd  ) &&　 delIndex !== -1　) //老的 添加
                    {
                        del.splice( delIndex, 1 );
                    }
                    else if( ( ! id ) && ( ! isAdd ) && addIndex !== -1 ) //新的 删除
                    {
                        add.splice( addIndex, 1 );
                    }
                    else if( ( ! id) && isAdd && addIndex === -1 ) //新的 添加
                    {
                        add.push( priId );
                    }   
                });
            };
        </script>
    </body>
</html>