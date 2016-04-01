<!doctype html>
<html>
    <head>
        <link rel="stylesheet" href="/css/admin/base.css">
        <link rel='stylesheet' href='/public/bootstrap/3.3.0/css/bootstrap.min.css'>
        <link rel="stylesheet" type="text/css" href="/bootstrap/toastr/toastr.min.css">
        <style>
            .input-group[ class*='col-'] {
                margin-right:10px;
                float:left;
            }
            button {
                width:70px;
            }
        </style>
    </head>
    <body class="wrap">
        <form class="form-horizontal" id="email">
            {% if email is defined %}
            <div class="col-xs-6">
                <div class="panel panel-warning">
                     <div class="panel-heading"><i class="glyphicon glyphicon-envelope" ></i>&nbsp; 邮箱</div>
                         <div class="panel-body text-center">
                        {% for item in email %}
                        <div class="form-group">
                            <label class="col-xs-2 control-label">{{ item[ 'title'] | e }}</label>
                            <div class="col-xs-10">
                                <div class="col-xs-4 input-group">
                                    <div class="input-group-addon"> k </div> 
                                    <input class="form-control key" type="text" name="keyArr[]" value="{{ item[ 'key'] | escape_attr }}">
                                </div>
                                <div class="col-xs-7 input-group" style="">
                                    <div class="input-group-addon"> v </div> 
                                    <input class="form-control value" type="text" name="valueArr[]" value="{{ item[ 'value'] | escape_attr }}">
                                </div>
                            </div>
                        </div>
                        {% endfor %}
                         </div>
                    </div>
            </div>
            {% endif %}
        </form>
        <div class="col-xs-offset-2 col-xs-6 text-center">
            <button class="btn btn-sm btn-success" id="saveEmail">保存</button>
        </div>

        <div class="alert alert-danger text-center col-xs-2" style="margin-left:50%;display:none;">
             <i class="glyphicon glyphicon-ok pull-left"></i>
            <span>网络错误</span>
        </div>
        <script src="/public/js/jquery/jquery-1.11.1.min.js"></script>
        <script src="/bootstrap/toastr/toastr.min.js"></script>
        <script>
		var key = "<?php echo $this->security->getTokenKey();?>";
        var token = "<?php echo $this->security->getToken();?>";
        
		$( function(){
			/*------------验证数据是否修改-----------*/
			var oldKey = oldValue = newKey = newValue = '';
	        $( 'input.key' ).each( function(){
	        	oldKey += $( this ).val();
	        } );
	        $( 'input.value' ).each( function(){
	        	oldValue += $( this ).val();
	        } );
    		/*------------保存数据-----------*/
			$( '#saveEmail' ).click( function(){
				$( 'input.key' ).each( function(){
		        	newKey += $( this ).val();
		        } );
		        $( 'input.value' ).each( function(){
		        	newValue += $( this ).val();
		        } );
		        if( oldKey == newKey && oldValue == newValue ){
		        	toastr.error( '数据未作修改，请修改后提交！' );
		        	newKey = newValue = '';
		        	return;
		        }else{
		        	oldKey = newKey;
		        	oldValue = newValue;
		        	newKey = newValue = '';
		        	var data = $( '#email' ).serialize();
					data += "&key="+key+"&token="+token;
					
		            $.post( '/admin/config/emailSave', data, function( ret ){
		                if( !ret.status ){
		                    successMsg( ret.msg );
		                }else{
		                    errorMsg( ret.msg );
		                }
		                key = ret.key;
		                token = ret.token;
		            }, 'json' ).error( function(){
						errorMsg( '网络不通' );
					});
		        }
			});
	    });
		
	    function errorMsg( msg )
	    {
	       $( '.alert span' ).text( msg );
	       $( '.alert' ).removeClass( 'alert-success' ).addClass( 'alert-danger' );
	       $( '.alert i' ).removeClass( 'glyphicon-ok' ).addClass( 'glyphicon-warning-sign' );
	       $( '.alert' ).show().fadeOut( 3000 );
	    }
	    function successMsg( msg )
	    {
	        $( '.alert span' ).text( msg );
	        $( '.alert' ).removeClass( 'alert-danger' ).addClass( 'alert-success' );
	        $( '.alert i' ).addClass( 'glyphicon-ok' ).removeClass( 'glyphicon-warning-sign' );
	        $( '.alert' ).show().fadeOut( 3000 );
	    }
</script>
    </body>
</html>