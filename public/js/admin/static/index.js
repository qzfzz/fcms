//主配置项 js

$(function(){
	/*-----------防止重复点击----------*/
	$( '#btnBase' ).click( function(){
		$( this ).attr( 'disabled', 'disabled' );
	} );
	$( 'tr.basic_conf input' ).keydown( function(){
		$( '#btnBase' ).removeAttr( 'disabled' );
	} ).change( function(){
		$( '#btnBase' ).removeAttr( 'disabled' );
	} );
	
	$( '#btnDriver' ).click( function(){
		$( this ).attr( 'disabled', 'disabled' );
	} );
	$( 'tr.driver_conf input' ).keydown( function(){
		$( '#btnDriver' ).removeAttr( 'disabled' );
	} ).change( function(){
		$( '#btnDriver' ).removeAttr( 'disabled' );
	} );
	
	$( '#btnStorage' ).click( function(){
		$( this ).attr( 'disabled', 'disabled' );
	} );
	$( 'tr.storage_conf input' ).keydown( function(){
		$( '#btnStorage' ).removeAttr( 'disabled' );
	} ).change( function(){
		$( '#btnStorage' ).removeAttr( 'disabled' );
	} );
	/*-----------防止重复点击结束----------*/
	
	
 	$( 'input[name="column"]' ).each(function(){
 		if( iColumnIndex ==  $(this).val() )
 			$(this).attr( 'checked' , true ).siblings().removeAttr( 'checked' );
 	});
 	$( 'input[name="list"]' ).each(function(){
 		if( iColumnList ==  $(this).val() )
 			$(this).attr( 'checked' , true ).siblings().removeAttr( 'checked' );
 	});
 	$( 'input[name="detail"]' ).each(function(){
 		if( iColumnDetail ==  $(this).val() )
 			$(this).attr( 'checked' , true ).siblings().removeAttr( 'checked' );
 	});
 	//点击设置 checked 属性
 	$( 'input[name="column"]' ).click(function(){
 		$(this).attr( 'checked' , true ).siblings().removeAttr( 'checked' );
 	});
 	$( 'input[name="list"]' ).click(function(){
 		$(this).attr( 'checked' , true ).siblings().removeAttr( 'checked' );
 	});
 	$( 'input[name="detail"]' ).click(function(){
 		$(this).attr( 'checked' , true ).siblings().removeAttr( 'checked' );
 	});
	
	$( 'i.cacheDelete' ).click(function(){
		var optid = $( this ).parent().parent( 'td' ).attr( 'data-id' );
		if( false == optid )
		{
			$( '#dis_message' ).html( '参数配置错误,请刷新后再试...' );
			$( '#dis_message' ).parent().parent().addClass( 'alert-danger' ).removeClass( 'alert-success' );
			$( '#dis_message' ).parent().parent().fadeIn( 500 );
			setTimeout( function(){
				$( '#dis_message' ).parent().parent().fadeOut( 1000 );
			}, '3000' );
		}

	});
	
	
	/*-------------- 基本配置信息 ------------------*/
	$( '#btnBase' ).click(function(){
		var pattern = /^[1-9]*\d+$/;
		var baseState = 1;
		$( 'tr.basic_conf input' ).each( function(){
			if( !pattern.test( $( this ).val() ) ){
				baseState = 0;
				error( $( this ).parent().prev( 'td' ).html() + '格式有误' );
				$( this ).focus();
				return;
			}
		} );
		if( baseState ){
			var objParams = new Object();
			objParams.ctime = $( '#columnTime' ).val();
			objParams.ltime	= $( '#listTime' ).val();
			objParams.dtime = $( '#detailTime' ).val();
			objParams.sign	= $( 'input[name="time_id"]' ).val();
			objParams.type	= 1;
			objParams.key = key;
			objParams.token = token;
			
			$.post( '/admin/staticcache/save', objParams, function( ret ){
				if( 1 != ret.state )
				{
					success( ret.msg );
					$( '#columnTime' ).val( ret.optdata.index );
					$( '#listTime' ).val( ret.optdata.list );
					$( '#detailTime' ).val( ret.optdata.detail );
					$( 'input[name="time_id"]' ).val( ret.optdata.id );
				}
				else
					error( ret.msg );
				
				key = ret.key;
				token = ret.token;
			}, 'json' );
		}
		
	});
	
	/*------------------ 驱动配置  --------------------*/
	$( '#btnDriver' ).click(function(){
		
		var objParams = new Object();
		$( 'input[name="column"]' ).each(function(){
			if( "checked" == $(this).attr( 'checked' ) )
				objParams.cdriver = $(this).val();
		});
		$( 'input[name="list"]' ).each(function(){
			if( "checked" == $(this).attr( 'checked' ) )
				objParams.ldriver = $(this).val();
		});
		$( 'input[name="detail"]' ).each(function(){
			if( "checked" == $(this).attr( 'checked' ) )
				objParams.ddriver = $(this).val();
		});
		objParams.sign	= $( 'input[name="driver_id"]' ).val();
		objParams.type	= 2;
		objParams.key = key;
		objParams.token = token;
		
		$.post( '/admin/staticcache/save' , objParams , function( ret ){
			if( 1 != ret.state )
			{
				$( '#dis_message' ).html( ret.msg );
				$( '#dis_message' ).parent().parent().addClass( 'alert-success' ).removeClass( 'alert-danger' );
				$( '#dis_message' ).parent().parent().fadeIn( 500 );
				setTimeout( function(){
					$( '#dis_message' ).parent().parent().fadeOut( 1000 );
				}, '3000' );
				
				$( 'input[name="column"]' ).val( ret.optdata.index );
				$( 'input[name="list"]' ).val( ret.optdata.list );
				$( 'input[name="detail"]' ).val( ret.optdata.detail );
				$( 'input[name="driver_id"]' ).val( ret.optdata.id );
			}
			else
			{
				$( '#dis_message' ).html( ret.msg );
				$( '#dis_message' ).parent().parent().addClass( 'alert-danger' ).removeClass( 'alert-success' );
				$( '#dis_message' ).parent().parent().fadeIn( 500 );
				setTimeout( function(){
					$( '#dis_message' ).parent().parent().fadeOut( 1000 );
				}, '3000' );
			}
			
			key = ret.key;
			token = ret.token;
		}, 'json' );
		
	});
	
	/*---------------------- 存储配置 -----------------------*/
	$( '#btnStorage' ).click(function(){
		var storageState = 1;
		$( 'tr.storage_conf input' ).each( function(){
			if( '' == $( this ).val() ){
				storageState = 0;
				error( $( this ).parent().prev( 'td' ).html() + '为空' );
				$( this ).focus();
				return;
			}
		} );
		if( storageState ){
			var objParams = new Object();
			objParams.cstorage = $( '#cStorage' ).val();
			objParams.lstorage	= $( '#lStorage' ).val();
			objParams.dstorage = $( '#dStorage' ).val();
			objParams.sign	= $( 'input[name="storage_id"]' ).val();
			objParams.type	= 3;
			objParams.key = key;
			objParams.token = token;
			$.post( '/admin/staticcache/save', objParams, function( ret ){
				if( 1 != ret.state ){
					success( ret.msg );
					
					$( '#columnTime' ).val( ret.optdata.index );
					$( '#listTime' ).val( ret.optdata.list );
					$( '#detailTime' ).val( ret.optdata.detail );
					$( 'input[name="storage_id"]' ).val( ret.optdata.id );
				}
				else
					error( ret.msg );
				
				key = ret.key;
				token = ret.token;
			}, 'json' );
		}
	});
});
/*----------------输出正确信息-----------------*/
function success( msg ){
	$( '#dis_message' ).text( msg );
	$( '.alert' ).parent( 'div' ).removeClass( 'alert-danger' ).addClass( 'alert-success' );
	$( '.alert' ).parent( 'div' ).show().fadeOut( 3000 );
}
/*----------------输出错误信息-----------------*/
function error( msg ){
	$( '#dis_message' ).text( msg );
	$( '.alert' ).parent( 'div' ).removeClass( 'alert-success' ).addClass( 'alert-danger' );
	$( '.alert' ).parent( 'div' ).show().fadeOut( 3000 );
}