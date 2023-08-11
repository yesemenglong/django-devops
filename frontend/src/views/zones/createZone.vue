<template>
  <div :class="{'ly-is-full':isFull}">
    <el-row :gutter="20">
      <el-col :span="12">
        <el-table :data="data_list" style="width: 100%" border class="tooltip-base-box" v-loading="listLoading">
          <el-table-column prop="zone_id" label="区服ID" width="100" />
          <el-table-column prop="name" label="区服名称" width="150" />
          <el-table-column prop="ip" label="IP" width="160" />
          <el-table-column prop="id" label="ID" width="80" />
          <el-table-column prop="minion_id" label="MinionID" width="120" />
          <el-table-column prop="" label="操作">
            <template #header="scope">
              <el-tooltip effect="dark" content="需按顺序创建，否则pillar排序会有问题" placement="top">
                <span>操作 <el-icon :size="15"><WarningFilled /></el-icon></span>
              </el-tooltip>
            </template>
            <template #default="scope">
              <el-button v-if="scope.row.status===0" type="primary" @click="handExe(scope.row)">创区</el-button>
            </template>
          </el-table-column>

        </el-table>
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
  </div>
</template>

<script setup>
import {WarningFilled} from "@element-plus/icons-vue";
import {nextTick, onBeforeMount, onMounted, ref} from "vue";
import {getZoneStatusList, deployZone} from "@/api/api";


let listLoading = ref(false);
let isFull = ref(false);
let data_list = ref([]);
let total = ref(0);
let listQuery = ref({
  page: 1,
  limit: 10,
  total: total.value,
  minion_id:'',
  ordering: '',
});
let resultLoading = ref(false);
let loadingText = ref('命令执行中');
let salt_exe_result_data = ref('');

function getData() {
  listLoading.value = true
  getZoneStatusList(listQuery.value).then(response => {
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
function resetQuery() {
  data_list.value = []
  listQuery.value = {}
}
function handExe(row) {
  resultLoading.value = true;
  salt_exe_result_data.value = ''
  deployZone(row).then(response => {
    if (response.status) {
      let data_count = 0;
      for (let k in response.results['create']){
        let v = response.results['create'][k]
        result_format(k, v, data_count)
      }
      data_count = 0;
      for (let k in response.results['install']){
        let v = response.results['install'][k]
        result_format(k, v, data_count)
      }
      data_count = 0;
      for (let k in response.results['backupdb']){
        let v = response.results['backupdb'][k]
        result_format(k, v, data_count)
      }
    } else {
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
function result_format(k, v, data_count) {
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
    color: #47c032;
    overflow-y: auto;
    white-space: pre-wrap;
    border: 1px solid #ccc;
    border-radius: 4px;
    padding: 6px 12px;
    font-family: Menlo,Monaco,Consolas,"Courier New",monospace;
  }

}
</style>