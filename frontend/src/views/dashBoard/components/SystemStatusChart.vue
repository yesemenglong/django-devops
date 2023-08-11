<template>
  <el-card class="box-card" :body-style="{ padding: '5px' }">
    <div slot="header" class="clearfix">
      <span>系统状态</span>
    </div>
    <el-table :data="list" style="width: 100%;padding-top: 5px;">
      <el-table-column label="名称" min-width="120" prop="name">
      </el-table-column>
      <el-table-column label="状态" min-width="80" align="center" prop="value">
      </el-table-column>
    </el-table>
  </el-card>
</template>

<script setup>
const props = defineProps({
  list: {
    type: Array,
  }
})


</script>

<style scoped>

</style>