<template>
    <div id="infoChart" :class="className" :style="{height:height,width:width}" />
</template>

<script setup>
import {computed, nextTick, onBeforeMount, onMounted, reactive, toRefs, watch} from "vue";
import * as echarts from "echarts";

const props = defineProps({
  className: {
    type: String,
    default: 'chart'
  },
  width: {
    type: String,
    default: '100%'
  },
  height: {
    type: String,
    default: '300px'
  },
  list: {
    type: Array,
  },
  now_time:{
    type: [String, Date],
  }
})

let accepted = 0;
let unaccepted = 0;
let denied = 0;
let rejected = 0;
let chart = null;

onMounted(() => {
  setTimeout(() => {
    chart = echarts.init(document.getElementById("infoChart"));
    initChart()
  }, 300);
});
onBeforeMount(() => {
  if (!chart) {
    return;
  }
  chart.dispose();
  chart = null;
});

watch(() => props.list,  (value, oldValue) => {
  if (value !== oldValue) {
    initChart()
  }
});

function initChart() {
  if(props.list){
    for (let v of props.list) {
      if (v["certification_status"] === 'accepted') {
        accepted = v["certification_status__count"]
      }
      else if(v["certification_status"] === 'unaccepted'){
        unaccepted = v["certification_status__count"]
      }
      else if(v["certification_status"] === 'denied'){
        denied = v["certification_status__count"]
      }
      else if(v["certification_status"] === 'rejected'){
        rejected = v["certification_status__count"]
      }
    }
  }

  chart.setOption({
    title: {
      text: 'Minion信息',
      subtext: 'Minion认证分布比例',
      left: 'left'
    },
    tooltip: {
      trigger: 'item',
      formatter: '{a} <br/>{b} : {c} ({d}%)'
    },
    legend: {
      left: 'center',
      bottom: '10',
      data: ['已认证', '待认证', '禁止', '已拒绝']
    },
    series: [
      {
        name: 'Minion信息',
        type: 'pie',
        roseType: 'radius',
        radius: '55%',
        // radius: [15, 95],
        data: [
          { value: accepted, name: '已认证' },
          { value: unaccepted, name: '待认证' },
          { value: denied, name: '禁止' },
          { value: rejected, name: '已拒绝' }
        ],
        animationEasing: 'cubicInOut',
        animationDuration: 2600
      }
    ]
  })
}
</script>

<style scoped>

</style>