<?php
namespace apps\admin\controllers;
!defined( 'APP_ROOT' ) && exit( 'Direct Access Deny!' );

use apps\admin\models\ArticleCats;
use apps\admin\models\Articles;
use enums\SystemEnums;
use Phalcon\Paginator\Adapter\QueryBuilder;
use Phalcon\Validation;
use Phalcon\Validation\Validator\PresenceOf;
use libraries\pin;
use libraries\TimeUtils;
use apps\admin\models\ArticleTags;
use vendors\xunsearch\lib\XSDocument;

/**
 * 文章
 * @author hfc
 * time 2015-7-27
 */

class ArticlesController extends AdminBaseController
{
    private $categorys = array();
    
    public function initialize()
    {
        parent::initialize();
    }
    
    /**
     * @author( author='hfc' )
     * @date( date = '2015-8-24' )
     * @comment( comment = '文章的首页' )	
     * @method( method = 'indexAction' )
     * @op( op = 'r' )		
    */
    public function indexAction()
    {
        $pageNum     = $this->dispatcher->getParam( 'page', 'int' );
        $currentPage = $pageNum ?: 1;
        
        $a_name      = $this->dispatcher->getParam( 'name' );
        $c_id        = $this->dispatcher->getParam( 'cid' );
        $a_pubtime   = $this->dispatcher->getParam( 'time' );
        
        $strWhere = '';
        if( false != $a_name )
            $strWhere .=" and a.title like '%" . $a_name . "%'";
        if( false != $c_id )
        {
            $strids = '';
            //查找该分类子类id
            $arrIds = $this->_getCategoryTree( $c_id );
            if( false != $arrIds && count( $arrIds ) > 0 )
            {
                foreach ( $arrIds as $fir )
                {
                    if( false != $fir[ 'sub' ] && count( $fir[ 'sub' ] ) > 0 )
                    {
                        foreach( $fir[ 'sub' ] as $sec )
                        {
                            if( false != $sec[ 'sub' ] && count( $sec[ 'sub' ] ) > 0 )
                            {
                                foreach( $sec[ 'sub' ] as $thr )
                                {
                                    $strids .= $thr[ 'id' ] . ',';
                                }
                            }
                            $strids .= $sec[ 'id' ] . ',';
                        }    
                    }
                    $strids .= $fir[ 'id' ] . ',';
                }
            }
            
            //拼接上本类 id
            $strids .= $c_id;
            $cWhere = array(
            	'id = ?0',
                'bind' => [ $c_id ],
            );
            $cate = ArticleCats::findFirst( $cWhere );
            
            $cateName = ( false != $cate->name ) ? $cate->name : "文章分类";
            $this->view->cat_name = $cateName;
            
            $strWhere .= " and a.cat_id in (" . trim($strids) . ")";
        }
        if( false != $a_pubtime )
            $strWhere .= " and a.pubtime like '" . $a_pubtime . "%'";

        $phql = $this->modelsManager->createBuilder()
        		->columns( 'a.id,a.uptime,a.title,a.cat_id,a.top,c.name as cat_name,a.pubtime' )
        		->addFrom( 'apps\admin\models\Articles' , 'a' )
        		->join( 'apps\admin\models\ArticleCats', 'a.cat_id=c.id', 'c' )
        		->where( 'a.delsign=' . SystemEnums::DELSIGN_NO . $strWhere . ' order by a.uptime desc' );
        
        $paginator = new QueryBuilder( array(
        				'builder' => $phql,
        				'limit' => 10,
        				'page' => $currentPage
        		));
        
        $page = $paginator->getPaginate();
        
        $this->view->page = $page;
        $this->view->art_title = $a_name ?: 0;
        $this->view->art_cate = $c_id ?: 0;
        $this->view->art_pubt = $a_pubtime ?: 0;
        $this->view->categorys = $this->_getCategoryTree();
    }
    
    /**
     * @author( author='hfc' )
     * @date( date = '2015-8-24' )
     * @comment( comment = '编辑商品显示' )	
     * @method( method = 'editAction' )
     * @op( op = '' )		
    */
    public function editAction()
    {
    	$arrTags = array();
    	
        $id =  $this->request->getQuery( 'id', 'int' );
        $article = Articles::findFirst( array( 'id=?0', 'bind' => array( $id ) ) );
        if( $article != false )
        {
        	if( count( $article->getArttags() ) > 0 )
        	{
        		$this->view->tags = $article->getArttags();
        	}
            $this->view->article = $article->toArray();      
        }
        
        //tags
        $where = array(
        		'columns'	=> 'id,delsign,name,display,sort',
        		'conditions'=>'delsign=:del: and display=:dis: ORDER BY sort,uptime DESC',
        		'bind'		=> array( 'del' => SystemEnums::DELSIGN_NO, 'dis'=> 0 ),
        );
        $tags = ArticleTags::find( $where );
        if( $tags && count( $tags ) > 0  )
        {
        	foreach ( $tags as $t )
        	{
        		array_push( $arrTags , $t->name );
        	}
        }
        $this->view->alltags = array_unique( $arrTags );
        
        $this->view->categorys = $this->_getCategoryTree();
    }
    
    /**
     * @author( author='hfc' )
     * @date( date = '2015-8-24' )
     * @comment( comment = '添加商品显示' )	
     * @method( method = 'addAction' )
     * @op( op = '' )		
    */
    public function addAction()
    {
    	$arrTags = array();
    	//选取文章标签
    	$where = array(
			'column'	=> 'id,delsign,name,display,sort',
			'conditions'=>'delsign=:del: and display=:dis: ORDER BY sort,uptime DESC',
			'bind'		=> array( 'del' => SystemEnums::DELSIGN_NO, 'dis'=> 0 ),
    	);
    	$tags = ArticleTags::find( $where );
    	if( $tags && count( $tags ) > 0  )
    	{
    		foreach ( $tags as $t )
    		{
    			array_push( $arrTags , $t->name );
    		}
    	}
    	$this->view->tags = array_unique( $arrTags );
    	
        $this->view->categorys = $this->_getCategoryTree();
    }
    
    /**
     * @author( author='hfc' )
     * @date( date = '2015-8-24' )
     * @comment( comment = 'ajax 请求 更新文章' )	
     * @method( method = 'updateAction' )
     * @op( op = 'u' )		
    */
    public function updateAction()
    {
       	$this->csrfCheck(); //csrf检验
       	
       	$userInfo = $this->session->get( 'userInfo' );
       	
        $articleId = $this->request->getPost( 'articleId', 'int' );
        $data[ 'title' ] = $this->request->getPost( 'title', 'trim' );
        $data[ 'cat_id' ] =  $this->request->getPost( 'categoryId', 'int' ) ;
        $data[ 'author' ] = $userInfo?$userInfo[ 'nickname' ]:NULL;
        $data[ 'keywords' ] = $this->request->getPost( 'keywords', 'string' );
        $data[ 'description' ] = $this->request->getPost( 'description', 'string' );
        $data[ 'top' ] = $this->request->getPost( 'top', 'int' );
        $data[ 'face' ] = $this->request->getPost( 'face', 'trim' );
        
        $this->validation( $data ); //验证输入数据
        
        $data[ 'pubtime' ]  = $this->request->getPost( 'pubtime' );
        $data[ 'uptime' ]  = date( 'Y-m-d H:i:s' );
        
        $PinYin = new pin();
        $strTags = rtrim( $this->request->getPost( 'strtags' , 'trim' ) , ',' );
        $arrTags = explode( ',' , $strTags );
        
        $this->db->begin();
        $article = Articles::findFirst( array( 'id=?0','bind' =>  array(  $articleId ) ) );
        if( $article && $article->update( $data ) )
        {
        	//tags先删除后再添加
        	if( !empty( $arrTags ) )
        	{
        		$delWhere = array(
        			'conditions'	=> 'delsign=:del: and aid=:articleid:',
        			'bind'			=> array( 'del' => SystemEnums::DELSIGN_NO, 'articleid' => $articleId ),
        		);
        		$res = ArticleTags::find( $delWhere );
        		if( count( $res ) > 0 )
        		{
        			foreach ( $res as $k )
        			{
        				$k->delete();
        			}
        		}
        		
        		foreach( $arrTags as $row )
        		{
        		    if( false != $row && false != $articleId )
        		    {
            			$tag = new ArticleTags();
            			$tag->delsign 	= SystemEnums::DELSIGN_NO;
            			$tag->name		= $row;
            			$tag->uptime  	= $tag->addtime = TimeUtils::getFullTime();
            			$tag->aid 		= $articleId;
            			$tag->save();
        		    }
        		}
        	}
        	//$this->upXunSearch( $article ); //更新全文索引
        	$this->success( '更新成功' , array( 'id' => $article->id ) );
        }
        else
        {
        	foreach( $article->getMessages() as $msg )
        	{
        		echo $msg,PHP_EOL;
        	}
        	$this->db->rollback();
        	$this->error( '更新失败' );
        	return;
        }
        
        $this->db->commit();
    }
    
    /**
     * @author( author='hfc' )
     * @date( date = '2015-8-24' )
     * @comment( comment = 'ajax 请求 删除文章' )	
     * @method( method = 'deleteAction' )
     * @op( op = 'd' )		
    */
    public function deleteAction()
    {
        $this->csrfCheck(); //csrf检验
        
        $id = $this->request->getPost( 'id', 'int' );
        $goods = Articles::findFirst( array( 'id=?0', 'bind' => array( $id ) ) );
        if( $goods )
        {
            $status = $goods->update( array( 'delsign' => SystemEnums::DELSIGN_YES, 'uptime' => date( 'Y-m-d H:i:s') ) );
            if( $status )
            {
                $this->success( '删除成功' );
            }
        }
        else
       {
            $this->error( '删除失败' );
        }
    }
    
    /**
     * @author( author='hfc' )
     * @date( date = '2015-8-24' )
     * @comment( comment = 'ajax 请求 添加一个新文章' )	
     * @method( method = 'insertAction' )
     * @op( op = 'c' )		
    */
    public function insertAction()
    {
        $this->csrfCheck(); //csrf检验
        
       	$userInfo = $this->session->get( 'userInfo' );
        
        $data[ 'title' ] = $this->request->getPost( 'title', 'trim' );
        $data[ 'cat_id' ] =  $this->request->getPost( 'categoryId', 'int' ) ;
        $data[ 'author' ] = $userInfo?$userInfo[ 'nickname' ]:NULL;
        $data[ 'keywords' ] = $this->request->getPost( 'keywords', 'string' );
        $data[ 'description' ] = $this->request->getPost( 'description', 'string' );
        $data[ 'top' ] = $this->request->getPost( 'top', 'int' );
        $data[ 'face' ] = $this->request->getPost( 'face', 'trim' );
        $data[ 'pubtime' ]  = $this->request->getPost( 'pubtime' );
        $this->validation( $data );
        $data[ 'addtime' ] = $data[ 'uptime' ]  = TimeUtils::getFullTime();
        $data[ 'delsign' ] = $data[ 'content' ] = $data[ 'status' ] = SystemEnums::DELSIGN_NO;
        
        $PinYin = new pin();
        $strTags = rtrim( $this->request->getPost( 'strtags' , 'trim' ) , ',' );
		$arrTags = explode( ',' , $strTags );
		
		//文章 
		$this->db->begin();
		$article = new Articles();
		if( false ==  $article->save( $data ) )
		{
			$this->db->rollback(); 
			$this->error( '保存失败', array( 'id' => $article->id ) );
			return;
		}
		else
		{
			//tags
			if( !empty( $arrTags ) )
			{
				foreach( $arrTags as $row )
				{
				    if( false != $row && false != $article->id )
				    {
				        $tag = new ArticleTags();
				        $tag->delsign 	= SystemEnums::DELSIGN_NO;
				        $tag->name		= $row;
				        $tag->uptime  	= $tag->addtime  = TimeUtils::getFullTime();
				        $tag->aid 		= $article->id;
				        $tag->save();
				    }
				}
			}
//			$this->setXunSearch( $article ); //新建全文索引
			
			$this->success( '保存成功', array( 'id' => $article->id  ) );
		}
		$this->db->commit();
    }
    
    /**
     * @author( author='hfc' )
     * @date( date = '2015-8-24' )
     * @comment( comment = '更新文章内容' )	
     * @method( method = 'saveArticleAction' )
     * @op( op = 'u' )		
    */
    public function saveArticleAction()
    {
    	$this->csrfCheck();
    	
        $data[ 'content' ]  = $this->request->getPost( 'content' );
        $id = $this->request->getPost( 'articleId', 'int' );
        $data[ 'uptime' ] = date( 'Y-m-d H:i:s' );
      
        $article = Articles::findFirst( array( 'id=?0', 'bind' => array( $id )) );
        if( $article ) //更新
        {
            if( $article->update( $data ) ) 
                $this->success( '保存成功' );
          
        }
        $this->error( '保存失败' );
    }
        
    /**
     * @author( author='hfc' )
     * @date( date = '2015-8-24' )
     * @comment( comment = '根据父类，获得所有子类' )	
     * @method( method = '_getCategoryTree' )
     * @op( op = '' )		
    */
    protected function _getCategoryTree( $pid = 0 )
    {
        $arrCates = array();
        if( ! $this->categorys )
        {
            $where =  'delsign=' . SystemEnums::DELSIGN_NO;
            $objCates = ArticleCats::find( array( $where, 'columns' => 'id,parent_id as pid,name','order' => 'parent_id' ));
            if( $objCates )
                 $this->categorys = $objCates->toArray();
        } 
     
        foreach( $this->categorys as $cate ) 
        {
            if( $cate[ 'pid' ] == $pid )
            {
                $arrCates[ $cate[ 'id' ] ] = $cate;
                $children = $this->_getCategoryTree( $cate[ 'id' ] );
                
                if( ! empty( $children ) )
                    $arrCates[ $cate[ 'id' ] ][ 'sub' ] = $children; 
            }
        }
   
        return $arrCates;
    }
    
    /**
     * @author( author='hfc' )
     * @date( date = '2015-8-24' )
     * @comment( comment = '对输入的数据进行验证' )	
     * @method( method = 'validation' )
     * @op( op = '' )		
    */
    private function validation( $data = array() )
    {
        $validation = new Validation();
        $validation->add( 'title', new PresenceOf(array(
            'message' => '文章标题必须填写'
        )));
        $validation->add( 'cat_id', new PresenceOf(array(
            'message' => '文章分类必须填写'
        )));
        
        $messages =  $validation->validate( $data );
        if( count( $messages ))
        {
            foreach( $messages as $msg )
            {
                $this->error( $msg->getMessage()  );
            }
        }
    }

    /**
     * @author( author='Caret' )
     * @date( date = '2015-10-27' )
     * @comment( comment = '设置查询' )
     * @method( method = 'setXunSearch' )
     * @op( op = '' )
     */
    private function setXunSearch( $data )
    {
    	if( false == $data  )
    		return false;
    	
    	
    	$where = array(
    		'column'	=> 'id,name,delsign,display,aid,sort',
    		'conditions'=> 'delsign=:del: and display=:dis: and id=:optid: ORDER BY sort DESC',
    		'bind'		=> array( 'del' => SystemEnums::DELSIGN_NO, 'dis' => 0, 'optid' => $data->id ),
    	);
    	$tags = ArticleTags::find( $where );
    	if( count( $tags ) > 0 && false != $tags )
    	{
    		$arrTags = array();
    		foreach( $tags as $row )
    		{
    			array_push( $arrTags , $row->name );
    		}
    		if( count( $arrTags ) > 0 )
    			$tagname = implode( array_unique($arrTags) , ',' );
    	}
    	else
    		$tagname = '';
    	
    	
    	$catWhere = array(
    		'column'	=> 'id,delsign,name,parent_id',
    		'conditions'=> 'delsign=:del: and id=:optid:',
    		'bind'		=> array( 'del' => SystemEnums::DELSIGN_NO, 'optid' => $data->cat_id ),
    	);
    	$catgory = ArticleCats::findFirst( $catWhere );
    	if( false != $catgory && count( $catgory ) > 0 )
    		$catname = $catgory->name;
    	else 
    		$catname = '';
    	
    	$xs = $this->getDI()->get( 'xs_article' );
    	$index = $xs->index;
    	$doc = new XSDocument();
    	$data = array( 
    			'sid' 		=> $data->id,
    			'title' 	=> $data->title,
    			'content' 	=> $data->description,
    			'face'		=> $data->face,
    			'author'	=> $data->author,
    			'keywords'	=> $data->keywords,
    			'tagname'	=> $tagname,
    			'catname'	=> $catname,
    			'time'		=> $data->uptime?$data->uptime:$data->addtime,
    	);
    	
    	$doc->setFields( $data );
    	$index->add( $doc );
    }
    
    /**
     * @author( author='Carey' )
     * @date( date = '2015-10-27' )
     * @comment( comment = '更新查询' )
     * @method( method = 'upXunSearch' )
     * @op( op = '' )
     */
    private function upXunSearch( $data )
    {
    	if( false == $data  )
    		return false;
    	
    	$where = array(
    			'column'	=> 'id,name,delsign,display,aid,sort',
    			'conditions'=> 'delsign=:del: and display=:dis: and id=:optid: ORDER BY sort DESC',
    			'bind'		=> array( 'del' => SystemEnums::DELSIGN_NO, 'dis' => 0, 'optid' => $data->id ),
    	);
    	$tags = ArticleTags::find( $where );
    	if( count( $tags ) > 0 && false != $tags )
    	{
    		$arrTags = array();
    		foreach( $tags as $row )
    		{
    			array_push( $arrTags , $row->name );
    		}
    		if( count( $arrTags ) > 0 )
    			$tagname = implode( array_unique($arrTags) , ',' );
    	}
    	else
    		$tagname = '';
    	 
    	$catWhere = array(
    			'column'	=> 'id,delsign,name,parent_id',
    			'conditions'=> 'delsign=:del: and id=:optid:',
    			'bind'		=> array( 'del' => SystemEnums::DELSIGN_NO, 'optid' => $data->cat_id ),
    	);
    	$catgory = ArticleCats::findFirst( $catWhere );
    	if( false != $catgory && count( $catgory ) > 0 )
    		$catname = $catgory->name;
    	else
    		$catname = '';
    	
    	$xs = $this->getDI()->get( 'xs_article' );
    	$index = $xs->index;
    	 
    	$doc = new XSDocument();
    	$doc->setFields( 
    			array(
    				'sid' 		=> $data->id,
    				'title' 	=> $data->title,
    				'content' 	=> $data->description,
    				'face'		=> $data->face,
    				'author'	=> $data->author,
    				'keywords'	=> $data->keywords,
    				'tagname'	=> $tagname,
    				'catname'	=> $catname,
    				'time'		=> $data->uptime?$data->uptime:$data->addtime,
    			)
    	);
    	$index->update( $doc );
    	
    }
    
    /**
     * @author( author='Carey' )
     * @date( date = '2016-03-24' )
     * @comment( comment = '设置文章是否置顶' )
     * @method( method = 'setTopsAction' )
     * @op( op = '' )
     */
   	public function setTopsAction()
   	{
   		$objRet = new \stdClass();
   		$optid = $this->dispatcher->getParam( 'id', 'int');
   		if( ! $optid )
   		{
   			$objRet->state = 1;
   			$objRet->msg = '对不起,参数获取失败,请稍后再试...';
   			
   			echo json_encode( $objRet );
   			exit;
   		}
   		
   		$where = array(
   			'conditions'=> 'delsign=:del: and id=:optid:',
   			'bind'		=> array( 'del' => SystemEnums::DELSIGN_NO, 'optid' => $optid ),
   		);
   		$result = Articles::findFirst( $where );
   		if( $result && count( $result ) > 0  )
   		{
   			if( !$result->top )
   			{
   				$result->top = 1;
   				$objRet->msg = '操作成功,该文章已被置顶..';
   			}
   			else
   			{
   				$result->top = 0;
   				$objRet->msg = '操作成功,该文章已被取消置顶..';
   			}
   			
   			if( $result->save() )
   			{
   				$objRet->state = 0;
   				$objRet->optType = $result->top;
   				$objRet->optid = $result->id;
   			}
   			else
   			{
   				$objRet->state = 1;
   				$objRet->msg = '操作失败,请稍后刷新页面重试...';
   			}
   		}
   		else
   		{
   			$objRet->state = 1;
   			$objRet->msg = '对不起,数据未找到,请刷新后再试...';
   		}
   		
   		echo json_encode( $objRet );
   	}
}
