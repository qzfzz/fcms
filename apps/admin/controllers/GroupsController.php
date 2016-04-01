<?php

/**
 * 分组管理
 * @author hfc
 * time 2015-7-5
 */

namespace apps\admin\controllers;
!defined( 'APP_ROOT' ) && exit( 'Direct Access Deny!' );

use apps\admin\models\PriGroups;
use apps\admin\models\PriGroupsRoles;
use apps\admin\models\PriRoles;
use enums\SystemEnums;
use libraries\TimeUtils;
use Phalcon\Mvc\Model\Resultset;

class GroupsController extends AdminBaseController{
    
    public function initialize()
    {                
        parent::initialize();
    }
    
    /**
     * @author( author='hfc' )
     * @date( date = '2015-8-24' )
     * @comment( comment = '管理员的首页' )	
     * @method( method = 'indexAction' )
     * @op( op = '' )		
    */
    public function indexAction()
    {
        $groupModel = new PriGroups();
        $result = $groupModel->getGroup();
        
        $groupsList = array();
        foreach( $result as $item )
        {
            $groupsList[ $item->group_id ][ 'group_name' ] = $item->group_name; 
            $groupsList[ $item->group_id ][ 'roles_name'] [] = $item->role_name;
        }
        
        $this->view->groupList = $groupsList;
    }
    
    /**
     * @author( author='hfc' )
     * @date( date = '2015-8-24' )
     * @comment( comment = '编辑用户组界面显示' )	
     * @method( method = 'editAction' )
     * @op( op = '' )		
    */
    public function editAction()
    {
        $id = $this->request->getQuery( 'id', 'int' );
        
        $priGroup = PriGroups::findFirst( array( 'id=?0', 'bind' => array( $id ) ) );
          
        if( $priGroup )
        {
            $this->view->group = $priGroup->toArray();
            //当前组所包含的角色
            $groupRoles = array();
            $roles = $priGroup->getPriGroupsRoles( 
                    array( 
                        'delsign=?0 AND id!=?1',
                        'bind' => [ SystemEnums::DELSIGN_NO, SystemEnums::SUPER_ADMIN_ID ] 
                    ) 
            );
            foreach( $roles  as $item )
            {
                $groupRoles[] = $item->roleid;
            }
            $this->view->groupRoles = $groupRoles;
        }
        //所有的角色
        $roles = PriRoles::find( 'delsign=' . SystemEnums::DELSIGN_NO . ' and id!=' . SystemEnums::SUPER_ADMIN_ID );
        $this->view->roles = $roles->toArray();
        
    }
    
    /**
     * @author( author='hfc' )
     * @date( date = '2015-8-24' )
     * @comment( comment = '添加用户界面显示' )	
     * @method( method = 'addAction' )
     * @op( op = '' )		
    */
    public function addAction()
    {
        $this->view->roles = PriRoles::find( 
                array( 
                    'delsign=' . SystemEnums::DELSIGN_NO . ' and id!=' . SystemEnums::SUPER_ADMIN_ID,
                    'columns' => 'id,name',
                    'hydration' => Resultset::HYDRATE_ARRAYS
                ) 
        );
    }
    
    /**
     * @author( author='hfc' )
     * @date( date = '2015-8-24' )
     * @comment( comment = 'ajax 请求 更新用户' )	
     * @method( method = 'updateAction' )
     * @op( op = 'u' )		
    */
    public function updateAction()
    {
        $this->csrfCheck();
        
        $groupId = $this->request->getPost( 'groupId', 'int' );
        $groupName = $this->request->getPost( 'groupName', 'string' );
        $roles = $this->request->getPost( 'roles' );
        
        $group = PriGroups::findFirst( array( 'id=?0', 'bind' => array($groupId) ));
        $group->name = $groupName;
        $group->priGroupsRoles->delete(); //把以前的删除 
        
        $groupsRoles = array();
        foreach( $roles as $id )
        {
            $gr = new PriGroupsRoles();
            $gr->roleid = $id;
            $gr->addtime = TimeUtils::getFullTime();
            $gr->delsign = SystemEnums::DELSIGN_NO;
            $groupsRoles[] = $gr;
        }
        $group->priGroupsRoles = $groupsRoles ;
        
        if( $group->save() &&  $this->setAcl( $group->id ) )
        {
            $this->success( '更新成功' );
        }
        else
        {
            $this->error( '更新失败' );
        }
        
    }

    /**
     * @author( author='hfc' )
     * @date( date = '2015-8-24' )
     * @comment( comment = 'ajax 请求 删除用户组' )	
     * @method( method = 'deleteAction' )
     * @op( op = 'd' )		
    */
    public function deleteAction()
    {
       	$this->csrfCheck();
        
        $id = $this->request->getPost( 'id', 'int' );
        $userInfo = $this->session->get( 'userInfo' );
        
        if( $userInfo )
        {
            if( $id  === $userInfo[ 'groupid'] )
            {
                $this->error( '不可删除自己所在的组' );
            }
        }
        $priGroups = PriGroups::findFirst( array( 'id=?0', 'bind' => array( $id )));
        if( $priGroups )
        {
            $isSuccessGroup = $priGroups->update( array( 'delsign' => SystemEnums::DELSIGN_YES, 'uptime' => TimeUtils::getFullTime() ));
            $isSuccessUser = $priGroups->priGroupsUsers->delete();//删除对应组下的用户
            $isSuccessRole = $priGroups->priGroupsRoles->delete();
            
            if( $isSuccessGroup && $isSuccessRole )
                $this->success( '删除成功' );
        }
        $this->error( '删除失败' );
    }
    
    /**
     * @author( author='hfc' )
     * @date( date = '2015-8-24' )
     * @comment( comment = 'ajax 请求 添加一个新用户组' )	
     * @method( method = 'insertAction' )
     * @op( op = 'c' )		
    */
    public function insertAction()
    {
        $this->csrfCheck(); //csrf检验
        
        $data[ 'name' ] = $this->request->getPost( 'groupName', 'trim' );
        $roles = $this->request->getPost( 'roles', 'trim' );
        $data[ 'addtime' ] = $data[ 'uptime' ] =TimeUtils::getFullTime();
        $data[ 'delsign' ] = $data[ 'shopid' ] = SystemEnums::DELSIGN_NO;
        
        $priGroup = PriGroups::findFirst( [ 'name=?0 and delsign=' . SystemEnums::DELSIGN_NO , 'bind' => [ $data[ 'name']]] );
        if( $priGroup ) 
        {
            $this->error( '已经用户组存在了' );
        }
        
        $groups = new PriGroups();
        $groupsRoles = array();
        foreach ( $roles as $id )
        {
            $gr = new PriGroupsRoles();
            $gr->roleid = $id;
            $gr->addtime = TimeUtils::getFullTime();
            $gr->delsign = SystemEnums::DELSIGN_NO;
            $groupsRoles[] = $gr; 
        }
        $groups->priGroupsRoles = $groupsRoles;
        
        if( $groups->save( $data ) && $this->setAcl( $groups->id )) 
        {
            $this->success( '保存成功' );
        }
        else
        {
            $this->error( '保存失败' );
        }
    }
    
    
    
}
