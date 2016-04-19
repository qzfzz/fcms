<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="chrome=1,IE=edge" />
<meta name="renderer" content="webkit">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="/bootstrap/3.3.0/css/bootstrap.min.css" />
<link rel="stylesheet" href="/css/cms/default/main.css" />
<link rel="stylesheet" href="/css/cms/default/lightbox.css" />
<link rel="stylesheet" href="/css/admin/font-awesome.min.css" >
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
<style>
a.btn-default:hover{
	background-color:#c9302c;
	border-color:#ac2925;
	color:#fff;
}
</style>
</head>
<body>

	<!-- 返回顶部 -->
	<div class="self_returntotop">
		<span class="glyphicon glyphicon-circle-arrow-up"></span>
	</div>
	
	<?php $this->partial( 'default/header', array( 'highlights' => 0 , 'cpryp' => $cpryp ) ); ?>
	
	<!-- 轮播图 -->
	<!-- <div class="container" style="margin-top:10px;"> -->
		<div id="myCarousel" class="carousel slide">
	        <ol class="carousel-indicators">
				<?php 
		        	$slides = $this->slide->getSlides();
					if( count( $slides ) > 0 )
					{
						foreach( $slides as $key => $slide )
						{
				?>
					<li data-target="#myCarousel" data-slide-to="<?php echo $key;?>" class="<?php if( 0 == $key ){ echo 'active'; } ?>"></li>
				<?php 
						}
					}
				?>
			</ol>
			<div class="carousel-inner">
				<?php 
					if( count( $slides ) > 0 )
					{
						foreach( $slides as $key => $slide )
						{
				?>
							<div class="item <?php if( 0 == $key ){ echo 'active'; }?>">
								<a href="<?php if( $slide->url ){ echo $slide->url; }?>" target="_blank" ><img src="<?php if( $slide->dir ){ echo $slide->dir; }?>" alt="<?php if( $slide->alt ){ echo $slide->alt; }?>" /></a>
								<div class="carousel-caption">
									<h3><?php if( $slide->title ){ echo $slide->title; }?></h3>
									<p><?php if( $slide->content ){ echo $slide->content; }?></p>
								</div>
							</div>
				<?php
						}
					}
		        ?>
			</div>
	        <a class="left carousel-control" href="#myCarousel" data-slide="prev"></a>
	        <a class="right carousel-control" href="#myCarousel" data-slide="next"></a>
	    </div>
    <!-- </div> -->
    
	<!-- 详情展示 -->
	<div class="container">
	
		<div class="page-header">
	    	<h3>
	    		<span class="glyphicon glyphicon-send" aria-hidden="true" style="font-size:20px;"></span>&nbsp;&nbsp;&nbsp;<a>新鲜资讯</a>
	    		<!-- <a href="/"><small class="self_subtitle">功能汇总</small></a>
	    		<a href="/"><small class="self_subtitle">产品介绍&nbsp;&nbsp;&nbsp;</small></a>
	    		<a href="/"><small class="self_subtitle">FCMS特点&nbsp;&nbsp;&nbsp;</small></a> -->
	    	</h3>
	    	
	    </div>
		
		<div class="row masonry">
		<?php 
			$news = $this->article->getLatestArts();
			if( isset( $news ) && !empty( $news ) )
			{
				foreach( $news as $row )
				{
		?>
			<div class="col-sm-6 col-md-4 item">
				<div class="thumbnail">
					<?php if( false != $row->face ){ ?>
					<a href="<?php echo $this->article->getListLink( 'article', $row->id );?>" target="_blank" class="_fcms_static_"><img src="<?php if( false != $row->face ) echo $row->face; ?>" ></a>
					<?php } ?>
					<div class="caption">
						<h3><?php echo $row->title;?></h3>
						<p style="line-height:25px;height:75px;overflow:hidden;"><?php echo $row->description; ?></p>
						<p>
							<a href="<?php echo $this->article->getListLink( 'article', $row->id );?>" target="_blank" class="btn btn-danger" role="button" class="_fcms_static_">查看详情</a> 
							<a href="javascript:void( 0 );"  class="btn btn-default" role="button"><i class="fa fa-heart-o fa-lg"></i> 点击收藏</a>
						</p>
					</div>
				</div>
			</div>
		<?php
			}
		 }
		?>
		</div>
	</div>
	
	<!-- 最下方 -->
	<?php $this->partial( 'default/footer'  ); ?>
	
<script src="/js/jquery/jquery-1.11.1.min.js"></script>
<script src="/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src="/js/cms/default/html5shiv.js"></script>
<script src="/js/cms/default/respond.js"></script>
<script src="/js/cms/default/masonry.pkgd.js"></script>
<script src="/js/cms/default/lightbox.js"></script>
<script src="/js/cms/default/imagesloaded.pkgd.js"></script>
<script src="/js/cms/default/optNav.js"></script>
<script type="text/javascript">

$(function() {
	var masonryNode = $('div.masonry');
	masonryNode.imagesLoaded(function(){
    masonryNode.masonry({
        itemSelector: '.item',
            isFitWidth: false
        });
    }); 
});
</script>
</body>
</html>
