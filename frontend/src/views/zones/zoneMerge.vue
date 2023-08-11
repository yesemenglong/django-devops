<template>
  <div :class="{'ly-is-full':isFull}">
    <div ref="tableSelect" class="tableSelect">
      <el-button @click="addInfo" color="#626aef" :dark="true" icon="Plus">新增</el-button>
      <el-button @click="addBatchInfo" color="#626aef" :dark="true" icon="Plus">批量新增</el-button>
      <el-select v-model="listQuery.status" clearable style="width: 140px;margin-left: 10px" placeholder="状态" @change="handleFilter">
        <el-option label="已执行" value="1"/>
        <el-option label="未执行" value="0"/>
      </el-select>
    </div>
    <el-row :gutter="20">
      <el-col :span="12">
        <el-table :height="'calc('+(tableHeight)+'px)'" :data="data_list" style="width: 100%" border class="tooltip-base-box" v-loading="listLoading">
          <el-table-column prop="id" label="ID" width="80" />
          <el-table-column prop="mzone" label="主区" width="100" />
          <el-table-column prop="cozone" label="副区" width="180" />
          <el-table-column prop="create_date" label="创建时间" />

          <el-table-column prop="" label="操作">
            <template #header="scope">
              <el-tooltip effect="dark" content="已执行的无法编辑和删除" placement="top">
                <span>操作</span>
              </el-tooltip>
            </template>
            <template #default="scope">
              <el-button v-if="scope.row.status===0" type="success" @click="handExe(scope.row)">合并</el-button>
              <el-button v-if="scope.row.status===0" type="primary" @click="updateInfo(scope.row)">编辑</el-button>
              <el-button v-if="scope.row.status===0" type="danger" @click="deleteInfo(scope.row)">删除</el-button>
            </template>
          </el-table-column>
        </el-table>
        <NewPagination v-bind:child-msg="listQuery" @pagination="getPagination"></NewPagination>
      </el-col>
      <el-col :span="12">
        <el-form class="salt-result" ref="dataForm"  label-position="top" label-width="130px">
          <el-form-item label="执行结果:">
                <pre class="saltexe_pre"  ref="salt_exe_result" v-html="salt_exe_result_data"
                     v-loading="resultLoading"
                     :element-loading-text="loadingText"></pre>
          </el-form-item>
        </el-form>
      </el-col>
    </el-row>

    <el-dialog :title="dialogTitle" v-model="dialogFormVisible" width="560px">
      <el-scrollbar style="height:100%">
        <el-form :model="formData" :rules="rules" label-position="right" label-width="130px" style="width: 400px; margin-left:50px;">
          <el-form-item label="主区：" prop="mzone">
            <el-input v-model.number="formData.mzone"></el-input>
          </el-form-item>
          <el-form-item label="副区：" prop="cozone">
            <el-input v-model="formData.cozone"></el-input>
          </el-form-item>
        </el-form>
      </el-scrollbar>
      <div slot="footer" style="margin: 0 auto;width: 200px">
        <el-button @click="dialogFormVisible = false">关闭</el-button>
        <el-button type="primary" @click="submitData">确 定</el-button>
      </div>
    </el-dialog>
    <el-dialog title="批量新增" v-model="dialogFormVisible2" width="600px">
      <el-collapse>
        <el-collapse-item name="1">
          <template #title>
            注意事项<el-icon class="header-icon">
            <info-filled />
          </el-icon>
          </template>
          <h4>格式如下：</h4>
          <p style="color: red">1 2,3</p>
          <p style="color: red">4 5,6</p>
        </el-collapse-item>
      </el-collapse>
      <el-scrollbar style="height:100%">
        <el-input
            v-model="textarea.info"
            :autosize="{ minRows: 1}"
            type="textarea"
            placeholder="Please input"
        />
      </el-scrollbar>
      <div slot="footer" style="margin: 0 auto;width: 200px">
        <el-button @click="dialogFormVisible2 = false">关闭</el-button>
        <el-button type="primary" @click="submitBatchData">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script setup>
import {nextTick, onBeforeMount, onMounted, ref} from "vue";
import {addMergeInfo, getMergeList, getMergeInfo, updateMergeInfo, deleteMergeInfo, exeMerge, addBatchMergeInfo} from '@/api/api'
import {ElMessage} from "element-plus";
import NewPagination from "@/components/pagination_new/NewPagination.vue";
import {getTableHeight} from "@/utils/util";

let tableHeight = ref(500);
let tableSelect = ref(null);
let isFull = ref(false);
let data_list = ref([]);
let dialogFormVisible = ref(false);
let listLoading = ref(false);
let dialogTitle = ref("");
let formData = ref({
  mzone: null,
  cozone: []
})
let action = ref("")
let rules = {
  mzone: [{required: true, message: '请输入主区', trigger: 'blur'}, {type: 'number', message: '请输入整数'}],
  cozone: {required: true, message: '请输入副区', trigger: 'blur'}
};
let total = ref(0);
let listQuery = ref({
  page: 1,
  limit: 10,
  total: total.value,
  ordering: '',
  status: ''
});
let resultLoading = ref(false);
let loadingText = ref('命令执行中');
let salt_exe_result_data = ref('');
let textarea = ref({
  info: []
})
let dialogFormVisible2 = ref(false)

function getData() {
  listLoading.value = true
  console.log(listQuery.value)
  getMergeList(listQuery.value).then(response => {
    data_list.value = response.data.data
    total.value = parseInt(response.data.total)
    listQuery.value.total = response.data.total
    setTimeout(() => {
      listLoading.value = false
    }, 0.5 * 1000)
  }).catch(error => {
    console.log('获取列表失败' + error);
  })
}
function handleFilter() {
  listQuery.value.page = 1
  getData()
}
function getPagination(parm) {
  listQuery.value.page = parm.page
  listQuery.value.limit = parm.limit
  getData()
}
function resetQuery() {
  data_list.value = []
  // listQuery.value = {}
}
function deleteInfo(row){
  deleteMergeInfo(row.id).then(response => {
    if(response.status){
      ElMessage.success(response.results)
      getData()
    } else {
      ElMessage.error(response.results)
    }
  }).catch(error => {
    console.log('删除失败' + error);
  })
}
function resetTemp() {
  formData.value = {
    mzone: null,
    cozone: []
  }
}
function addBatchInfo() {
  dialogFormVisible2.value = true;
}
function addInfo() {
  resetTemp()
  dialogTitle.value = "新增"
  dialogFormVisible.value = true;
  action.value = "create";
}
function updateInfo(row){
  resetTemp();
  dialogTitle.value = "修改";
  dialogFormVisible.value = true;
  getMergeInfo(row.id).then(response => {
    formData.value = response
  }).catch(error => {
    console.log('获取MergeInfo' + error);
  });
  action.value = "update";
}
function submitData() {
  dialogFormVisible.value = false;
  if (action.value === "create") {
    addMergeInfo(formData.value).then(response => {
      if (response.status) {
        ElMessage.success(response.results)
      } else {
        ElMessage.error(response.results)
      }
      getData()
    }).catch(error => {
      console.log("创建合服信息失败" + error)
    })
  } else {
    updateMergeInfo(formData.value).then(response => {
      if(response.status) {
        ElMessage.success(response.results)
      } else {
        ElMessage.error(response.results)
      }
      getData()
    }).catch(error => {
      console.log("更改合服信息失败" + error)
    })
  }
}
function submitBatchData() {
  dialogFormVisible2.value = false;
  addBatchMergeInfo(textarea.value).then(response => {
    if (response.status) {
      ElMessage.success(response.results)
    } else {
      ElMessage.error(response.results)
    }
    getData()
  }).catch(error => {
    console.log("创建合服信息失败" + error)
  })
}
let color = ref("#47c032");

function handExe(row) {
  console.log(row)
  resultLoading.value = true;
  salt_exe_result_data.value = ''
  exeMerge(row).then(response => {
    console.log(response.status)
    if (response.status === true) {
      let data_count = 0;
      // for (let k in response.results['backupdb']){
      //   let v = response.results['backupdb'][k]
      //   result_format(k, v, data_count)
      // }
      // data_count = 0;
      console.log(response.results['merge'])
      for (let k in response.results['merge']){
        let v = response.results['merge'][k]
        result_format(k, v, data_count)
      }
    } else if (response.status === 'failure') {
      let data_count = 0;
      for (let k in response.results['merge']){
        let v = response.results['merge'][k]
        result_format(k, v, data_count, response.status)
      }
    }
    else {
      salt_exe_result_data.value = ''
      salt_exe_result_data.value = salt_exe_result_data.value + "<p style='color: #bf0000;'>"+response.results+"</p>"
    }
    resultLoading.value = false
    resetQuery()
    getData()
  }).catch(error => {
    console.log('执行salt.sls ' + error);
  })
}
function result_format(k, v, data_count, status) {
  color.value = '#47c032'
  if (status === "failure") {
    color.value = '#bf0000'
  }
  if(Object.prototype.toString.call(v) === '[object Object]'){
    salt_exe_result_data.value  = salt_exe_result_data.value +"<p style='color: #45ddd4;font-weight: bold;'>"+k+":</p>";
    result_fun(v,data_count+1);
  }
  else if(Object.prototype.toString.call(v) === '[object Array]'){
    salt_exe_result_data.value  = salt_exe_result_data.value +"<p style='color: #45ddd4;font-weight: bold;'>"+k+":</p>";
    result_fun(v,data_count+1);
    salt_exe_result_data.value  = salt_exe_result_data.value +'\n\n';
  }else{
    salt_exe_result_data.value  = salt_exe_result_data.value +"<p style='color: #3FB8AF;font-weight: bold;'>"+k+":</p>";
    salt_exe_result_data.value  = salt_exe_result_data.value +"<p style='padding-left: 25px;'>"+v+"</p>";
    salt_exe_result_data.value  = salt_exe_result_data.value +'\n\n';
  }
}
// 结果格式化方法
function result_fun(data,data_count) {
  if(!data) return;
  for (let k in data){
    let v = data[k];
    if(Object.prototype.toString.call(v) === '[object Object]'){
      salt_exe_result_data.value  = salt_exe_result_data.value + "<p style='color: #3FB8AF;padding-left: "+data_count*25+"px;'>"+k+":</p>";
      result_fun(v,data_count+1)
    }else if(Object.prototype.toString.call(v) === '[object Array]'){
      salt_exe_result_data.value  = salt_exe_result_data.value +"<p style='color: #3FB8AF;padding-left: "+data_count*25+"px;'>"+k+":</p>";
      result_fun(v,data_count+1)
    }else{
      salt_exe_result_data.value  = salt_exe_result_data.value +"<p style='color: #3FB8AF;padding-left: "+data_count*25+"px;'>"+k+":</p>";
      salt_exe_result_data.value  = salt_exe_result_data.value +"<p style='padding-left: "+(data_count+1)*25+"px;'>"+v+"</p>";
    }
  }
}
onMounted(() => {
  getData()
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

<style rel="stylesheet/scss" lang="scss" scoped>
.salt-result{
  .saltexe_pre{
    flex: auto;
    font-size: 14px;
    resize: none;
    line-height: 100%;
    height: calc(100vh - 230px);
    margin: 0;
    background-color: #000;
    //color: #47c032;
    color: v-bind(color);
    overflow-y: auto;
    white-space: pre-wrap;
    border: 1px solid #ccc;
    border-radius: 4px;
    padding: 6px 12px;
    font-family: Menlo,Monaco,Consolas,"Courier New",monospace;
  }
}
</style>