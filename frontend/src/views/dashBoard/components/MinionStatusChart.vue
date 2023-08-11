<template>
  <div id="customerChart" style="width: 100%; height: 35vh" />
</template>

<script setup>
import {
  onMounted,
  nextTick,
  watch,
  onBeforeMount
} from "vue";
import * as echarts from "echarts";

let chart = null;
let online = 0;
let offline = 0;
let anomaly = 0;


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
});


function initChart() {
  if (props.list) {
    for (const v of props.list) {
      if (v["minion_status"] === "在线") {
        online = v["minion_status__count"];
      } else if (v["minion_status"] === "离线") {
        offline = v["minion_status__count"];
      } else if (v["minion_status"] === "异常") {
        anomaly = v["minion_status__count"];
      }
    }
  }
  chart.setOption({
    title: {
      text: "Minion状态",
      subtext: "Minion状态统计"
    },
    tooltip: {
      trigger: "axis",
      axisPointer: {
        type: "shadow"
      }
    },
    grid: {
      left: "3%",
      right: "4%",
      bottom: "3%",
      containLabel: true
    },
    xAxis: [
      {
        type: "value",
        boundaryGap: [0, 1]
      }
    ],
    yAxis: [
      {
        type: "category",
        inverse: true,
        data: ["在线", "离线", "异常"]
      }
    ],
    series: [
      {
        name: "数量",
        type: "bar",
        stack: "vistors",
        barWidth: "60%",
        itemStyle: {
          color: function (params) {
            const colorList = ["#22DDDD", "#FE8463", "#FAD860"];
            return colorList[params.dataIndex];
          }
        },
        data: [online, offline, anomaly],
        animationDuration: 6000
      }
    ]
  })
}

onMounted(() => {
  // nextTick(() => {
  //   initChart();
  //   console.log("nextTick")
  // });
  setTimeout(() => {
    chart = echarts.init(document.getElementById("customerChart"));
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
    nextTick(() => {
      initChart();
    });
  }
});
</script>

<style scoped>

</style>