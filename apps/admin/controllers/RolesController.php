<?php

/**
 * 角色管理
 * @author hfc
 * time 2015-7-5
 */

namespace apps\admin\controllers;
!defined( 'APP_ROOT' ) && exit( 'Direct Access Deny!' );

use apps\admin\models\PriPris;
use apps\admin\models\PriRoles;
use apps\admin\models\PriRolesPris;
use enums\SystemEnums;
use Phalcon\Mvc\Model\Resultset;
use libraries\TimeUtils;

class RolesController extends AdminBaseController{
    
    private $pris = array();
    
    public function initialize()
    {            
        parent::initialize();
    }
    
    /**
     * @author( author='hfc' )
     * @date( date = '2015-8-24' )
     * @comment( comment = '角色列表页' )	
     * @method( method = 'indexAction' )
     * @op( op = 'r' )		
    */
    public function indexAction()
    {
        $rolesList = PriRoles::find( 
                array( 
                        'delsign=' . SystemEnums::DELSIGN_NO . ' and id!=' . SystemEnums::SUPER_ADMIN_ID,
                        'columns' => 'id,name,descr',
                        'hydration' => Resultset::HYDRATE_ARRAYS,
                    )
                );
       
        $this->view->rolesList = $rolesList;
    }
    
    /**
     * @author( author='hfc' )
     * @date( date = '2015-8-24' )
     * @comment( comment = '编辑角色界面显示' )	
     * @method( method = 'editAction' )
     * @op( op = '' )		
    */
    public function editAction()
    {
        $id =  $this->request->getQuery( 'id', 'int' )  ;
        
        $priRole = PriRoles::findFirst( array( 'id=?0', 'bind' => array( $id ) ) );
          
        if( $priRole )
        {
            $this->view->role = $priRole->toArray();
            //当前角色包含的所有权限
            $rolePris = array();
            foreach( $priRole->priRolesPris as $item )
            {
                $rolePris[ $item->priid ] =  $item->id;
            }
            $this->view->rolePris = $rolePris;
        }
        //所有的权限项
        $this->view->pris = $this->_getPriTree();
    }
    
    /**
     * @author( author='hfc' )
     * @date( date = '2015-8-24' )
     * @comment( comment = '添加角色界面显示' )	
     * @method( method = 'addAction' )
     * @op( op = '' )		
    */
    public function addAction()
    {
        $this->view->pris = $this->_getPriTree();
        $this->view->pick( 'roles/edit' );
    }
    
    /**
     * @author( author='hfc' )
     * @date( date = '2015-8-24' )
     * @comment( comment = 'ajax请求 更新角色' )	
     * @method( method = 'updateAction' )
     * @op( op = 'c' )		
    */
    public function updateAction()
    {
        $this->csrfCheck();
        
        $roleId = $this->request->getPost( 'roleId', 'int' );
        $data[ 'name' ] = $this->request->getPost( 'roleName', 'trim' );
        $data[ 'descr' ] = $this->request->getPost( 'roleDescr', 'string' );
        $add = $this->request->getPost( 'add' );
        $del = $this->request->getPost( 'del' );
        $data[ 'uptime' ] = TimeUtils::getFullTime();
        $role = PriRoles::findFirst( [ 'id=?0 and delsign=' . SystemEnums::DELSIGN_NO, 'bind' => [ $roleId ] ]);
        $status = false;
        
        if( $role->update( $data ) )
        {
            if( ! empty( $del )) //删除
            {
                $str  = implode( ',', $del );
                $status = PriRolesPris::find( [ 'id in (' . $str . ')' ])->delete();
            }
            if( ! empty( $add )) //添加
            {
               $model = new PriRolesPris();
               $status = $model->addData( $roleId, $add );
            }
            
            if( $status ) //角色相关的组， 进行acl的修改
            {
                $phql = 'select groupid from apps\admin\models\PriGroupsRoles where roleid=?0';
                $groupRoles = $this->modelsManager->executeQuery( $phql , [ $roleId ]);
                foreach( $groupRoles as $gr )
                {
                    if( ! $this->setAcl( $gr->groupid ))
                    {
                        $this->error( '更新失败' );
                    }
                }
            }
            
            if( ( empty( $del ) && empty( $add ) ) || $status )
            {
                $this->success( '更新成功' );
            }
            
        }
       
        $this->error( '更新失败' );
        
    }

    /**
     * @author( author='hfc' )
     * @date( date = '2015-8-24' )
     * @comment( comment = 'ajax请求 删除角色' )	
     * @method( method = 'deleteAction' )
     * @op( op = 'd' )		
    */
    public function deleteAction()
    {
        $this->csrfCheck();
        $id = $this->request->getPost( 'id', 'int' );
        
        if( $id )
        {
            $priRoles = PriRoles::findFirst( array( 'id=?0', 'bind' => array( $id )));
            if( $priRoles )
            {
                $isRoles = $priRoles->update( array( 'delsign' => SystemEnums::DELSIGN_YES, 'uptime' => TimeUtils::getFullTime() ));
                $isRolesGroup = $priRoles->priGroupsRoles->delete(); //删除组下对应的角色
                $isPris = $priRoles->priRolesPris->delete();
                if( $isPris && $isPris )
                {
                   $this->success( '删除成功' );
                }
            }
        }
        $this->error( '删除失败' );
    }
    
    /**
     * @author( author='hfc' )
     * @date( date = '2015-8-24' )
     * @comment( comment = 'ajax 请求 添加一个新角色' )	
     * @method( method = 'insertAction' )
     * @op( op = 'c' )		
    */
    public function insertAction()
    {
        $this->csrfCheck(); //csrf检验
        
        $data[ 'name' ] = $this->request->getPost( 'roleName', 'trim' );
        $data[ 'descr' ] = $this->request->getPost( 'roleDescr', 'string' );
        $add = $this->request->getPost( 'add' );
        $data[ 'addtime' ]  = $data[ 'uptime' ] = TimeUtils::getFullTime();
        $data[ 'delsign' ] = $data[ 'shopid' ] = SystemEnums::DELSIGN_NO;
        //判断是否角色名是否重复
        $priRole = PriRoles::findFirst( [ 'name=?0 and delsign=' . SystemEnums::DELSIGN_NO , 'bind' => [ $data[ 'name']]] );
        if( $priRole ) 
        {
            $this->error( '已经角色存在了' );
        }
        
        $role = new PriRoles();
        if( $role->save( $data ) && (! empty( $add)) )
        {
            $model = new PriRolesPris();
            if( $model->addData( $role->id, $add ) )
                $this->success( '添加成功' );
        }
        $this->error( '添加失败');
    }
    
    /**
     * 得到管理后台权限项
     * param number $parentid 
     */
    private function _getPriTree( )
    {
        $ret = array();
        $where = 'delsign='. SystemEnums::DELSIGN_NO . ' and (type = ' . SystemEnums::PRI_ACTION . ' or type = ' . SystemEnums::PRI_MENU . ')';
        $arrPris = PriPris::find( array( $where, 'columns' => 'id,name,pid,src', 'order' => 'id' ) )->toArray();
        if( $arrPris )
        {
            foreach( $arrPris as $item )
            {
                $ret[ $item[ 'pid'] ][] = $item; 
            }
        }
        return $ret;
    }
    
}
