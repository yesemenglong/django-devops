<template>
  <div v-loading="allLoading" :class="{'ly-is-full':isFull}">
    <div ref="tableSelect" class="tableSelect">

      <el-row>
        <el-button  type="primary" size="large" @click="handleUpdateSaltCmdListDailog">命令采集</el-button>
        <el-button  type="danger" size="large" @click="handleDeleteSaltCmdList">清空命令</el-button>
        <div style="margin-left: auto">
          <el-input size="large" placeholder="命令" v-model="listQuery.search" style="width: 150px"  @keyup.enter.native="handleFilter"/>
          <el-select size="large" v-model="listQuery.salt_cmd_type" clearable style="width: 140px;margin-left: 10px"  placeholder="命令类型" @change="handleFilter">
            <el-option label="module" value="module"/>
            <el-option label="state" value="state"/>
            <el-option label="runner" value="runner"/>
          </el-select>
          <el-button type="primary" size="large" :icon="Search" @click="handleFilter" style="margin-left: 10px">搜索</el-button>
        </div>
      </el-row>
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
        @sort-change="sortChange"
        @selection-change="handleSelectionChange">
      <el-table-column type="selection" align="center" width="55">
      </el-table-column>
      <el-table-column label="命令类型" prop="salt_cmd_type" sortable="custom"  align="center" width="150">
        <template #default="scope">
          <span>{{ scope.row.salt_cmd_type }}</span>
        </template>
      </el-table-column>
      <el-table-column label="模块" align="center" width="150">
        <template #default="scope">
          <span>{{ scope.row.salt_cmd_module }}</span>
        </template>
      </el-table-column>
      <el-table-column label="命令" prop="salt_cmd" sortable="custom"  align="center" width="200">
        <template #default="scope">
          <span class="link-type" @click="handleSaltCmdInfo(scope.row)">{{ scope.row.salt_cmd }}</span>
        </template>
      </el-table-column>
      <el-table-column label="来源"  align="center" width="180">
        <template #default="scope">
          <span>{{ scope.row.salt_cmd_source }}</span>
        </template>
      </el-table-column>
      <el-table-column label="最近一次采集时间" width="200px" align="center">
        <template #default="scope">
          <span>{{ scope.row.update_time  }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" min-width="230" class-name="small-padding fixed-width">
        <template #default="scope">
          <el-button type="primary" @click="handleSaltCmdInfo(scope.row)">详情</el-button>
        </template>
      </el-table-column>
    </el-table>

    <NewPagination v-bind:child-msg="listQuery" @pagination="getPagination"></NewPagination>

    <el-dialog title="采集选项" v-model="dialogFormVisible" >
      <el-scrollbar style="height:100%">
        <el-form  v-model="collection_style" label-position="right" label-width="130px" style="width: 800px; margin-left:50px;">
          <el-form-item label="命令类型:" class="is-required">
            <el-radio-group v-model="collection_style">
              <el-radio label="module" border>module</el-radio>
              <el-radio label="state" border>state</el-radio>
              <el-radio label="runner" border>runner</el-radio>
            </el-radio-group>
          </el-form-item>
          <el-form-item label="Minion id:" :error="minion_transfer_error" class="is-required">
            <el-transfer
                v-model="minion_lists"
                :data="minion_list"
                :titles="['Minion ID选择', '已选Minion ID']"
                filterable
                filter-placeholder="搜索Minion ID"
                target-order='push'
            ></el-transfer>
          </el-form-item>
        </el-form>
      </el-scrollbar>
      <div slot="footer" style="margin: 0 auto;width: 200px">
        <el-button @click="dialogFormVisible = false">关闭</el-button>
        <el-button type="primary" @click="handleupdateSaltCmdList">确 定</el-button>
      </div>
    </el-dialog>

    <el-dialog v-model="dialogInfoVisible" :title="infoTemp.salt_cmd" width="40%">
      <el-input type="textarea" :autosize="{ minRows: 8, maxRows: 25}" readonly v-model="infoTemp.salt_cmd_doc"></el-input>
<!--      <span slot="footer" class="dialog-footer">-->
<!--        <el-button style="margin-left: auto" type="primary" @click="dialogInfoVisible = false">确定</el-button>-->
<!--      </span>-->
    </el-dialog>


  </div>
</template>

<script setup>
import {onMounted, ref, nextTick, reactive, onBeforeMount} from "vue";
import {Search} from "@element-plus/icons-vue";
import NewPagination from "@/components/pagination_new/NewPagination.vue";
import { ElMessage, ElMessageBox } from 'element-plus'
import { getSaltCmdList, deleteSaltCmd, updateSaltCmdList, getMinionIdList } from "@/api/api";
import {getTableHeight} from "@/utils/util";

let isFull = ref(false);
let tableHeight = ref(500);
let tableSelect = ref(0)
let allLoading = ref(false);
let listLoading = ref(true);
let data_list = ref([]);
let total = ref(0);
let tableKey = ref(0);
let listQuery = ref({
  page: 1,
  limit: 10,
  total: total.value,
  salt_cmd_type:'',
  ordering: '',
});
let multipleSelection = ref([]);
let dialogFormVisible = ref(false);
let dialogInfoVisible = ref(false);
let minion_list = ref([]);

let minion_lists = ref([]);
// let temp = ref({
//   collection_style: 'module'
// });

let collection_style = ref("module")

let infoTemp = {};
let minion_transfer_error = ref("");

function getPagination(parm) {
  console.log(parm)
  listQuery.value.page = parm.page
  listQuery.value.limit = parm.limit
  getList()
}

onMounted(() => {
  getList()
})

// 获取salt命令集列表
function getList() {
  listLoading.value = true
  console.log(listQuery.value, "listQuery")
  getSaltCmdList(listQuery.value).then(response => {
    console.log(response)
    data_list.value = response.data.data
    total.value = response.data.total
    listQuery.value.total = response.data.total
    // Just to simulate the time of the request
    setTimeout(() => {
      listLoading.value = false
    }, 0.5 * 1000)
  }).catch(error => {
    console.log('获取salt命令集列表' + error);
  })
}
// 获取salt命令集列表无loading
function getListNoLoading() {
  getSaltCmdList(listQuery.value).then(response => {
    data_list.value = response.data.data
    total.value = response.count
  }).catch(error => {
    console.log('获取salt命令集列表无loading' + error);
  })
}
// 获取minion id字段列表
function getIdList(){
  getMinionIdList().then(response =>{
    const minionList = response.results;
    minionList.forEach((minion_id, index) => {
      minion_list.value.push({
        label: minion_id,
        key: minion_id
      });
    });
  }).catch(error => {
    console.log('获取minion id字段列表' + error);
  })
}
// 搜索框操作
function handleFilter() {
  listQuery.value.page = 1
  getList()
}
// 清空命令采集弹出框临时数据
function resetTemp() {
  minion_list.value = [];
  minion_lists.value = []
  collection_style.value = "module"
  // temp = {
  //   collection_style: 'module',
  // }
}
// 命令采集弹出框
function handleUpdateSaltCmdListDailog(){
  resetTemp()
  getIdList()
  minion_transfer_error.value = '';
  dialogFormVisible.value = true
  console.log(minion_list.value, "handleUpdateSaltCmdListDailog")
  console.log(minion_lists, "temp")
  // nextTick(()=>{
    // $refs.dataTransfer.clearQuery("left")
    // $refs.dataTransfer.clearQuery("right")
    // dataTransfer.clearQuery("left")
  // }
}
// 命令采集
function handleupdateSaltCmdList(){
  // console.log(minion_lists.value, "")
  // console.log(temp, "minion_lists")
  if (minion_lists.value.length) {
    minion_transfer_error.value = '';
    dialogFormVisible.value = false
    allLoading.value = true
    // console.log(temp)
    let data = {
      collection_style: collection_style.value,
      minion_lists: minion_lists.value
    }
    console.log(data)
    data.minions = []

    minion_lists.value.forEach((minion) => {
      data.minions.push(minion)
    });
    updateSaltCmdList(data).then(response => {
      if(response.status){
        ElMessage.success(response.results)
        getListNoLoading()
        allLoading.value = false
      }
      else{
        ElMessage.error(response.results)
        allLoading.value = false
      }
    }).catch(error => {
      console.log('命令采集' + error);
    })
  }
  else {
    minion_transfer_error.value = '请至少选择一个Minion ID';
    return false;
  }
}
// 清空命令
function handleDeleteSaltCmdList(){
  ElMessageBox.confirm('确认要情况?', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  }).then(() => {
    allLoading.value = true
    deleteSaltCmd().then(response => {
      if(response.data.status){
        ElMessage.success(response.data.results)
        getListNoLoading()
        allLoading.value = false
      }
      else{
        ElMessage.error(response.data.results)
        allLoading.value = false
      }
    }).catch(error => {
      console.log('清空命令' + error);
    })
  }).catch(() => {
    ElMessage.info({
      message: '已取消删除'
    });
  });
}
// 当选项发生变化时触发该方法多选赋值,val是@selection-change内置的表示选中的对象
function handleSelectionChange(val) {
  multipleSelection.value = val;
}
// 排序
function sortChange(data) {
  const { prop, order } = data
  if (prop === 'salt_cmd_type') {
    if (order === 'ascending') {
      listQuery.value.ordering = 'salt_cmd_type'
    } else {
      listQuery.value.ordering = '-salt_cmd_type'
    }
  }
  else if(prop === 'salt_cmd'){
    if (order === 'ascending') {
      listQuery.value.ordering = 'salt_cmd'
    } else {
      listQuery.value.ordering = '-salt_cmd'
    }
  }
  handleFilter()
}
function handleSaltCmdInfo(row) {
  infoTemp = {}
  infoTemp = Object.assign({}, row) // copy obj
  dialogInfoVisible.value = true
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
</style>