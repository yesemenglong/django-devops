import {
    ajaxGet,
    ajaxPost,
    ajaxDelete,
    ajaxPut,
    ajaxPatch,
    uploadImg,
    ajaxGetDetailByID,
    ajaxPostNoTime,
    ajaxPutByZoneID
} from './request';
import {url} from './url';
// 获取系统所有api列表
export const getSystemLyapiList = params => ajaxGet({url: `lyapi.json`,params})
// 获取登录页的信息
export const login = params => ajaxPost({url: `token/`,params})
// 获取验证码
export const getCaptcha = params => ajaxGet({url: `captcha/`,params})
// 获取菜单
export const apiSystemWebRouter = params => ajaxGet({url: `system/menu/web_router/`,params})
//系统监控
export const monitorGetSystemInfo = params => ajaxGet({url: `monitor/getsysteminfo/`,params})

/**
*系统配置
 * */

// 系统配置
export const platformsettingsSysconfig = params => ajaxGet({url: `platformsettings/sysconfig/`,params})
// 系统配置 -- 新增
export const platformsettingsSysconfigAdd = params => ajaxPost({url: `platformsettings/sysconfig/`,params})
// 系统配置 -- 编辑
export const platformsettingsSysconfigEdit = params => ajaxPut({url: `platformsettings/sysconfig/`,params})
// 系统配置 -- 删除
export const platformsettingsSysconfigDelete = params => ajaxDelete({url: `platformsettings/sysconfig/`,params})
// 系统配置 -- 保存子项
export const platformsettingsSysconfigSavecontent = params => ajaxPut({url: `platformsettings/sysconfig/save_content/`,params})

/**
*计划任务
 * */

// 计划任务
export const crontabPeriodictask = params => ajaxGet({url: `crontab/periodictask/`,params})
// 计划任务 -- 新增
export const crontabPeriodictaskAdd = params => ajaxPost({url: `crontab/periodictask/`,params})
// 计划任务 -- 编辑
export const crontabPeriodictaskEdit = params => ajaxPut({url: `crontab/periodictask/`,params})
// 计划任务 -- 删除
export const crontabPeriodictaskDelete = params => ajaxDelete({url: `crontab/periodictask/`,params})
// 计划任务 -- 开始/暂停
export const crontabPeriodictaskEnabled = params => ajaxPut({url: `crontab/periodictask/enabled/`,params})
// 计划任务 获取本地所有tasks文件中的task任务方法
export const crontabPeriodictaskMethodlist = params => ajaxGet({url: `crontab/periodictask/tasklist/`,params})

// 计划任务 获取任务执行结果
export const crontabTaskresult = params => ajaxGet({url: `crontab/taskresult/`,params})


/**
*终端服务
 * */

// 终端服务
export const apiTerminal = params => ajaxGet({url: `terminal/terminal/`,params})
// 终端服务 -- 新增
export const apiTerminalAdd = params => ajaxPost({url: `terminal/terminal/`,params})
// 终端服务 -- 编辑
export const apiTerminalEdit = params => ajaxPut({url: `terminal/terminal/`,params})
// 终端服务 -- 删除
export const apiTerminalDelete = params => ajaxDelete({url: `terminal/terminal/`,params})

/**
*系统管理
 * */
// 部门管理列表
export const apiSystemDept = params => ajaxGet({url: `system/dept/`,params})
// 部门管理列表 -- 新增部门
export const apiSystemDeptAdd = params => ajaxPost({url: `system/dept/`,params})
// 部门管理列表 -- 编辑部门
export const apiSystemDeptEdit = params => ajaxPut({url: `system/dept/`,params})
// 部门管理列表 -- 删除部门
export const apiSystemDeptDelete = params => ajaxDelete({url: `system/dept/`,params})


// 菜单管理列表
export const apiSystemMenu = params => ajaxGet({url: `system/menu/`,params})
// 菜单管理列表 -- 新增菜单
export const apiSystemMenuAdd = params => ajaxPost({url: `system/menu/`,params})
// 菜单管理列表 -- 编辑菜单
export const apiSystemMenuEdit = params => ajaxPut({url: `system/menu/`,params})
// 菜单管理列表 -- 删除菜单
export const apiSystemMenuDelete = params => ajaxDelete({url: `system/menu/`,params})
//获取部门数据,获取菜单树
export const systemMenuTree = params => ajaxGet({url: `system/menu_tree/`,params})
// 菜单管理 》 按钮列表(全部)
export const systemButton = params => ajaxGet({url:`system/button/`,params})
// 菜单管理 》 按钮 编辑
export const systemButtonEdit = params => ajaxPut({url:`system/button/`,params})
// 菜单管理 》 按钮 新增
export const systemButtonAdd = params => ajaxPost({url:`system/button/`,params})
// 菜单管理 》 按钮 删除
export const systemButtonDelete = params => ajaxDelete({url:`system/button/`,params})
// 菜单管理 》 按钮配置列表（针对单个菜单）
export const systemMenuButton = params => ajaxGet({url:`system/menu_button/`,params})
// 菜单管理 》 按钮配置列表（针对单个菜单） 新增
export const systemMenuButtonAdd = params => ajaxPost({url:`system/menu_button/`,params})
// 菜单管理 》 按钮配置列表（针对单个菜单） 编辑
export const systemMenuButtonEdit = params => ajaxPut({url:`system/menu_button/`,params})
// 菜单管理 》 按钮配置列表（针对单个菜单） 删除
export const systemMenuButtonDelete = params => ajaxDelete({url:`system/menu_button/`,params})


// 角色管理列表
export const apiSystemRole = params => ajaxGet({url: `system/role/`,params})
// 角色管理列表-修改
export const apiSystemRoleEdit = params => ajaxPut({url: `system/role/`,params})
// 角色管理列表 -- 新增角色
export const apiSystemRoleAdd = params => ajaxPost({url: `system/role/`,params})
// 角色管理列表 -- 新增角色
export const apiSystemRoleDelete = params => ajaxDelete({url: `system/role/`,params})
//获取部门数据,用于角色授权
export const apiSystemDeptTree = params => ajaxGet({url: `system/dept_tree/`,params})
//通过角色id,获取菜单数据
export const apiSystemRoleIdToMenu = params => ajaxGet({url: `system/role_id_to_menu/`,params})
export const apiSystemRoleIdToMenuid = (id) => ajaxGet({url: `system/role_id_to_menu/`+id+'/'})

//权限管理
// 权限管理 -- 保存
export const apiPermissionSave = params => ajaxPut({url: `system/permission/`,params})

//管理员管理
export const apiSystemUser = params => ajaxGet({url: `system/user/`,params})
//管理员管理-新增
export const apiSystemUserAdd = params => ajaxPost({url: `system/user/`,params})
//管理员管理-修改
export const apiSystemUserEdit = params => ajaxPut({url: `system/user/`,params})
//管理员管理-删除
export const apiSystemUserDelte = params => ajaxDelete({url: `system/user/`,params})

/**
 *日志管理
 * */
// 日志管理 查询
export const systemOperationlog= params => ajaxGet({url: `system/operation_log/`,params})
// 日志管理 删除
export const systemOperationlogDelete= params => ajaxDelete({url: `system/operation_log/`,params})
// 日志管理 清空全部日志
export const systemOperationlogDeletealllogsDelete= params => ajaxDelete({url: `system/operation_log/deletealllogs/`,params})

/**
 *个人中心
 * */
// 获取当前个人用户信息
export const systemUserUserInfo= params => ajaxGet({url: `system/user/user_info/`,params})
// 更新修改当前个人用户信息
export const systemUserUserInfoEdit= params => ajaxPut({url: `system/user/user_info/`,params})
// 用户重置个人密码
export const systemUserChangePassword= params => ajaxPut({url: `system/user/change_password/`,params})


/**
 *消息中心
 * */
//消息模板
export const messagesMessagetemplate = params => ajaxGet({url: `messages/messagetemplate/`,params})
//消息模板-新增
export const messagesMessagetemplateAdd = params => ajaxPost({url: `messages/messagetemplate/`,params})
//消息模板-修改
export const messagesMessagetemplateEdit = params => ajaxPut({url: `messages/messagetemplate/`,params})
//消息模板-删除
export const messagesMessagetemplateDelete = params => ajaxDelete({url: `messages/messagetemplate/`,params})

//消息公告
export const messagesMessagenotice = params => ajaxGet({url: `messages/messagenotice/`,params})
//消息公告-新增
export const messagesMessagenoticeAdd = params => ajaxPost({url: `messages/messagenotice/`,params})
//消息公告-修改
export const messagesMessagenoticeEdit = params => ajaxPut({url: `messages/messagenotice/`,params})
//消息公告-删除
export const messagesMessagenoticeDelete = params => ajaxDelete({url: `messages/messagenotice/`,params})

/**
 *用户管理
 * */

// 用户管理 列表
export const UsersUsers= params => ajaxGet({url: `users/users/`,params})
// 用户管理 新增
export const UsersUsersAdd= params => ajaxPost({url: `users/users/`,params})
// 用户管理 编辑
export const UsersUsersEdit= params => ajaxPut({url: `users/users/`,params})
// 用户管理 删除
export const UsersUsersDelete= params => ajaxDelete({url: `users/users/`,params})
// 用户管理 禁用用户
export const UsersUsersdisableEdit= params => ajaxPut({url: `users/users/disableuser/`,params})
// 用户管理 导出
export const UsersUsersExportexecl= params => ajaxGet({url: `users/users/exportexecl/`,params})

// 平台设置 图片上传
export const platformsettingsUploadPlatformImg= params => uploadImg({url: `platformsettings/uploadplatformimg/`,params})

export const dashboard = params =>  ajaxPost({url: `dashboard/`, params})
export const getMinionIdList = params => ajaxGet({url: `saltstack/salt-minion/1/`, params})

// salt-key api
export const getSaltKeyList = params => ajaxGet({url: `saltstack/salt-key/`, params})
export const flushSaltKeyList = params => ajaxPost({url: `saltstack/salt-key/`, params})
export const acceptSaltKey = params => ajaxPost({url: `saltstack/salt-key-opt/accept/`, params})
export const deleteSaltKey = params => ajaxPost({url: `saltstack/salt-key-opt/delete/`, params})
export const deleteDeniedSaltKey = params => ajaxPost({url: `saltstack/salt-key-opt/del-denied/`, params})
export const rejectSaltKey = params => ajaxPost({url: `saltstack/salt-key-opt/reject/`, params})
export const testSaltKey = params => ajaxGet({url: `saltstack/salt-key/`+params+'/'})
// SaltStack minion api
export const getSaltMinionList = params => ajaxGet({url: `saltstack/salt-minion/`, params})
export const updateMinionList = params => ajaxPost({url: `saltstack/salt-minion/`, params})
export const updateMinionStatus = params => ajaxPost({url: `saltstack/salt-minion-opt/status-update/`, params})
export const updateMinion = params => ajaxPost({url: `saltstack/salt-minion-opt/update/`, params})
// SaltStack 命令集
export const getSaltCmdList = params => ajaxGet({url: `saltstack/salt-cmd/`, params})
export const updateSaltCmdList = params => ajaxPost({url: `saltstack/salt-cmd/`, params})
export const deleteSaltCmd = params => ajaxPost({url: `saltstack/salt-cmd-opt/delete/`, params})
export const getSaltCmdModuleList = params => ajaxGet({url: `saltstack/salt-cmd-opt/get-module/`, params})
export const getSaltCmdCmdList = params => ajaxGet({url: `saltstack/salt-cmd-opt/get-cmd/`, params})
export const saltExe = params => ajaxPostNoTime({url: `saltstack/salt-exe/`, params})

// 区服相关
export const getZoneList = params => ajaxGet({url: `zonelist/`, params})
export const getZone = params => ajaxGet({url: `zonelist/` + params + `/`})
export const createZoneInfo = params => ajaxPost({url: `zonelist/`, params})
export const updateZoneInfo = params => ajaxPutByZoneID({url: `zonelist/`, params})
export const deleteZoneInfo = params => ajaxDelete({url: `zonelist/` + params + `/`})
export const batchCrateZones = params => ajaxPost({url: `zonelist_batchCreate/`, params})
export const minionIDList = params => ajaxGet({url: `minion_id_list/`, params})
export const getZoneStatusList = params => ajaxGet({url: `zone_list_status/`, params})
export const deployZone = params => ajaxPost({url: `deploy_zone/`, params})
export const batchDeployZones = params => ajaxPost({url: `batch_deploy_zones/`, params})
export const updateVersion = params => ajaxPut({url: `version/`, params})
export const getVersion = params => ajaxGet({url: `version/`+ params + `/`})
// 合服相关
export const getMergeList = params => ajaxGet({url: `zone_merge/`, params})
export const addMergeInfo = params => ajaxPost({url: `zone_merge/`, params})
export const updateMergeInfo = params => ajaxPut({url: `zone_merge/`, params})
export const getMergeInfo = params => ajaxGet({url: `zone_merge/` + params + `/`})
export const deleteMergeInfo = params => ajaxDelete({url: `zone_merge/` + params + `/`})
export const exeMerge = params => ajaxPost({url: `zone_merge_exe/`, params})
export const addBatchMergeInfo = params => ajaxPost({url: `batch_zone_merge/`, params})
// 区服迁移
export const getMoveList = params => ajaxGet({url: `zone_move/`, params})
export const addMoveInfo = params => ajaxPost({url: `zone_move/`, params})
export const updateMoveInfo = params => ajaxPut({url: `zone_move/`, params})
export const getMoveInfo = params => ajaxGet({url: `zone_move/` + params + `/`})