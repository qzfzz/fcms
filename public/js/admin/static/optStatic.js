
// js for static sites 

$( function(){
   /* -------------  全站静态化  ------------------*/
	$( '#staticSite' ).click(function(){
		
		$( '#confirmModal' ).modal( 'show' );
	
		$( '#continueBtn' ).unbind();
		
		$( '#continueBtn' ).click(function(){
			NProgress.start();
			$( '#confirmModal' ).modal( 'hide' );
			
			//ajax 请求操作静态化
			$.get( '/admin/statics/sites' , function( ret ){
			   if( 1 != ret.state )
			   {
					$( '#dis_message' ).html( ret.msg );
					$( '#dis_message' ).parent().parent().addClass( 'alert-success' ).removeClass( 'alert-danger' );
					$( '#dis_message' ).parent().parent().fadeIn( 500 );
					setTimeout( function(){
						$( '#dis_message' ).parent().parent().fadeOut( 1000 );
					}, '3000' );
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
			   NProgress.done();
			}, 'json' );
		});
   	});
   
	/* -------------  继续静态化  ------------------*/
	$( '#staticPart' ).click(function(){
   		NProgress.start();
   		
   		//ajax 请求操作静态化
   		$.get( '/admin/statics/part' , function( ret ){
		   if( 1 != ret.state )
		   {
				$( '#dis_message' ).html( ret.msg );
				$( '#dis_message' ).parent().parent().addClass( 'alert-success' ).removeClass( 'alert-danger' );
				$( '#dis_message' ).parent().parent().fadeIn( 500 );
				setTimeout( function(){
					$( '#dis_message' ).parent().parent().fadeOut( 1000 );
				}, '3000' );
		   }
		   else
		   {
				$( '#dis_message' ).parent().parent().addClass( 'alert-danger' ).removeClass( 'alert-success' );
				$( '#dis_message' ).parent().parent().fadeIn( 500 );
				setTimeout( function(){
					$( '#dis_message' ).parent().parent().fadeOut( 1000 );
				}, '3000' );$( '#dis_message' ).html( ret.msg );
			
		   }
		   NProgress.done();
	   }, 'json' );
	   
   	});
   
   
	/* -------------  单片文章静态化  ------------------*/
   	$( 'i.articlesStatics' ).click(function(){
   		NProgress.start();
	   var id = $(this).parent().parent( 'td' ).attr( 'data-id' );
	   if( false == id )
	   {
		   alert( '参数设置失败,请刷新后再试...' );
		   return false;
	   }
	   //ajax 请求操作静态化
	   $.get( '/admin/statics/artStatic/aid/' + id , function( ret ){
		   if( 1 != ret.state )
		   {
				$( '#dis_message' ).html( ret.msg );
				$( '#dis_message' ).parent().parent().addClass( 'alert-success' ).removeClass( 'alert-danger' );
				$( '#dis_message' ).parent().parent().fadeIn( 500 );
				setTimeout( function(){
					$( '#dis_message' ).parent().parent().fadeOut( 1000 );
				}, '3000' );
		   }
		   else
		   {
				$( '#dis_message' ).parent().parent().addClass( 'alert-danger' ).removeClass( 'alert-success' );
				$( '#dis_message' ).parent().parent().fadeIn( 500 );
				setTimeout( function(){
					$( '#dis_message' ).parent().parent().fadeOut( 1000 );
				}, '3000' );$( '#dis_message' ).html( ret.msg );
		   }
		   NProgress.done();
	   }, 'json' );
	   
   	});
   
});
    