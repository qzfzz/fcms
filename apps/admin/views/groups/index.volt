<!doctype html>
<html>
    <head>
        <link rel="stylesheet" href="/css/admin/base.css">
        <link rel="stylesheet" href="/bootstrap/3.3.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="/bootstrap/toastr/toastr.min.css">
        <link rel="stylesheet" href="/bootstrap/jqueryConfirm/2.5.0/jquery-confirm.css">
    </head>
    <body class="wrap">
        <ul class="nav nav-tabs" role="tablist">
            <li role="presentation" class="active"><a href="#groupList">用户组</a></li>
            <li role="presentation"><a href="/admin/groups/add">添加用户组</a></li>
        </ul>
        <div class="tab-content" style="padding:20px 0px;">
            <div role="tabpannel" class="tab-pane active" id="userList">
                <table class="table table-hover table-bordered">
                    <thead>
                        <tr>
                            <th>组名</th>
                            <th>角色名</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        {% for key, item in groupList %}
                        <tr>
                            <td>{{ item[ 'group_name' ] | e }}</td>
                            <td>{% for role_name in item[ 'roles_name' ] %} {{ role_name | e }} {% endfor %}</td>
                            <td>
                                <i class="glyphicon glyphicon-trash operate groupDelete" data-id="{{ key }}" style="margin-right: 10px;"></i>
                                <a href="{{ url( 'admin/groups/edit?id=' ) }}{{ key }}"><i class="glyphicon glyphicon-pencil operate userEdit" ></i></a>
                            </td>
                        </tr>
                        {% endfor %}
                    </tbody>
                </table>
            
            </div>
        </div>
        <script src="/js/jquery/jquery-1.11.1.min.js"></script>
        <script src="/bootstrap/toastr/toastr.min.js"></script>
        <script src="/bootstrap/jqueryConfirm/2.5.0/jquery-confirm.js"></script>
        <script>
        $( function(){
           /*----------------删除-----------------*/
           var csrf = { key: '{{ security.getTokenKey() }}', token: '{{ security.getToken() }}'};
           $( 'table' ).on( 'click', '.groupDelete',  function(){
                var id = $( this ).attr( 'data-id' );
                var data = { id: id, key: csrf.key, token: csrf.token };
                var _this = this;

                $.confirm( { title: '是否删除该用户组？', confirm: function(){
                    $.post( '/admin/groups/delete', data, function( ret ){
                        if( !ret.status )
                        {
                            $( _this ).parents( 'tr' ).remove();
                        }
                        else
                        {
                            toastr.error( ret.msg );
                        }
                        csrf = { key: csrf.key, token: csrf.token };
                    }, 'json').error(function(){ //网络不通
                        toastr.error( '网络不通' );
                    });
                }});
           });
        });
        </script>
    </body>
</html>