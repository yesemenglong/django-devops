<template>
  <div :class="{'ly-is-full':isFull}">
    <div ref="tableSelect" class="tableSelect">
      <el-button @click="addZone" type="primary" icon="Plus">新增单个</el-button>
      <el-button @click="addBatchZone" color="#626aef" :dark="true" icon="Plus">批量新增</el-button>
      <el-button @click="updateVer" color="#556B2F" :dark="true" icon="Plus">更新版本号</el-button>
      <div style="float: right;">
        <el-input placeholder="区服ID" v-model="listQuery.search" style="width: 100px;margin-left: 10px"   @keyup.enter.native="handleFilter"/>
        <el-select v-model="listQuery.minion_id" placeholder="MinionID" style="width: 100px;margin-left: 10px" clearable @change="handleFilter">
          <el-option v-for="item in minion_list" :key="item.key" :label="item.label" :value="item.key" />
        </el-select>
        <el-select v-model="listQuery.m_zone" placeholder="合服状态" style="width: 100px;margin-left: 10px" clearable @change="handleFilter">
          <el-option label="已被合" value="1"/>
          <el-option label="未被合" value="0"/>
        </el-select>
        <el-button type="primary" :icon="Search" @click="handleFilter" style="margin-left: 10px">搜索</el-button>
      </div>
    </div>

    <el-table :height="'calc('+(tableHeight)+'px)'" :data="data_list" style="width: 100%" border @sort-change="sortChange" class="tooltip-base-box" v-loading="listLoading">
      <el-table-column prop="zone_id" label="区服ID" width="180" sortable="custom" />
      <el-table-column prop="name" label="区服名称" width="180" />
      <el-table-column prop="ip" label="IP" width="180" />
<!--      <el-table-column prop="db" label="DB" width="180" />-->
      <el-table-column prop="id" label="ID" width="150" />
      <el-table-column prop="m_zone" label="m_zone" width="80" :formatter="formatter"/>
      <el-table-column prop="minion_id" label="MinionID" sortable="custom" width="180" />
      <el-table-column prop="create_date" label="创建时间" />

        <el-table-column prop="" label="操作">
          <template #header="scope">
            <el-tooltip effect="dark" content="已创建目录的区服无法编辑和删除" placement="top">
              <span>操作</span>
            </el-tooltip>
          </template>
          <template #default="scope">
<!--            <el-button v-if="scope.row.status===0" type="primary">创区</el-button>-->
            <el-button v-if="scope.row.status===0" type="primary" @click="updateZone(scope.row)">编辑</el-button>
            <el-button v-if="scope.row.status===0" type="danger" @click="deleteZone(scope.row)">删除</el-button>
          </template>
        </el-table-column>

    </el-table>

    <NewPagination v-bind:child-msg="listQuery" @pagination="getPagination"></NewPagination>

    <el-dialog :title="dialogTitle" v-model="dialogFormVisible" width="560px">
      <el-scrollbar style="height:100%">
        <el-form :model="formData" :rules="rules" label-position="right" label-width="130px" style="width: 400px; margin-left:50px;">
          <el-form-item label="区服ID：" prop="zone_id">
            <el-input v-model="formData.zone_id"></el-input>
          </el-form-item>
          <el-form-item label="区服名称：" prop="name">
            <el-input v-model="formData.name"></el-input>
          </el-form-item>
          <el-tooltip  effect="dark" placement="left"  content="选择Minion后出现的是已使用ID">
            <el-form-item label="ID：" prop="id">
              <el-tag size="small" type="danger" v-for="item in id_list">{{item.id}}</el-tag>
              <el-input v-model="formData.id"></el-input>
            </el-form-item>
          </el-tooltip>
          <el-form-item label="MinionID：" prop="minion_id">
            <el-select v-model="formData.minion_id" placeholder="MinionID" @change="getUseID">
              <el-option v-for="item in minion_list" :key="item.key" :label="item.label" :value="item.key"  />
            </el-select>
          </el-form-item>
        </el-form>
      </el-scrollbar>
      <div slot="footer" style="margin: 0 auto;width: 200px">
        <el-button @click="dialogFormVisible = false">关闭</el-button>
        <el-button type="primary" @click="submitData">确 定</el-button>
      </div>
    </el-dialog>

    <el-dialog title="批量增加区服" v-model="dialogFormBatchVisible" width="560px">
      <el-scrollbar style="height:100%">
        <el-form :model="BatchFormData" :rules="rules_batch" label-position="right" label-width="130px" style="width: 400px; margin-left:50px;">
          <el-form-item label="起始区服ID：" prop="start_id">
            <el-input v-model.number="BatchFormData.start_id"></el-input>
          </el-form-item>
          <el-tooltip  effect="dark" placement="left"  content="区服的端口数量">
            <el-form-item label="端口数：" prop="login_num">
              <el-input v-model.number="BatchFormData.login_num"></el-input>
            </el-form-item>
          </el-tooltip>
          <el-form-item label="增加区服数：" prop="add_num">
            <el-input v-model.number="BatchFormData.add_num"></el-input>
          </el-form-item>
        </el-form>
      </el-scrollbar>
      <div slot="footer" style="margin: 0 auto;width: 200px">
        <el-button @click="dialogFormBatchVisible = false">关闭</el-button>
        <el-button type="primary" @click="submitBatchData">确 定</el-button>
      </div>
    </el-dialog>

    <el-dialog title="更新版本号" v-model="dialogFormVersionVisible" width="560px">
      <el-scrollbar style="height:100%">
        <el-form :model="VersionFormData" :rules="rules_batch" label-position="right" label-width="130px" style="width: 400px; margin-left:50px;">
          <el-form-item label="版本号：" prop="version">
            <el-input v-model="VersionFormData.version"></el-input>
          </el-form-item>
        </el-form>
      </el-scrollbar>
      <div slot="footer" style="margin: 0 auto;width: 200px">
        <el-button @click="dialogFormVersionVisible = false">关闭</el-button>
        <el-button type="primary" @click="submitVerData">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script setup>
import {nextTick, onBeforeMount, onMounted, ref} from "vue";
import {getMinionIdList, getZoneList, createZoneInfo, batchCrateZones, minionIDList, updateZoneInfo, getZone, deleteZoneInfo, getVersion, updateVersion} from "@/api/api";
import {ElMessage} from "element-plus";
import {Search} from "@element-plus/icons-vue";
import NewPagination from "@/components/pagination_new/NewPagination.vue";
import {getTableHeight} from "@/utils/util";

let tableHeight = ref(500);
let tableSelect = ref(null);
let isFull = ref(false);
let data_list = ref([]);
let listLoading = ref(false);
let total = ref(0);
let dialogFormVisible = ref(false);
let dialogFormBatchVisible = ref(false);
let dialogFormVersionVisible = ref(false);
let dialogTitle = ref("");
let action = ref("")
let formData = ref({
  zone_id: 0,
  name: "",
  // ip: "",
  // db: "",
  id: "",
  minion_id: "",
});
let BatchFormData = ref({
  start_id: 0,
  login_num: 0,
  add_num: 0,
})
let VersionFormData = ref({
  version: ""
});
let minion_list = ref([]);
let rules = {
  zone_id: {required: true, message: '请输入ZoneID', trigger: 'blur'},
  name: {required: true, message: '请输入区服名称', trigger: 'blur'},
  minion_id: {required: true, message: '请选择minion_id', trigger: 'blur'},
  id: {required: true, message: '请输入id', trigger: 'blur'}
};
let rules_batch = {
  start_id: {required: true, message: '请输入起始区服ID', trigger: 'blur'},
  login_num: {required: true, message: '请输入端口数', trigger: 'blur'},
  add_num: {required: true, message: '请选择增加区服数', trigger: 'blur'},
}
let ruleForm = ref();
let listQuery = ref({
  page: 1,
  limit: 10,
  total: total.value,
  minion_id:'',
  ordering: ''
});
let id_list = ref()
function getPagination(parm) {
  listQuery.value.page = parm.page
  listQuery.value.limit = parm.limit
  getData()
}
const formatter = (row, column, cellValue) => {
  if (cellValue) { //不包含值为 0 的情况 另做判断
    return cellValue
  } else if (cellValue === 0) { //cellValue会自动将0值过滤出来不展示 单独做判断
    return ''
  }
}
function getData() {
  listLoading.value = true
  getZoneList(listQuery.value).then(response => {
    data_list.value = response.data.data
    total.value = response.data.total
    listQuery.value.total = response.data.total
    setTimeout(() => {
      listLoading.value = false
    }, 0.5 * 1000)
  }).catch(error => {
    console.log('获取Zones列表' + error);
  })
}
// 获取minion_id 列表
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
function getUseID(minion_id) {
  let data = {
    "minion_id": minion_id
  }
  minionIDList(data).then(response => {
    id_list.value = response
  })
}
// 搜索框操作
function handleFilter() {
  listQuery.value.page = 1
  getData()
}
// 排序
function sortChange(data) {
  const { prop, order } = data
  if (prop === 'minion_id') {
    if (order === 'ascending') {
      listQuery.value.ordering = 'minion_id'
    } else {
      listQuery.value.ordering = '-minion_id'
    }
  }
  else if(prop === 'zone_id'){
    if (order === 'ascending') {
      listQuery.value.ordering = 'zone_id'
    } else {
      listQuery.value.ordering = '-zone_id'
    }
  }
  handleFilter()
}
// 清空弹出框
function resetTemp() {
  minion_list.value = [];
  formData.value = {
    zone_id: null,
    name: "",
    // ip: "",
    // db: "",
    id: "",
    minion_id: ""
  };
  BatchFormData.value = {};
  id_list.value = {}
}
function updateVer(){
  dialogFormVersionVisible.value = true;
  getVersion(1).then(response => {
    VersionFormData.value = response
  }).catch(error => {
    console.log('获取Version' + error);
  })
}
// 新增单个信息
function addZone() {
  resetTemp();
  // console.log(minion_list.value)
  dialogTitle.value = "新增区服"
  action.value = "create"
  dialogFormVisible.value = true;
  getIdList()
}
// 修改区服信息
function updateZone(row) {
  resetTemp();
  dialogTitle.value = "修改区服"
  dialogFormVisible.value = true;
  getZone(row.zone_id).then(response => {
    formData.value = response
  }).catch(error => {
    console.log('获取Zone' + error);
  })
  action.value = "update"

  setTimeout(() => {
    getIdList()
    getUseID(formData.value.minion_id)
  }, 0.5*1000)
}
// 删除区服
function deleteZone(row){
  deleteZoneInfo(row.zone_id).then(response => {
    if(response.status){
      ElMessage.success(response.results)
      getData()
    } else {
      ElMessage.error(response.results)
    }
  }).catch(error => {
    console.log('删除Zone' + error);
  })
}
function addBatchZone() {
  resetTemp();
  dialogFormBatchVisible.value = true;
}
function submitData() {
  dialogFormVisible.value = false
  if (action.value === "create") {
    createZoneInfo(formData.value).then(response => {
      if(response.status){
        ElMessage.success(response.results)
        getData()
      } else {
        ElMessage.error(response.results)
      }
    }).catch(error => {
      console.log("创建区服失败" + error)
    })
  } else {
    updateZoneInfo(formData.value).then(response => {
      if(response.status) {
        ElMessage.success(response.results)
        getData()
      } else {
        ElMessage.error(response.results)
      }
    }).catch(error => {
      console.log("修改区服失败" + error)
    })
  }
}
function submitBatchData() {
  dialogFormBatchVisible.value = false;
  console.log(BatchFormData.value)
  batchCrateZones(BatchFormData.value).then(response => {
    if(response.status){
      ElMessage.success(response.results)
      getData()
    } else {
      ElMessage.error(response.results)
    }
  }).catch(error => {
    console.log("批量创建失败" + error)
  })
}
function submitVerData() {
  dialogFormVersionVisible.value = false;
  console.log(VersionFormData.value)
  updateVersion(VersionFormData.value).then(response => {
    console.log(response)
    if(response.status){
      ElMessage.success(response.results)
    } else {
      ElMessage.error(response.results)
    }
  }).catch(error => {
    console.log("更新失败" + error)
  })
}
onMounted(() => {
  getData()
  getIdList()
})
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

<style scoped>
.tooltip-base-box {
  width: 600px;
}
.tooltip-base-box .row {
  display: flex;
  align-items: center;
  justify-content: space-between;
}
.tooltip-base-box .center {
  justify-content: center;
}
.tooltip-base-box .box-item {
  width: 110px;
  margin-top: 10px;
}
</style>