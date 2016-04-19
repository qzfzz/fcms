<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="chrome=1,IE=edge" />
<meta name="renderer" content="webkit">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/bootstrap/3.3.0/css/bootstrap.min.css" />
<link rel="stylesheet" href="/css/cms/default/main.css" />
<link rel="stylesheet" href="/css/cms/default/list.css">

<?php  $cpryp = $this->site->getWebSiteInfo(); ?>
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
	<?php if( isset( $cpryp->name ) && false != $cpryp->name ) echo $cpryp->name; else echo '我的FCMS网站'; ?>
</title>
</head>
<body>
	<!-- 返回顶部 -->
	<div class="self_returntotop">
		<span class="glyphicon glyphicon-circle-arrow-up"></span>
	</div>
	
	<?php $this->partial( 'default/header', array( 'highlights' => $mid, 'cpryp' => $cpryp ) ); ?>
	
	<?php
	$catid = $mid?$mid:0;
	$catinfo = $this->article->getCateInfo( $catid );
	?>
	<!-- 文章列表 -->
	<div class="container">
	
		<div style="margin:10px 0;">
			<ol class="breadcrumb self_breadcrumb self_nopadding">
			  <li><a href="<?php if( $cpryp->domain ) echo 'http://' . $cpryp->domain; else echo 'http://' . $_SERVER['HTTP_HOST']; ?>">网站首页</a></li>
			  <li class="active"><?php if( false != $catid && false != $catinfo ) echo $catinfo->name; else echo '我的文章';?></li>
			</ol>
		</div>
	</div>
	
	<div class="container">
		<div class="row self_nomargin">
			<div class="col-md-8 self_white_area">
			  <?php 
				$list = $this->article->getCateArticles( $catid , $curPage );
				if( count( $list ) > 0 )
				{
					$i = 0;
					foreach( $list->items as $row )
					{
			  ?>
				<div class="self_artical" style="<?php if( 0 == $i ) echo 'border:none;'; ?>">
				
					<div class="page-header" style="margin-bottom:10px;">
						<h3>
						<a href="<?php echo $this->article->getListLink( 'article', $row->id ); ?>" target="_blank" title="<?php echo $row->title; ?>" class="_fcms_static_"><?php echo mb_substr( $row->title , 0 , 22 , 'UTF-8' ); ?></a>
						</h3>
						<div class="self_list_author">
							<span>作者：<?php if( false != $row->author ) echo $row->author; else echo '佚名'; ?>&nbsp;&nbsp;&nbsp;&nbsp;
							<?php if( false != $row->uptime ) echo date( 'Y-m-d', strtotime( $row->uptime ) ); else echo date( 'Y-m-d', strtotime( $row->addtime ) ); ?></span>
						</div>
					</div>
					
					<div class="row">
						<?php if( isset( $row->face ) && false != $row->face ){ ?>
						<div class="col-md-3">
							<a href="<?php echo $this->article->getListLink( 'article', $row->id ); ?>" target="_blank" class="thumbnail" class="_fcms_static_">
								<img src="<?php echo $row->face; ?>" alt="<?php echo $row->title; ?>">
							</a>
						</div>
						<?php } ?>
						<div class="<?php if( isset( $row->face ) && false != $row->face ) echo 'col-md-9'; else echo 'col-md-12';?>">
							<p><?php echo $row->description ?></p>
							<div class="self_list_buttons">
								<a class="btn btn-danger">点击收藏</a> 
								<a class="btn btn-default" target="_blank" href="<?php echo $this->article->getListLink( 'article', $row->id ); ?>" class="_fcms_static_">查看详情</a>
							</div>
						</div>
					</div>
				
				</div>
				<?php
				    	$i++;
					}
				?>
				<!-- 分页 -->
				<?php if( $list->total_pages > 1){ ?>
                <nav class="text-right" >
                    <ul class="pagination pagination-sm" style="margin-top:0"> 
                        <li class="<?php if( $list->current == 1 ) echo 'disabled'?>"><a href="/cms/index/list/cid/<?php echo $catid;?>/page/<?php echo $list->before; ?>" class="_fcms_static_">&laquo;</a></li>
                        <?php if ( 1 != $list->current && 1 != $list->before ){ ?>
                        <li><a href="/cms/index/list/cid/<?php echo $mid;?>" class="_fcms_static_">1</a></li>
                        <?php } ?>
                        <?php if( $list->before != $list->current ){?>
                        <li><a href="/cms/index/list/cid/<?php echo $catid;?>/page/<?php echo $list->before;?>" class="_fcms_static_"><span ><?php echo $list->before ?></span></a></li>
                        <?php } ?>
                        <li class="active"><a href="/cms/index/list/cid/<?php echo $catid;?>/page/<?php echo $list->current;?>" class="_fcms_static_"><span ><?php echo $list->current ?></span></a></li>
                        <?php if( $list->next != $list->current ) { ?>
                        <li><a href="/cms/index/list/cid/<?php echo $catid;?>/page/<?php echo $list->next;?>" class="_fcms_static_"><?php echo $list->next ?></a></li>
                        <?php } ?>
                        <?php if ( $list->next  < $list->last - 1 ) { ?>
                        <li><a>...</a></li>
                        <?php } ?>
                        <?php if( $list->last != $list->next  ){?>
                        <li><a href="/cms/index/list/cid/<?php echo $catid;?>/page/<?php echo $list->last;?>" class="_fcms_static_"><?php echo $list->last;?></a></li>
                        <?php } ?>
                        <li class="<?php if ( $list->current == $list->last ) echo 'disabled';?>"><a href="/cms/index/list/cid/<?php echo $catid;?>/page/<?php echo $list->next; ?>" class="_fcms_static_">&raquo;</a></li>
                    </ul>
                </nav>
				<?php } ?>
				<?php } ?>
			</div>
			
			<?php $result = $this->article->getCatAndArtList( $catid  ); ?>
			<div class="col-md-3" style="margin-left:20px;width:370px;">
				
				<div class="row self_sidebar self_white_area">
					<div class="col-md-12">
						<?php if( false != $result && count( $result ) > 0  ) { ?>
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
				
				<!-- <div class="row self_sidebar self_white_area">
					<div class="col-md-12">
						<div>
							<div class="page-header">
								<h4>广告位</h4>
							</div>
							<a href="/" class="thumbnail">
								<img src="/img/cms/default/artical3.png" alt="文章缩略图">
							</a>
						</div>
					</div>
				</div> -->

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
var sign = <?php if( false != $mid ) echo $mid; else echo 0;?>;
$(function(){
	if( false != sign )
	{
		$( 'ul.navbar-nav li ul li' ).each(function(){
			var catregory = $(this).find( 'a' ).attr( 'data-category' );
			if( false != catregory && catregory == sign )
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
});
</script>
</body>
</html>
	
