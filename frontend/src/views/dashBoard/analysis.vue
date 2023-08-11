<template>
    <div class="dashboard-editor-container">
<!--        <el-scrollbar>-->
<!--            <div>-->
<!--                <ly-growcard :loading="showloading" :rows="2" v-model="growData"></ly-growcard>-->
<!--            </div>-->
<!--            <div class="echarts-inner">-->
<!--                <ly-echartcard :loading="showloading" :rows="3" v-model="growData"></ly-echartcard>-->
<!--            </div>-->
<!--        </el-scrollbar>-->
      <el-row :gutter="8">
        <el-col>
          <div style="padding: 0 5px 5px 0">
            <el-switch
                v-model="autoUpdate"
                active-text="自动更新"
                active-color="#13ce66"
            />
            <span style="float: right; font-size: 14px; color: #13ce66"
            >更新时间:{{ dateFormat() }}</span
            >
          </div>
        </el-col>
      </el-row>
<!--      <el-button type="primary" :text="true" link @click="fetchData"><span style="font-size: 13px">手动刷新</span></el-button>-->
      <el-row :gutter="32">
        <el-col :xs="24" :sm="24" :lg="8">
          <div class="chart-wrapper">
            <MinionStatusChart v-model:list="minion_status_count"></MinionStatusChart>
          </div>
        </el-col>
        <el-col :xs="24" :sm="24" :lg="8">
          <div class="chart-wrapper">
            <MinionInfoChart v-model:list="saltkey_certification_count"></MinionInfoChart>
          </div>
        </el-col>
        <el-col :xs="{span: 24}" :sm="{span: 8}" :md="{span: 8}" :lg="{span: 8}" :xl="{span: 8}" style="margin-bottom:30px;">
          <SystemStatusChart v-model:list="sys_status"></SystemStatusChart>
        </el-col>
      </el-row>
    </div>
</template>

<script setup>
import MinionStatusChart from "@/views/dashBoard/components/MinionStatusChart.vue";
import MinionInfoChart from "@/views/dashBoard/components/MinionInfoChart.vue";
import SystemStatusChart from "@/views/dashBoard/components/SystemStatusChart.vue";
import {onMounted, reactive, ref, watch} from "vue";
import {dashboard} from "@/api/api";

let myInterval = null;
const autoUpdate = ref(false);
let minion_status_count = ref([]);
let sys_status = ref([]);
let saltkey_certification_count = ref([]);
let old_list = null;
let now_time = Date;

function fetchData() {
  const data = { opt_cmd: "dashboard_search" };
  dashboard(data).then(response => {
    const new_list = response.results;
    if (old_list !== new_list) {
      minion_status_count.value = response.results.minion_status_count;
      sys_status.value = response.results.sys_status;
      saltkey_certification_count.value = response.results.saltkey_certification_count;
    }
    dateFormat();
    console.log("fetchData")
  });
}

onMounted(() => {
  fetchData();
});

function dateFormat() {
  let data = new Date();
  let y = data.getFullYear();
  let m = data.getMonth()+1;
  let d = data.getDate();

  let hours = data.getHours()<10? '0'+ data.getHours():data.getHours()
  let minutes = data.getMinutes()<10? '0'+data.getMinutes():data.getMinutes()
  let seconds = data.getSeconds()<10? '0'+data.getSeconds():data.getSeconds()
  return `${y}-${m}-${d} ${hours}:${minutes}:${seconds}`
}

const startPolling = () => {
  myInterval = setInterval(() => {
    fetchData();
  }, 60000);
};

const stopPolling = () => {
  clearInterval(myInterval);
};

watch(autoUpdate, value => {
  if (value) {
    startPolling();
  } else {
    stopPolling();
  }
});

</script>
<style lang="scss" scoped>
    .lycontainer{
        width: 100%;
        height: calc(100vh - 130px); //动态计算长度值
        /*overflow-x: hidden;*/
        /*overflow-y:auto;*/
    }
    .echarts-inner{
        margin-top: 1px;
    }
    ::v-deep(.el-scrollbar__bar.is-horizontal) {
        display: none;
    }
    .dashboard-editor-container {
      padding: 32px;
      background-color: rgb(240, 242, 245);
      position: relative;

      .github-corner {
        position: absolute;
        top: 0;
        border: 0;
        right: 0;
      }

      .chart-wrapper {
        background: #fff;
        padding: 16px 16px 0;
        margin-bottom: 32px;
      }
    }

</style>