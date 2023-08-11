<template>
  <div :class="{'ly-is-full':isFull}">
    <div ref="tableSelect" class="tableSelect">
      <el-tooltip effect="dark" content="批量创建" placement="top">
        <el-button type="primary" @click="deploy" :loading="isLoading">创区</el-button>
      </el-tooltip>
    </div>


    <el-row :gutter="20">
      <el-col :span="8">
        <el-table :height="'calc('+(tableHeight)+'px)'" :data="data_list" style="width: 100%" border class="tooltip-base-box" v-loading="listLoading">
          <el-table-column prop="zone_id" label="区服ID" width="100" sortable="custom" />
          <el-table-column prop="name" label="区服名称" width="120" />
          <el-table-column prop="ip" label="IP" width="140" />
          <el-table-column prop="id" label="ID" width="80" />
          <el-table-column prop="minion_id" label="MinionID" sortable="custom" width="" />
        </el-table>

        <NewPagination v-bind:child-msg="listQuery" @pagination="getPagination"></NewPagination>
      </el-col>
      <el-col :span="16">
        <el-form class="body" ref="dataForm"  label-position="top" label-width="130px">
<!--          <el-form-item label="执行结果:">-->
<!--                <pre class="saltexe_pre"  ref="salt_exe_result" v-html="logs"></pre>-->
<!--          </el-form-item>-->
          <div class="header">
            <div class="title">执行结果:</div>
          </div>
          <div class="termContainer">
            <div id="terminal" ref="terminal" class="term"></div>
          </div>

        </el-form>
      </el-col>
    </el-row>
  </div>
</template>

<script setup>
import {nextTick, onBeforeMount, onMounted, ref} from "vue";
import {getZoneStatusList, batchDeployZones} from "@/api/api";
import {domain} from "@/api/url";
import {ElMessage} from "element-plus";
import NewPagination from "@/components/pagination_new/NewPagination.vue";
import {getTableHeight} from "@/utils/util";
import { Terminal } from 'xterm';
import { FitAddon } from 'xterm-addon-fit';

let tableHeight = ref(500);
let tableSelect = ref(null);
let listLoading = ref(false);
let isLoading = ref(false)
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
let ws = ref(null);
let logs = ref('');
// let logs = ref([])

onMounted(() => {
  getData()
  initTerm()
})
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
function getPagination(parm) {
  listQuery.value.page = parm.page
  listQuery.value.limit = parm.limit
  getData()
}
const term = new Terminal({
  disableStdin: true,
  fontSize: 16,
  fontFamily: 'Courier',
  theme: {
    background: '#2b2b2b',
    foreground: '#A9B7C6',
    cursor: '#2b2b2b'
  }
})
const fitPlugin = new FitAddon()

function initTerm() {
  const termContainer = document.getElementById('terminal')

  term.attachCustomKeyEventHandler(async (event) => {
    if (event.ctrlKey && event.code === 'KeyC' && event.type === 'keydown') {
      try {
        await navigator.clipboard.writeText(term.getSelection());
        return false;
      } catch (error) {
        console.error('Copying failed:', error);
      }
    }
    return true;
  });
  term.loadAddon(fitPlugin)
  term.open(termContainer)
  fitPlugin.fit()
  term.write("ttttttttttttttt")
  const resize = () => fitPlugin.fit();
  window.addEventListener('resize', resize)

  return () => window.removeEventListener('resize', resize);
}

function connect() {
  const protocol = window.location.protocol === 'https:' ? 'wss' : 'ws';
  ws = new WebSocket(`${protocol}://` + domain + `/ws/log/`);

  ws.onopen = () => {
    console.log('WebSocket connected')
    ws.send('ok')
    fitPlugin.fit()
  };
  ws.onmessage = event => {
    console.log(event.data)
    // if (event.data === 'pong'){
    //   ws.send('ping')
    // }
    let data = JSON.parse(event.data)
    term.write(data)

  };
  ws.onerror = (event) =>{
    console.log('WebSocket连接错误：', event)
  };
  // ws.onclose = (e) => {
  //   console.log(e)
  //   console.log('WebSocket Close')
  //   return () => ws && ws.close()
  // }
}
function deploy(){
  connect()
  listLoading.value = true
  isLoading.value = true
  batchDeployZones().then(response => {
    if(response.status) {
      ElMessage.success(response.results)
      getData()
      setTimeout(() => {
        ws.close()
        isLoading.value = false
      }, 1000)
    } else {
      ElMessage.error(response.results)
      ws.close()
      isLoading.value = false
      listLoading.value = false
    }
  }).catch(error => {
    console.log('创建失败 ' + error);
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
.body {
  display: flex;
  flex-direction: column;
  //width: calc(100% - 300px);
  padding: 22px;

  .header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 12px;

    .title {
      font-weight: 500;
    }
  }
  .termContainer {
    background-color: #2b2b2b;
    padding: 8px 0 4px 12px;
    border-radius: 4px;
    width: 100%;

    .term {
      width: 100%;
      height: calc(100vh - 300px);
      //height: 100%;
    }
  }
}
</style>