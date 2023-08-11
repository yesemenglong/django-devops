<template>
  <div class="lyPagination-page">
    <el-pagination class="page-box" @size-change="handleSizeChange" @current-change="handleCurrentChange" background :current-page="childMsg.page" :page-sizes="pageSizes" :page-size="childMsg.limit" :layout="layout" :total="childMsg.total"></el-pagination>
  </div>
</template>

<script setup>
import {watch} from "vue";

const props = defineProps({
  childMsg: { type: Object, default: () => {} },
  pageSizes: { type: Array, default: [10,20,30,40,50,100] },
  layout: { type: String, default: "total, sizes, prev, pager, next, jumper" },
})

// watch(() => props.childMsg.page, value => {
//   console.log(props.childMsg.page, "childMsg")
// })
const emit = defineEmits(['pagination'])

let pageparm = {
  page: props.childMsg.page || 1,
  limit: props.childMsg.limit || 20,
}

function handleSizeChange(val) {
  pageparm.limit = val
  pageparm.page = 1
  emit('pagination', pageparm)
}

function handleCurrentChange(val) {
  pageparm.page = val
  emit('pagination', pageparm)
}
</script>

<style lang="scss" scoped>
.lyPagination-page{
  display: flex;
  align-items: center;
  background: var(--el-fill-color-blank);
  border-bottom: 1px solid var(--el-border-color-light);
  border-left: 1px solid var(--el-border-color-light);
  border-right: 1px solid var(--el-border-color-light);
}
.page-box {
  margin: 10px auto;
  text-align: center;
  .el-pagination__editor.el-input{
    width: 70px !important;
    .el-input__inner{
      text-indent: 0 !important;
    }
  }
}
</style>
