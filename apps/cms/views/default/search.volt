<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1" />
<meta http-equiv="X-UA-Compatible" content="IE=9" />
<link rel="stylesheet" href="/bootstrap/3.3.0/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/cms/default/main.css">
<link rel="stylesheet" href="/css/cms/default/list.css">
<link rel="stylesheet" href="/css/cms/default/search.css">
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
	
	<?php $this->partial( 'default/header' , array( 'cpryp' => $cpryp )   ); ?>
	
	<!-- 文章列表 -->
	<div class="container">
	
		<div style="margin:10px 0;">
			<ol class="breadcrumb self_breadcrumb self_nopadding">
			  <li><a href="<?php if( $cpryp->domain  )echo 'http://' . $cpryp->domain; else echo 'http://' .  $_SERVER['HTTP_HOST']; ?>">网站首页</a></li>
			  <li class="active">搜索结果</li>
			</ol>
		</div>
		
	</div>
	
	<div class="container">
		<div class="row self_nomargin">
			<div class="col-md-8 self_white_area">
			<?php 
				$slist = $this->search->getSearchRes( $key , $curPage );
				if( false != $slist && count( $slist ) > 0 )
				{
					$i = 0;
					foreach( $slist->items as $row )
					{    
                        $catId = $row[ 'catid' ];
			?>
				<div class="self_artical" style="<?php if( 0 == $i ) echo 'border:none;'; ?>">
				
					<div class="page-header self_search_pageheader">
						<h3><a href="<?php echo $this->article->getListLink( 'article', $row['id'] ); ?>"><?php echo $row['title']; ?></a></h3>
					</div>
					
					<div class="row">
						<?php if( false != $row['face'] ){ ?>
						<div class="col-md-3">
							<a href="<?php echo $this->article->getListLink( 'article', $row['id'] ); ?>" class="thumbnail" style="margin-bottom:0;">
								<img src="<?php echo $row['face']; ?>" alt="文章缩略图" height="90px" >
							</a>
						</div>
						<?php } ?>
						<div class="col-md-9">
							<p><?php echo $row ['content']; ?></p>
						</div>
					</div>
					
					<div class="row self_search_footer">
						<span>来自：<?php echo $row['catname']; ?></span>
						<span>作者：<?php if( false != $row['author'] ) echo $row['author']; else echo '佚名'; ?></span>
						<span>发布时间：<?php if( false != $row['pubtime'] ) echo date( 'Y-m-d', strtotime( $row['pubtime'] ) ); ?></span>
					</div>
				</div>
				<?php
						$i++;
					}
				?>
				<?php if( $slist->total_pages > 1){ ?>
                <nav class="text-right" >
                    <ul class="pagination pagination-sm" style="margin-top:0"> 
                        <li class="<?php if( $slist->current == 1 ) echo 'disabled'?>"><a href="/cms/search/index/key/<?php echo $key;?>/page/<?php echo $slist->before; ?>" >&laquo;</a></li>
                        <?php if ( 1 != $slist->current && 1 != $slist->before ){ ?>
                        <li><a href="/cms/search/index/key/<?php echo $key;?>">1</a></li>
                        <?php } ?>
                        <?php if( $slist->before != $slist->current ){?>
                        <li><a href="/cms/search/index/page/<?php echo $slist->before;?>/key/<?php echo $key;?>"><span ><?php echo $slist->before ?></span></a></li>
                        <?php } ?>
                        <li class="active"><a href="/cms/search/index/key/<?php echo $key;?>/page/<?php echo $slist->current;?>"><span ><?php echo $slist->current ?></span></a></li>
                        <?php if( $slist->next != $slist->current ) { ?>
                        <li><a href="/cms/search/index/key/<?php echo $key;?>/page/<?php echo $slist->next;?>"><?php echo $slist->next ?></a></li>
                        <?php } ?>
                        <?php if ( $slist->next  < $slist->last - 1 ) { ?>
                        <li><a>...</a></li>
                        <?php } ?>
                        <?php if( $slist->last != $slist->next  ){?>
                        <li><a href="/cms/search/index/key/<?php echo $key;?>/page/<?php echo $slist->last;?>"><?php echo $slist->last;?></a></li>
                        <?php } ?>
                        <li class="<?php if ( $slist->current == $slist->last ) echo 'disabled';?>"><a href="/cms/search/index/key/<?php echo $key;?>/page/<?php echo $slist->next; ?>" >&raquo;</a></li>
                    </ul>
                </nav>
				<?php
					}
				}
				?>
				
			</div>
			
			<?php if( !isset($catId) || !$catId ) $catId = 0; $category = $this->article->getCatAndArtList( $catId ); ?>
			<div class="col-md-3" style="margin-left:20px;width:370px;">
				
				<div class="row self_sidebar self_white_area">
                <?php if( isset( $category ) ) { ?>
					<div class="col-md-12">
						<div>
							<div class="page-header">
								<h4><?php if( isset( $category['cateinfo']->name )) echo $category['cateinfo']->name; ?></h4>
							</div>
							<?php 
								if( isset( $category[ 'artlist' ] ) && !empty( $category[ 'artlist' ] ) )
								{
							?>
							<ul class="list-group">
								<?php foreach( $category[ 'artlist' ] as $row ){ ?>
								<li class="list-group-item">
									<span class="glyphicon glyphicon-bookmark"></span>&nbsp;&nbsp;&nbsp;
									<a href="<?php echo $this->article->getListLink( 'article', $row->id ); ?>" title="<?php echo $row->title; ?>"><?php echo mb_substr($row->title , 0 , 15 , 'UTF-8' ); ?></a>
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
<script src="/js/cms/default/optNav.js"></script>
</body>
</html>
	
