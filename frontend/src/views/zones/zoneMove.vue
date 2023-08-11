<template>
  <div :class="{'ly-is-full':isFull}">
    <div ref="tableSelect" class="tableSelect">
      <el-button @click="addInfo" type="primary" icon="Plus">新增</el-button>
    </div>
    <el-table :height="'calc('+(tableHeight)+'px)'" :data="data_list" style="width: 100%" border class="tooltip-base-box" v-loading="listLoading">
      <el-table-column prop="id" label="ID" width="100" />
      <el-table-column prop="zone_id" label="区服ID" width="180" />
      <el-table-column prop="tg_minion" label="MinionID" width="180" />
      <el-table-column prop="port" label="目标主机ID" width="150" />
      <el-table-column prop="create_date" label="创建时间" />
      <el-table-column prop="update_time" label="更新时间" />
      <el-table-column prop="" label="操作">
        <template #header="scope">
          <el-tooltip effect="dark" content="已创建目录的区服无法编辑和删除" placement="top">
            <span>操作</span>
          </el-tooltip>
        </template>
        <template #default="scope">
          <!--            <el-button v-if="scope.row.status===0" type="primary">创区</el-button>-->
          <el-button v-if="scope.row.status===0" type="primary" @click="updateInfo(scope.row)">编辑</el-button>
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
          <el-form-item label="MinionID：" prop="tg_minion_id">
            <el-select v-model="formData.tg_minion" placeholder="MinionID" @change="getUseID">
              <el-option v-for="item in minion_list" :key="item.key" :label="item.label" :value="item.key"  />
            </el-select>
          </el-form-item>
          <el-tooltip  effect="dark" placement="left"  content="选择Minion后出现的是已使用ID">
            <el-form-item label="ID：" prop="port">
              <el-tag size="small" type="danger" v-for="item in id_list">{{item.id}}</el-tag>
              <el-input v-model="formData.port"></el-input>
            </el-form-item>
          </el-tooltip>
        </el-form>
      </el-scrollbar>
      <div slot="footer" style="margin: 0 auto;width: 200px">
        <el-button @click="dialogFormVisible = false">关闭</el-button>
        <el-button type="primary" @click="submitData">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script setup>
import {nextTick, onBeforeMount, onMounted, ref} from "vue";
import {
  getMoveList,
  addMoveInfo,
  updateMoveInfo,
  getMinionIdList,
  minionIDList,
  getMoveInfo
} from "@/api/api"
import {getTableHeight} from "@/utils/util";
import NewPagination from "@/components/pagination_new/NewPagination.vue";
import {ElMessage} from "element-plus";
let tableHeight = ref(500);
let tableSelect = ref(null);
let isFull = ref(false);
let data_list = ref([]);
let listLoading = ref(false);
let total = ref(0);
let listQuery = ref({
  page: 1,
  limit: 10,
  total: total.value,
  ordering: '',
});
let dialogFormVisible = ref(false);
let formData = ref({
  zone_id: 0,
  id: "",
  tg_minion: "",
});
let minion_list = ref([]);
let id_list = ref();
let dialogTitle = ref("");
let action = ref("");
let rules = {
  zone_id: {required: true, message: '请输入ZoneID', trigger: 'blur'},
  tg_minion: {required: true, message: '请选择minion_id', trigger: 'blur'},
  port: {required: true, message: '请输入id', trigger: 'blur'}
};
function getPagination(parm) {
  listQuery.value.page = parm.page
  listQuery.value.limit = parm.limit
  getData()
}
function getData() {
  listLoading.value = true
  getMoveList(listQuery.value).then(response => {
    data_list.value = response.data.data
    total.value = response.data.total
    listQuery.value.total = response.data.total
    setTimeout(() => {
      listLoading.value = false
    }, 0.5 * 1000)
  }).catch(error => {
    console.log('获取ZoneMove列表' + error);
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
// 清空弹出框
function resetTemp() {
  minion_list.value = [];
  formData.value = {
    zone_id: null,
    port: "",
    tg_minion: ""
  };
  id_list.value = {}
}
function addInfo(){
  resetTemp();
  dialogTitle.value = "新增"
  action.value = "create"
  dialogFormVisible.value = true;
  getIdList()
}
function updateInfo(row) {
  resetTemp();
  dialogTitle.value = "修改"
  dialogFormVisible.value = true;
  getMoveInfo(row.id).then(response => {
    console.log(response)
    formData.value = response
  }).catch(error => {
    console.log('获取Zone' + error);
  })
  action.value = "update";
  setTimeout(() => {
    getIdList()
    getUseID(formData.value.tg_minion)
  }, 0.5*1000)
}
function submitData() {
  dialogFormVisible.value = false
  if (action.value === "create") {
    addMoveInfo(formData.value).then(response => {
      console.log(response)
      if(response.status){
        ElMessage.success(response.results)
        getData()
      } else {
        ElMessage.error(response.results)
      }
    }).catch(error => {
      console.log("创建失败" + error)
    })
  } else {
    updateMoveInfo(formData.value).then(response => {
      if(response.status) {
        ElMessage.success(response.results)
        getData()
      } else {
        ElMessage.error(response.results)
      }
    }).catch(error => {
      console.log("修改失败" + error)
    })
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

<style scoped>

</style>