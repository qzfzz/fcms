<?php
namespace apps\admin\controllers;
!defined( 'APP_ROOT' ) && exit( 'Direct Access Deny!' );

use apps\admin\models\Articles;
use enums\SystemEnums;
use Phalcon\Paginator\Adapter\QueryBuilder;
use libraries\TimeUtils;
use apps\admin\models\ArticleCats;

/**
 * 文章
 * @author New
 * time 2015-12-24
 */

class ArticletrashController extends AdminBaseController
{
    
    public function initialize()
    {
        parent::initialize();
    }
    
    /**
     * @author( author='New' )
     * @date( date = '2015-12-24' )
     * @comment( comment = '文章回收站主页' )
     * @method( method = 'index' )
     * @op( op = '' )
     */
    public function indexAction()
    {
        $pageNum = $this->dispatcher->getParam( 'page', 'int' );
        $currentPage = $pageNum ? $pageNum : 1;
        
    	
    	$builder = $this->modelsManager->createBuilder()
			    	->from( 'apps\admin\models\Articles' )
			    	->where( 'delsign='.SystemEnums::DELSIGN_YES );
    	
    	$paginator = new  QueryBuilder( array(
    			'builder' => $builder,
    			'limit' => 10,
    			'page' => $currentPage
    	));
    	$page = $paginator->getPaginate();
    	
    	$this->view->page = $page;
    	
    }
    
    /**
     * @author( author='New' )
     * @date( date = '2015-12-24' )
     * @comment( comment = '将文章delsign从1修改为0' )
     * @method( method = 'recoverSelectAction' )
     * @op( op = 'r' )
     */
    public function recoverSelectAction()
    {
        $this->csrfCheck();
        
        $arrCatids = array();
        $catids = rtrim( $this->request->getPost( 'catids' ), ',' );//文章分类
        $ids = $this->request->getPost( 'ids' );
        $type = $this->request->getPost( 'type', 'string' );
        
        if( $catids )
        {
        	$arrCatids = array_unique( explode( ',',  $catids ) );
        }
        $strCatids = implode( $arrCatids, ',' );
        
        if( false != $type && 'all' == $type )
        {//全选
            $where = array(
                'conditions'=>'delsign=:del:',
                'bind'		=> array( 'del' => SystemEnums::DELSIGN_YES ),
            );
            $delArtCat = ArticleCats::find( $where );
            if( $delArtCat && count( $delArtCat ) > 0 )
            {//存在已经删除的分类
                $arrCatids = array(); // 已删除的文章分类id
                $arrIds = array();//已删除的文章id
                foreach ( $delArtCat as $cat )
                {
                    $where = array(
                    	'conditions' => 'delsign=:del:',
                         'bind'     => array( 'del' => SystemEnums::DELSIGN_YES ),
                    );
                    $res = $cat->getArticlelist( $where );
                    if( $res && count( $res ) > 0 )
                    {//文章在删除列表中
                       foreach( $res as $row )
                       {
                           array_push( $arrIds , $row->id );
                       }
                       array_push( $arrCatids , $cat->id );
                    }
                }
                if( count( $arrCatids ) > 0 && count( $arrIds ) > 0 )
                {
                    $this->error( '恢复终止,存在文章分类已被删除' , array( 'catids' => $arrCatids , 'optids' =>$arrIds  ) );
                    exit;
                }
            }
        }
        else 
       {
           $where = array(
               'conditions'=>'delsign=:del: and id in (' . $strCatids . ')',
               'bind'		=> array( 'del' => SystemEnums::DELSIGN_YES ),
           );
           $delArtCat = ArticleCats::find( $where );
           if( $delArtCat && count( $delArtCat ) > 0 )
           {
               $this->error( '恢复终止,存在文章分类已被删除' , array( 'catids' => $arrCatids , 'optids' => array_unique( explode( ',' ,  $ids ) ) ) );
               exit;
           }
        }
        if( false != $type && 'all' == $type )
        {//恢复所有文章
            $where = array(
                'conditions' => 'delsign=:del:',
                'bind'       => array( 'del' => SystemEnums::DELSIGN_YES ),
            );
        }
        else 
        {//恢复单篇或所选文章
            if( false == $ids || strlen( $ids ) < 0 )
                $this->error( '参数错误' );
            
            //恢复所选文章(如果恢复单篇文章则不需要进行数据整合)
            if( strpos( $ids, ',' ) )
                $ids = substr( $ids, 0, strlen( $ids ) - 1 );
            
            $where = array(
                'conditions' => 'delsign=:del: and id in (' . $ids . ')',
                'bind'       => array( 'del' => SystemEnums::DELSIGN_YES ),
            );
        }
        
        $articles = Articles::find( $where );
        if( false != $articles && count( $articles ) > 0 )
        {
        	$arrOptIds = array();
            foreach( $articles as $row )
            {
                $row->delsign = SystemEnums::DELSIGN_NO;
                $row->uptime  = TimeUtils::getFullTime();
                $row->save();
                
                array_push( $arrOptIds , $row->id );
            }
            $this->success( '恢复成功', array( 'optids' => $arrOptIds ) );
        }
        else 
            $this->error( '恢复失败' );
    }
    
    /**
     * @author( author='Carey' )
     * @date( date = '2016-03-25' )
     * @comment( comment = '获取已删除文章的分类信息' )
     * @method( method = 'getCatIdAction' )
     * @op( op = 'r' )
     */
    public function getCatIdAction()
    {
    	$objRet = new \stdClass();
    	
    	$optid = $this->dispatcher->getParam( 'id' , 'int' );
    	if( ! $optid )
    	{
    		$objRet->state = 1;
    		$objRet->msg = '参数获取失败,请稍后刷新后再试...';

    		echo json_encode( $objRet );
    		exit;
    	}
    	
    	$where = array(
    		'conditions'=> 'delsign=:del: and id=:optid:',
    		'bind'		=> array( 'del' => SystemEnums::DELSIGN_YES, 'optid' => $optid ),
    	);
    	$result = ArticleCats::findFirst( $where );
    	if( $result && count( $result ) > 0 )
    	{
    		$objRet->state = 0;
    		$objRet->optid = $result->id;
    		$objRet->title = $result->name;
    	}
    	else
    	{
    		$objRet->state = 1;
    		$objRet->msg = '对不起,该分类信息未找到...';
    	}
    	
    	echo json_encode( $objRet );
    }
    
    /**
     * @author( author='Carey' )
     * @date( date = '2016-03-25' )
     * @comment( comment = '重置已删除分类信息 - 恢复' )
     * @method( method = 'recoveryCateAction' )
     * @op( op = 'r' )
     */
    public function recoveryCateAction()
    {
    	$this->csrfCheck();
    	
    	$objRet = new \stdClass();
    	
    	$optid = $this->request->getPost( 'id', 'int' );
    	$name = $this->request->getPost( 'name', 'string' );
    	if( !$optid )
    	{
    		$objRet->state = 1;
    		$objRet->msg = '参数获取失败,请稍后再试...';
    		$objRet->key = $this->security->getTokenKey();
    		$objRet->token = $this->security->getToken();
    		
    		echo json_encode( $objRet );
    		exit;
    	}
    	
    	$where = array(
    		'conditions'=> 'delsign=:del: and id=:optid:',
    		'bind'		=> array( 'del' => SystemEnums::DELSIGN_YES, 'optid' => $optid ),
    	);
    	$result = ArticleCats::findFirst( $where );
    	if( $result && count( $result ) > 0 )
    	{
    		$result->delsign = SystemEnums::DELSIGN_NO;
    		$result->name = $name;
    		$result->uptime = TimeUtils::getFullTime();
    		if( $result->save() )
    		{
    			$objRet->state = 0;
    			$objRet->optid = $result->id;
    			$objRet->msg = '操作成功,该文章分类已恢复成功..';
    		}
    		else 
    		{
    			$objRet->state = 1;
    			$objRet->msg = '操作失败,请刷新后再试...';
    		}
    	}
    	else
    	{
    		$objRet->state = 1;
    		$objRet->msg = '对不起,该分类信息未找到...';
    	}
    	$objRet->key = $this->security->getTokenKey();
    	$objRet->token = $this->security->getToken();
    	echo json_encode( $objRet );
    }
    
}
