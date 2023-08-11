<template>
  <div :class="{'ly-is-full':isFull}" v-loading="allLoading">
    <div class="app-container">
    <div ref="tableSelect" class="filter-container">
      <el-row :gutter="40" class="panel-group">
        <el-col :xs="12" :sm="12" :lg="4" class="card-panel-col" style="margin-left: 20px">
          <div class="card-panel" :class="{cardselected:'accepted'===certification_status}" @click="handleGetList('accepted')">
            <div class="card-panel-icon-wrapper icon-accepted">
              <el-icon size="55">
                <User />
              </el-icon>
            </div>
            <div class="card-panel-description icon-accepted">
              <div class="card-panel-text">已认证KEYS</div>
              <span  class="card-panel-num">{{ saltkey_count.accepted_count }}</span>
            </div>
          </div>
        </el-col>
        <el-col :xs="12" :sm="12" :lg="4" class="card-panel-col" style="margin-left: 60px">
          <div class="card-panel" :class="{cardselected:'unaccepted'===certification_status}" @click="handleGetList('unaccepted')">
            <div class="card-panel-icon-wrapper icon-unaccepted">
              <el-icon size="55">
                <User />
              </el-icon>
            </div>
            <div class="card-panel-description icon-unaccepted">
              <div class="card-panel-text">待认证KEYS</div>
              <span  class="card-panel-num">{{ saltkey_count.unaccepted_count }}</span>
            </div>
          </div>
        </el-col>
        <el-col :xs="12" :sm="12" :lg="4" :span="12" class="card-panel-col" style="margin-left: 60px">
          <div class="card-panel" :class="{cardselected:'denied'===certification_status}" @click="handleGetList('denied')">
            <div class="card-panel-icon-wrapper icon-denied">
              <el-icon size="55">
                <User />
              </el-icon>
            </div>
            <div class="card-panel-description icon-denied">
              <div class="card-panel-text">未允许KEYS</div>
              <span  class="card-panel-num">{{ saltkey_count.denied_count }}</span>
            </div>
          </div>
        </el-col>
        <el-col :xs="12" :sm="12" :lg="4" class="card-panel-col" style="margin-left: 60px">
          <div class="card-panel" :class="{cardselected:'rejected'===certification_status}" @click="handleGetList('rejected')">
            <div class="card-panel-icon-wrapper icon-rejected">
              <el-icon size="55">
                <User />
              </el-icon>
            </div>
            <div class="card-panel-description icon-rejected">
              <div class="card-panel-text">已拒绝KEYS</div>
              <span class="card-panel-num">{{ saltkey_count.rejected_count }}</span>
            </div>
          </div>
        </el-col>
      </el-row>

      <el-row class="saltkey_global">
        <span  class="saltkey_tag1">全局操作：</span>
        <el-button  style="margin-left: 10px" type="primary" size="default" @click="handleFlushKey">刷新列表</el-button>
        <el-tooltip effect="dark" content="只接受已认证和待认证的KEY" placement="top">
          <el-button   type="primary"  @click="handleAcceptAllKey">接受所有</el-button>
        </el-tooltip>
        <el-tooltip effect="dark" content="未被允许的KEY无法全局删除" placement="top">
          <el-button   type="danger"  @click="handleDeleteAllKey">删除所有</el-button>
        </el-tooltip>
        <span  class="saltkey_tag1" style="margin-left: 10px">批量操作：</span>
        <el-button   type="primary"  v-show="certification_status==='unaccepted'" @click="handleAcceptKeyList">批量接受</el-button>
        <el-button   type="primary" v-show="certification_status==='unaccepted'" @click="handleRejectKeyList">批量拒绝</el-button>
        <el-button  type="danger"  @click="handleDeleteKeyList">批量删除</el-button>
        <div style="margin-left: auto">
          <el-input  placeholder="Minion_ID" v-model="search" style="width: 200px;margin-right: 5px"  @keyup.enter.native="handleFilter"/>
          <el-button   type="primary"  :icon="Search" @click="handleFilter">搜索</el-button>
        </div>

      </el-row>
    </div>
    </div>
    <el-table
        :height="'calc('+(tableHeight)+'px)'"
        v-loading="listLoading"
        :key="tableKey"
        :data="data_list"
        border
        fit
        highlight-current-row
        style="width: 100%;"
        @selection-change="handleSelectionChange"
        class="saltkey_table">
      <el-table-column type="selection" align="center" width="55">
      </el-table-column>
      <el-table-column label="MinionID"  align="center" width="180">
        <template #default="scope">
          <span>{{ scope.row.minion_id }}</span>
        </template>
      </el-table-column>
      <el-table-column label="KEY状态" width="100px" align="center">
        <template #default="scope">
          <div slot="reference" class="name-wrapper">
            <el-tag size="default" :class="'icon-'+certification_status">{{ scope.row.certification_status }}</el-tag>
          </div>
        </template>
      </el-table-column>
      <el-table-column label="最近一次更新时间" width="200px" align="center">
        <template #default="scope">
          <span>{{ scope.row.update_time }}</span>
        </template>
      </el-table-column>
      <el-table-column label="测试结果" width="150px" align="center" v-show="certification_status==='accepted'">
        <template #default="scope">
          <el-button size="small" v-show="scope.row.show" :type="testButtion[scope.row.minion_id]" :icon="testIcon[scope.row.minion_id]" circle></el-button>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" min-width="230" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button type="primary" size="small" v-show="certification_status==='accepted'" :loading="testLoading[scope.row.minion_id]" @click="handleTestKey(scope.row)">测试</el-button>
          <el-button type="success" size="small" v-show="certification_status==='unaccepted'" @click="handleAcceptKey(scope.row)">接受</el-button>
          <el-button type="warning" size="small" v-show="certification_status==='unaccepted'" @click="handleRejectKey(scope.row)">拒绝</el-button>
          <el-button type="danger" size="small" @click="handleDeleteKey(scope.row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <NewPagination v-bind:child-msg="listQuery" @pagination="getPagination"></NewPagination>
  </div>
</template>

<script setup>
import { getSaltKeyList, flushSaltKeyList, acceptSaltKey, deleteSaltKey, deleteDeniedSaltKey, rejectSaltKey, testSaltKey } from "@/api/api";
import { ElMessage, ElMessageBox } from 'element-plus'
import {computed, nextTick, onBeforeMount, onMounted, ref} from "vue";
import {Search} from "@element-plus/icons-vue";
import NewPagination from "@/components/pagination_new/NewPagination.vue";
import {getTableHeight} from "@/utils/util";

let isFull = ref(false)
let tableHeight = ref(500);
let tableSelect = ref(0)
let allLoading = ref(false);
let listLoading = ref(true);
let certification_status = ref("accepted");
let data_list = ref([]);
let tableKey = 0;
let total = ref(0);
let saltkey_count = ref({});
let multipleSelection = [];
let testIcon = ref({});
let testLoading = ref({});
let testButtion = ref({});
let search = ref("");

let listQuery = ref({
  certification_status: certification_status.value,
  page: 1,
  limit: 10,
  total: total.value
})

onMounted(() => {
  // certification_status = 'accepted';
  getList()
})
function getPagination(parm) {
  console.log(parm)
  listQuery.value.page = parm.page
  listQuery.value.limit = parm.limit
  getList()
}

// 获取saltkey列表
function getList() {
  listLoading.value = true
  console.log(listQuery.value, "listQuery")
  getSaltKeyList(listQuery.value).then(response => {
    data_list.value = response.data.data
    total.value = response.data.total
    listQuery.value.total = response.data.total
    saltkey_count.value = response.msg
    setTimeout(() => {
      listLoading.value = false
    }, 0.5 * 1000)
  }).catch(error => {
    console.log("获取saltkey列表" + error);
  })
}
// 大标题KEY状态选择
function handleGetList(status) {
  if(certification_status.value !== status){
    certification_status.value = status
    listQuery.value.certification_status = status
    getList()
  }
}
// 搜索框操作
function handleFilter() {
  listQuery.value.search = search.value
  listQuery.value.page = 1
  getList()
}
// 全局刷新列表
function handleFlushKey() {
  allLoading.value = true
  let data = {
    "salt_key_tag": "global_flush_salt_key"
  }
  flushSaltKeyList(data).then(response => {
    console.log(response.status)
    if(response.status){
      ElMessage.success(response.results)
      certification_status.value = "accepted"
      getList()
      allLoading.value = false
    }
    else{
      ElMessage.error(response.results)
      allLoading.value = false
    }
  }).catch(error => {
    console.log('全局刷新列表' + error);
  })
}
// 接受key基类方法
function acceptKey(minion_id){
  allLoading.value = true
  let data = {
    "salt_key_tag": "accept_salt_key",
    "minion_id": minion_id
  }
  acceptSaltKey(data).then(response => {
    if(response.status){
      ElMessage.success(response.results)
      allLoading.value = false
      getList()
    }
    else{
      ElMessage.error(response.results)
      allLoading.value = false
    }
  }).catch(error => {
    console.log('接受key基类方法' + error);
  })
}
// 接受所有key
function handleAcceptAllKey(){
  let minion_id = ["*"]
  acceptKey(minion_id)
}
// 接受单个key
function handleAcceptKey(row){
  let minion_id = [row.minion_id]
  acceptKey(minion_id)
}
// 当选项发生变化时触发该方法多选赋值,val是@selection-change内置的表示选中的对象
function handleSelectionChange(val) {
  multipleSelection = val;
}
// 批量接受key
function handleAcceptKeyList(){
  if(multipleSelection.length === 0){
    ElMessage.error('未选择任何记录，请选择后重试')
  }
  else{
    let minion_id = []
    for(let data of multipleSelection.values()){
      minion_id.push(data.minion_id)
    }
    acceptKey(minion_id)
  }
}
// 删除key基类方法
function deleteKey(minion_id){
  allLoading = true
  let data = {
    "salt_key_tag": "delete_salt_key",
    "minion_id": minion_id
  }
  deleteSaltKey(data).then(response => {
    if(response.status){
      ElMessage.success(response.results)
      allLoading.value = false
      getList()
    }
    else{
      ElMessage.error(response.results)
      allLoading.value = false
    }
  }).catch(error => {
    console.log('删除key基类方法' + error);
  })
}
// 删除denied key基类方法
function deleteDeniedKey(minion_id){
  allLoading.value = true
  let data = {
    "salt_key_tag": "delete_denied_salt_key",
    "minion_id": minion_id
  }
  deleteDeniedSaltKey(data).then(response => {
    if(response.status){
      ElMessage.success(response.results)
      allLoading.value = false
      getList()
    }
    else{
      ElMessage.error(response.results)
      allLoading.value = false
    }
  }).catch(error => {
    console.log('删除denied key基类方法' + error);
  })
}
// 删除所有key
function handleDeleteAllKey(){
  ElMessageBox.confirm('此操作将删除除未被允许KEYS以外所有KEYS, 是否继续?', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  }).then(() => {
    let minion_id = ["*"]
    deleteKey(minion_id)
  }).catch(() => {
    ElMessage.info({
      message: '已取消删除'
    });
  });
}
// 删除单个key
function handleDeleteKey(row){
  ElMessageBox.confirm(' 确认要删除?', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  }).then(() => {
    let minion_id = [row.minion_id]
    if(certification_status === 'denied'){
      deleteDeniedKey(minion_id)
    }
    else{
      deleteKey(minion_id)
    }
  }).catch(() => {
    ElMessage.info({
      message: '已取消删除'
    });
  });
}
// 批量删除key
function handleDeleteKeyList(){
  if(multipleSelection.length === 0){
    ElMessage.error('未选择任何记录，请选择后重试')
  }
  else{
    ElMessageBox.confirm('确认要删除?', '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    }).then(() => {
      let minion_id = []
      for(let data of multipleSelection.values()){
        minion_id.push(data.minion_id)
      }
      if(certification_status === 'denied'){
        deleteDeniedKey(minion_id)
      }
      else{
        deleteKey(minion_id)
      }
    }).catch(() => {
      ElMessage.info({
        message: '已取消删除'
      });
    });
  }
}
// 拒绝key基类方法
function rejectKey(minion_id){
  let data = {
    "salt_key_tag": "reject_salt_key",
    "minion_id": minion_id
  }
  rejectSaltKey(data).then(response => {
    if(response.status){
      ElMessage.success(response.results)
      getList()
    }
    else{
      ElMessage.error(response.results)
    }
  }).catch(error => {
    console.log('拒绝key基类方法' + error);
  })
}
// 批量拒绝
function handleRejectKeyList(){
  if(multipleSelection.length === 0){
    ElMessage.error('未选择任何记录，请选择后重试')
  }
  else{
    let minion_id = []
    for(let data of multipleSelection.values()){
      minion_id.push(data.minion_id)
    }
    rejectKey(minion_id)
  }
}
// 拒绝单个key
function handleRejectKey(row){
  let minion_id = [row.minion_id]
  rejectKey(minion_id)
}
// 测试test.ping
function handleTestKey(row){
  testIcon.value[row.minion_id] = 'Loading'
  testButtion.value[row.minion_id] = ''
  row.show = 1;
  testLoading.value[row.minion_id] = true
  testSaltKey(row.minion_id).then(response => {
    console.log(response)
    if(response.status){
      if(response.results[row.minion_id]){
        testIcon.value[row.minion_id] =  'Check'
        testButtion.value[row.minion_id] = 'success'
        ElMessage.success(`${row.minion_id}：${response.results[row.minion_id]}`)
        testLoading.value[row.minion_id] = false
      }
      else{
        testIcon.value[row.minion_id] = 'Close'
        testButtion.value[row.minion_id] = 'danger'
        ElMessage.error(`${row.minion_id}：${response.results[row.minion_id]}`)
        testLoading.value[row.minion_id] = false
      }
    }
    else{
      testIcon.value[row.minion_id] = 'Close'
      testButtion.value[row.minion_id] = 'danger'
      ElMessage.error(`${row.minion_id}：${response.results[row.minion_id]}`)
      testLoading.value[row.minion_id] = false
    }
  }).catch(error => {
    testLoading.value[row.minion_id] = false
    ElMessage.error(error)
    console.log('测试test.ping' + error);
  })
}
function getTheTableHeight() {
  let tabSelectHeight = tableSelect.value ? tableSelect.value.offsetHeight:0
  console.log(tabSelectHeight, "1")
  tabSelectHeight = isFull.value?tabSelectHeight-110:tabSelectHeight
  console.log(tabSelectHeight, "2")
  tableHeight.value = getTableHeight(tabSelectHeight)
  console.log(tableHeight.value, "3")
}
function listenResize() {
  nextTick(() => {
    getTheTableHeight()
  })
}
onMounted(() => {
  window.addEventListener('resize', listenResize)
  nextTick(() => {
    console.log("onMounted")
    getTheTableHeight()
  })
})
onBeforeMount(() => {
  window.removeEventListener("resize", listenResize);
})
</script>

<style rel="stylesheet/scss" lang="scss" scoped>
.app-container{
  .saltkey_tag1{
    color: #0063DC;
    background-color: azure;
    padding: 9px 20px;
  }

  .panel-group {
    margin-top: 18px;
    .card-panel-col{
      margin-bottom: 32px;
    }
    .card-panel {
      height: 108px;
      cursor: pointer;
      font-size: 12px;
      position: relative;
      overflow: hidden;
      background: #d2f1f1;
      box-shadow: 4px 4px 40px rgba(0, 0, 0, .05);
      border-color: rgba(0, 0, 0, .05);
      border-radius: 10px;
      &:hover {
        background: #d2e6e6;
      }
      .icon-accepted {
        color: #40c984;
      }
      .icon-unaccepted {
        color: #36a3f7;
      }
      .icon-denied {
        color: #f4ce51;
      }
      .icon-rejected {
        color: #f4516c;
      }
      .card-panel-icon-wrapper {
        float: left;
        margin: 14px 0 0 14px;
        padding: 16px;
        transition: all 0.38s ease-out;
        border-radius: 6px;
      }
      .card-panel-icon {
        float: left;
        font-size: 48px;
      }
      .card-panel-description {
        float: right;
        font-weight: bold;
        margin: 26px 26px 26px 0;
        .card-panel-text {
          line-height: 18px;
          // color: rgba(51, 155, 82, 0.45);
          font-size: 20px;
          margin-bottom: 12px;
        }
        .card-panel-num {
          font-size: 20px;
        }
      }
    }
    .cardselected{
      background: #b2eba7!important ;
    }
  }
  .saltkey_table{
    .icon-accepted {
      color: #40c984;
    }
    .icon-unaccepted {
      color: #36a3f7;
    }
    .icon-denied {
      color: #f4ce51;
    }
    .icon-rejected {
      color: #f4516c;
    }
  }
}


</style>