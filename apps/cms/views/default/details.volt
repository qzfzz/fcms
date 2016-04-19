<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<link rel="stylesheet" href="/bootstrap/3.3.0/css/bootstrap.min.css" />
<link rel="stylesheet" href="/css/cms/default/main.css" />
<link rel="stylesheet" href="/css/cms/default/list.css">
<link rel="stylesheet" href="/css/cms/default/details.css">
<?php  $cpryp = $this->site->getWebSiteInfo(); $article = $this->article->getSingleArticle( $sign ); ?>
<?php if( isset( $cpryp->name ) && false != $cpryp ){  ?>
<meta content="<?php echo $cpryp->name;?>" name="title">
<?php } ?>
<?php if( isset( $cpryp->seodescr ) && false != $cpryp ){ ?>
<meta content="<?php echo $cpryp->seodescr;?>" name="description">
<?php }?>
<?php if( isset( $cpryp->seokey ) && false != $cpryp ) { ?>
<meta content="<?php echo $cpryp->seokey;?>" name="Keywords">
<?php } ?>
<title>
	<?php if( isset( $cpryp->name ) && false != $cpryp->name ) echo $cpryp->name; else echo '我的FCMS网站'; ?> - <?php if( false != $article && count( $article ) > 0 ) echo $article->title; ?>
</title>
</head>
<body>
	<!-- 返回顶部 -->
	<div class="self_returntotop">
		<span class="glyphicon glyphicon-circle-arrow-up"></span>
	</div>
	
	<?php $this->partial( 'default/header', array( 'highlights' => $article->cat_id , 'cpryp' => $cpryp ) ); ?>
	
	<!-- 文章详情 -->
	<div class="container">
	
		<div style="margin:10px 0;">
			<ol class="breadcrumb self_breadcrumb self_nopadding">
			  <li><a href="<?php if( $cpryp->domain ) echo 'http://' . $cpryp->domain; else echo  'http://' . $_SERVER['HTTP_HOST']; ?>">网站首页</a></li>
			  <li><a href="<?php if( false != $article && false != $article->catinfo->id ) echo $this->article->getListLink( 'artcate' , $article->catinfo->id ); ?>" class="_fcms_static_"><?php if( isset( $article ) && false != $article ) echo $article->catinfo->name; ?></a></li>
			  <li class="active"><?php if( false != $article && count( $article ) > 0 ) echo $article->title; ?></li>
			</ol>
		</div>
	</div>
	
	<div class="container">
		<div class="row self_nomargin">
			<div class="col-md-8" style="background-color:#fff">
			
				<div class="self_artical" style="border:none;">
				
					<div class="page-header">
						<h3><?php if( false != $article ) echo $article->title; ?></h3>
						<div class="pull-right">
							<span>作者：<?php if( false != $article ) echo $article->author; else echo '佚名'; ?>&nbsp;&nbsp;&nbsp;&nbsp;
							<?php if( false != $article && false != $article->uptime ) echo date( 'Y-m-d', strtotime($article->uptime) ); else if( false != $article && false != $article->addtime  ) echo date( 'Y-m-d', strtotime($article->addtime) );?></span>
						</div>
					</div>
					
					<div class="row">
						<div class="col-md-12 self_artical_details">
							<?php if(  $article ) echo $article->content; ?>
						</div>
						<div class="col-md-12 self_artical_visits">
							<span class="glyphicon glyphicon-eye-open"></span>&nbsp;&nbsp;浏览次数：<span id='self_visit_nums' style="display:inline-block;width:20px;"></span>
						</div>
					</div>
					
				</div>
				
			</div>
			
			<?php $result = $this->article->getCatAndArtList( $article->cat_id ); ?>
			<div class="col-md-3" style="margin-left:20px;width:370px;">
				
				<div class="row self_sidebar self_white_area">
					<div class="col-md-12">
						<?php if(  $result && count( $result ) > 0  ) { ?>
						<div>
							<div class="page-header">
								<h4><?php if( false != $result['cateinfo']->name ) echo $result['cateinfo']->name; ?></h4>
							</div>
							<?php 
								if( isset( $result['artlist'] ) && !empty( $result['artlist'] ) )
								{
							?>
							<ul class="list-group">
								<?php foreach( $result['artlist'] as $row ){ ?>
								<li class="list-group-item">
									<span class="glyphicon glyphicon-bookmark"></span>&nbsp;&nbsp;&nbsp;
									<a href="<?php echo $this->article->getListLink( 'article', $row->id ); ?>" title="<?php echo $row->title; ?>" class="_fcms_static_"><?php echo mb_substr($row->title , 0 , 15 , 'UTF-8' ); ?></a>
								</li>
								<?php }?>
							</ul>
							<?php } ?>
						</div>
						<?php }?>
					</div>
				</div>
				
				<div class="row self_sidebar self_white_area">
					<div class="col-md-12">
						<div>
							<div class="page-header">
								<h4>同类文章</h4>
							</div>
							<?php if( $sameNews = $this->article->getRelTagsArt( $article->id ) ){ ?>
							<ul class="list-group">
								<?php foreach( $sameNews as $news ){ ?>
								<li class="list-group-item">
									<span class="glyphicon glyphicon-bookmark"></span>&nbsp;&nbsp;&nbsp;
									<a href="/cms/index/detail/id/<?php echo $news->id; ?>" target="_blank" title="<?php echo $news->title; ?>"><?php if( isset( $news->title ) ){ if( strlen( $news->title ) > 15 ) echo mb_substr( $news->title , 0 , 15, 'UTF-8' ) . '....'; else echo $news->title; } ?></a>
								</li>
								<?php }?>
							</ul>
							<?php } ?>
						</div>
					</div>
				</div>
				
			</div>
			
		</div>
		
	</div>
	
	
	<!-- 最下方 -->
	<?php $this->partial( 'default/footer'  ); ?>

<script src="/js/jquery/jquery-1.11.1.min.js"></script>
<script src="/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src="/js/cms/default/html5shiv.js"></script>
<script src="/js/cms/default/respond.js"></script>
<script src="/js/cms/default/optNav.js"></script>
<script type="text/javascript">
var articalId = <?php if( false != $sign ) echo $sign; else echo 0; ?>;
var articleCateId = <?php if( false != $article ) echo $article->cat_id; else echo 0; ?>;
$(function(){
	if( false == articalId )
		return false;
		
	$.get( '/cms/index/redisInput/id/' + articalId, function( res ){
			$( '#self_visit_nums' ).html( res );
	});		
	
	if( articleCateId )
	{
		$( 'ul.navbar-nav li ul li' ).each(function(){
			var catregory = $(this).find( 'a' ).attr( 'data-category' );
			if( catregory && catregory == articleCateId )
			{
				var chpid = $(this).attr( 'data-pid' );
				$( 'ul.navbar-nav li' ).each(function(){
					var pcte = $(this).attr( 'data-id' );
					if( false != pcte && pcte == chpid )
					{
						$(this).addClass( 'active' ).siblings( 'li' ).removeClass( 'active' );
					}
				});
			}
		});
	}
	
	$( 'ul.navbar-nav li ul li' ).each(function(){
		var articleid = $(this).find( 'a' ).attr( 'data-aid' );
		if( false != articleid && articleid == articalId )
		{
			var chpid = $(this).attr( 'data-pid' );
			$( 'ul.navbar-nav li' ).each(function(){
				var pcte = $(this).attr( 'data-id' );
				if( false != pcte && pcte == chpid )
				{
					$(this).addClass( 'active' ).siblings( 'li' ).removeClass( 'active' );
				}
			});
		}
	});
	
	$( 'ul.navbar-nav >li' ).each(function(){
		var articleid = $(this).find( 'a' ).attr( 'data-aid' );
		if( false != articleid && articleid == articalId )
			$(this).addClass( 'active' ).siblings( 'li' ).removeClass( 'active' );
	});
	
});
</script>
</body>
</html>
	
