<template>
  <div class="app-container">
    <el-row :gutter="20">
      <el-col :span="12" class="overflow_set">
        <hr>
        <el-form :model="exeData"  :rules="rules"  ref="ruleForm" label-width="150px" label-position="right" >
          <el-form-item v-show="exeData.client!=='runner'" label="执行对象类型：" prop="tgt_type" class="is-required">
            <el-row>
              <el-radio-group v-model="exeData.tgt_type">
                <el-col :span="6">
                  <el-radio  label="any">所有</el-radio>
                </el-col>
                <el-col :span="6">
                  <el-radio  label="minion_list">Minion_ID</el-radio>
                </el-col>
                <el-col :span="6">
                  <el-radio  label="pcre">Minion正则</el-radio>
                </el-col>
                <el-col :span="6">
                  <el-radio  label="custom_group">自定义组</el-radio>
                </el-col>
                <el-col :span="6">
                  <el-radio  label="grain">Grain</el-radio>
                </el-col>
                <el-col :span="6">
                  <el-radio  label="grain_pcre">Grain正则</el-radio>
                </el-col>
                <el-col :span="6">
                  <el-radio  label="ip_address">IP</el-radio>
                </el-col>
              </el-radio-group>

            </el-row>
          </el-form-item>
          <el-form-item label="执行对象：" prop="minion_list" v-show="exeData.tgt_type==='minion_list'&&exeData.client!=='runner'" :error="minion_transfer_error" class="is-required">
            <el-transfer
                ref="dataTransfer"
                filterable
                filter-placeholder="搜索Minion ID"
                :titles="['Minion ID选择', '已选Minion ID']"
                v-model="exeData.minion_list"
                :data="minion_list"
                target-order='push'>
                <template #default="{ option }">
                  <el-tooltip class="item" effect="light" :content="option.label" placement="right">
                    <span>{{ option.label }}</span>
                  </el-tooltip>
                </template>
            </el-transfer>
          </el-form-item>
          <!-- 执行对象输入框 -->
          <el-form-item label='执行对象：' v-show="tgt_type_label[exeData.tgt_type]&&exeData.client!=='runner'" prop="tgt" class="is-required">
            <el-input
                :placeholder="tgt_type_placeholder[exeData.tgt_type]"
                v-model="exeData.tgt"
                clearable style="width:350px">
            </el-input>
          </el-form-item>

          <el-form-item label="Client：">
            <el-select v-model="exeData.client" placeholder="命令" @change="handFilterModule">
              <el-option label="local" value="local"></el-option>
              <el-option label="local_async" value="local_async"></el-option>
              <el-option label="runner" value="runner"></el-option>
            </el-select>
            <span style="font-weight: normal;color: #3FB8AF;font-size: 13px;text-align: left;padding: 7px 7px">{{salt_cmd_help[exeData.client]}}</span>
          </el-form-item>
          <el-form-item label="Module：">
            <el-select v-model="select_module" clearable filterable placeholder="请选择模块">
              <el-option
                  v-for="item in module_list"
                  :key="item.salt_cmd_module"
                  :label="item.salt_cmd_module"
                  :value="item.salt_cmd_module">
              </el-option>
            </el-select>
            <span style="font-weight: normal;color: #3FB8AF;font-size: 13px;text-align: left;padding: 7px 7px">提示：如已知晓要执行的命令可省略</span>
          </el-form-item>
          <el-form-item label="Fun：" prop="fun">
            <el-autocomplete
                ref="salt_fun"
                v-model="exeData.fun"
                :fetch-suggestions="funSearch"
                :debounce=0
                placeholder="输入要执行的命令"
            ></el-autocomplete>
            <el-button style="margin-left: 10px" type="primary" size="default" @click="getCmdInfo">命令帮助</el-button>
          </el-form-item>
          <el-form-item label="Arg：" prop="arg">
            <el-col :span="16"  v-for="(val,key) in arg_count" :key="key" style="padding:0 0 2px 0;">
              <el-input
                  :placeholder="'请输入参数'+val"
                  v-model="args[val-1]"
                  clearable>
              </el-input>
            </el-col>
            <el-col :span="8">
              <el-button type="primary" :icon="Plus" @click="addArg" circle></el-button>
              <el-button type="danger" :icon="Minus" v-if="arg_count>1" @click="delArg" circle></el-button>
            </el-col>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" size="default" @click="handSaltExe" :loading="exeLoading">执行命令</el-button>
            <el-button size="default" @click="exeLoading=false">取消</el-button>
          </el-form-item>
          <el-form-item label="">
            <el-collapse>
              <el-collapse-item>
                <template #title>
                  <span style="color: red;font-weight: bold;">Arg填写帮助信息<el-icon class="header-icon"><info-filled /></el-icon></span>
                </template>
                <h4>平台调用的是salt-api所以Arg参数写法与命令行下有所不同</h4>
                <p>例1： 命令：ps.proc_info 从命令帮助中可以看到CLI下是这样的：</p>
                <p>salt '*' ps.proc_info 2322 attrs='["pid", "name"]' 其中参数是：<span style="color: red">2322 </span>和<span style="color: red">attrs='["pid", "name"]'</span></p>
                <p>平台需要写成：参数1:<span style="color: red">pid=2322 </span>参数2:<span style="color: red">attrs=["pid","name"]</span>   # 注意第二个参数列表外的引号不需要</p>
                <p>例2： 命令：salt '*' state.sls myslsfile pillar="{foo: 'Foo!', bar: 'Bar!'}"</p>
                <p>平台需要写成：参数1:<span style="color: red">myslsfile </span>参数2:<span style="color: red">pillar={foo: 'Foo!', bar: 'Bar!'}</span>   # 注意第二个参数列表外的引号不需要</p>
                <p>例3：salt '*' state.apply game.create pillar='{"zone": "*"}'</p>
                <p>参数1： <span style="color: red">state.apply</span>  参数2： <span style="color: red">pillar={"zone": "*"}</span></p>
              </el-collapse-item>
            </el-collapse>
          </el-form-item>
        </el-form>
        <hr>
      </el-col>

      <el-col :span="12">
        <el-form class="salt-result" ref="dataForm"  :model="exeData" label-position="top" label-width="130px">
          <el-form-item label="执行结果:">
                <pre class="saltexe_pre"  ref="salt_exe_result" v-html="salt_exe_result_data"
                     v-loading="resultLoading"
                     :element-loading-text="loadingText"></pre>

          </el-form-item>
        </el-form>
      </el-col>
    </el-row>

    <el-dialog v-model="dialogInfoVisible" :title="infoTemp.salt_cmd" width="40%">
      <el-input class="saltcmd-info-textarea" type="textarea" :autosize="{ minRows: 8, maxRows: 25}" readonly v-model="infoTemp.salt_cmd_doc"></el-input>
      <span slot="footer" class="dialog-footer">
        <el-button type="primary" @click="dialogInfoVisible = false">确定</el-button>
      </span>
    </el-dialog>

  </div>
</template>

<script setup>
import {onMounted, ref, nextTick, reactive, onBeforeMount, watch} from "vue";
import NewPagination from "@/components/pagination_new/NewPagination.vue";
import {Plus, Minus, InfoFilled, Loading} from "@element-plus/icons-vue";
import { ElMessage, ElMessageBox } from 'element-plus'
import { getSaltCmdCmdList, getSaltCmdModuleList, getMinionIdList, getSaltCmdList, saltExe } from "@/api/api";


let checkTgt = (rule, value, callback) => {
  if(exeData.value.client !== 'runner'){
    if (exeData.value.tgt_type !== 'any' && !value) {
      if(exeData.value.tgt_type !== 'minion_list'){
        callback(new Error('请选择执行对象'));
      }else{
        callback();
      }
    }else{
      callback();
    }
  }else{
    callback();
  }
};
let checkTgtType = (rule, value, callback) => {
  if(exeData.value.client !== 'runner'){
    if (!value) {
      callback(new Error('请选择执行对象类型'));
    }else{
      callback();
    }
  }else{
    callback();
  }
};
let exeData = ref({
  client: 'local',
  tgt: '',
  minion_list: [],
  tgt_type: '',
  fun: '',
});
let rules = {
  client: {required: true, message: '请选择salt命令', trigger: 'change'},
  tgt_type: {validator: checkTgtType, trigger: 'change'},
  fun: {required: true, message: '请输入命令', trigger: 'change'},
  tgt: {validator: checkTgt, trigger: 'change'},
};
let arg_count = ref(1);
let args = ref([]);
let salt_cmd_type = ref({local: 'module', local_async: 'module', runner: 'runner'});
let salt_cmd_help = reactive({local: '提示：等同命令行salt命令', local_async: '提示：等同命令行salt --async异步命令', runner: '提示：等同命令行salt-run命令,salt-run不需要执行对象参数',});
let minion_transfer_error = ref("");
let minion_list = ref([]);
let module_list = ref([]);
let tgt_type = ref("");
let tgt_type_label = ref({pcre: 'Minion正则：', custom_group:'自定义组：', grain: 'Grain：', grain_pcre: 'Grain正则：', ip_address: 'IP：'});
let tgt_type_placeholder = ref({
  pcre: '正则匹配Minion id',
  custom_group:'自定义组功能开发中。。。：',
  grain: '例：os:CentOS 或os:Windows',
  grain_pcre: '例：os:Cent*',
  ip_address: 'ip/ip段，例：192.168.1.1 or 192.168.1.0/24'
});
let select_module = ref("");
let exeLoading = ref(false);
let resultLoading = ref(false);
let dialogInfoVisible = ref(false)
let temp_module = ref("");
let fun_list = ref([]);
let infoTemp = ref({});
let salt_exe_result_data = ref('');
let loadingText = ref('命令执行中');
let post_tgt_type = ref({any: 'glob', minion_list: 'list', grain: 'grain', grain_pcre: 'grain_pcre', ip_address: 'ipcidr', pcre: 'pcre'})

onMounted(() => {
  searchModule()
})
watch(() =>exeData.value.tgt_type, (value) =>{
  if(minion_list.value.length === 0 && value === 'minion_list'){
    getIdList();
  }
})
watch(() =>exeData.value.minion_list, (value) => {
  if(value.length > 0 ){
    minion_transfer_error.value = ''
  }
})
function addArg() {
  arg_count.value = arg_count.value+1
}
function delArg() {
  if(arg_count.value >= 2){
    arg_count.value = arg_count.value-1
    args.value.pop()
  }
}
function searchModule() {
  let data = {
    "salt_cmd_type": salt_cmd_type.value[exeData.value.client],
  }
  getSaltCmdModuleList(data).then(response => {
    module_list.value = response
  }).catch(error => {
    console.log('searchModule' + error);
  })
}
function handFilterModule() {
  select_module.value = ""
  searchModule()
}
// 下面3个方法是Fun命令框输入带建议的操作
function funSearch(queryString, cb) {
  if(temp_module.value !== select_module){
    temp_module.value = select_module;
    let data = {
      "salt_cmd_type": salt_cmd_type.value[exeData.value.client],
      "salt_cmd_module": select_module.value
    }
    getSaltCmdCmdList(data).then(response => {
      fun_list.value = [];
      for(let item of response){
        fun_list.value.push({"value": item.salt_cmd})
      }

      let funRestaurants = fun_list.value;
      let results = queryString ? funRestaurants.filter(createFilter(queryString)) : funRestaurants;
      // 调用 callback 返回建议列表的数据
      cb(results);
    }).catch(error => {
      console.log('getSaltCmdCmdList' + error);
    })
  }else {
    let funRestaurants = fun_list.value;
    let results = queryString ? funRestaurants.filter(createFilter(queryString)) : funRestaurants;
    // 调用 callback 返回建议列表的数据
    cb(results);
  }
}
function createFilter(queryString) {
  return (restaurant) => {
    return (restaurant.value.toLowerCase().indexOf(queryString.toLowerCase()) !== -1);
  };
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
let salt_fun = ref()
// 获取命令帮助
function getCmdInfo() {
  let data = {
    salt_cmd_type:'',
    salt_cmd: ''
  }
  infoTemp.value = {};
  data.salt_cmd_type = salt_cmd_type.value[exeData.value.client]
  data.salt_cmd = exeData.value.fun
  if(data.salt_cmd){
    getSaltCmdList(data).then(response => {
      infoTemp.value = Object.assign({}, response.data.data[0])
      dialogInfoVisible.value = true
    }).catch(error => {
      console.log('获取命令帮助' + error);
    })
  }else{
    salt_fun.value.focus()
    // this.$refs['salt_fun'].focus();
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
let ruleForm = ref();
// 执行salt命令
function handSaltExe(){
  exeLoading.value = true;
  ruleForm.value.validate((valid) => {
    if (valid) {
      let data = {
        client: exeData.value.client,
        tgt: exeData.value.tgt,
        tgt_type: post_tgt_type.value[exeData.value.tgt_type],
        fun: exeData.value.fun,
        arg: []
      }
      for(let arg of args.value){
        if(arg.trim()){
          data.arg.push(arg)
        }
      }
      if(exeData.value.tgt_type === 'minion_list'){
        if (exeData.value.minion_list.length) {
          data.tgt = []
          for(let minion of exeData.value.minion_list){
            data.tgt.push(minion)
          }
        }
        else {
          minion_transfer_error.value = '请至少选择一个Minion ID'
          exeLoading.value = false
          return false;
        }
      }else if(exeData.value.tgt_type === 'any'){
        data.tgt = '*'
      }

      resultLoading.value = true
      data.salt_exe_tag = 'salt_exe'
      salt_exe_result_data.value = ''
      saltExe(data).then(response => {
        if(response.status){
          let data_count = 0;
          for (let k in response.results){
            let v = response.results[k]
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
        }
        else{
          salt_exe_result_data.value = ''
          salt_exe_result_data.value = salt_exe_result_data.value + "<p style='color: #bf0000;'>"+response.results+"</p>"
        }
        exeLoading.value = false;
        resultLoading.value = false
      }).catch(error => {
        console.log('执行salt命令' + error);
      })
    } else {
      exeLoading.value = false;
      resultLoading.value = false
      return false;
    }
  });
}
</script>

<style rel="stylesheet/scss" lang="scss" scoped>
.app-container{
  .overflow_set{
    height: calc(100vh - 170px);
    overflow: auto;
  }
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
  .el-radio-group{
    .el-radio{
      padding-bottom: 10px;
    }
  }
  .saltcmd-info-textarea .el-textarea__inner{
    background-color: #000;
    color: #00B600;
  }
}


</style>