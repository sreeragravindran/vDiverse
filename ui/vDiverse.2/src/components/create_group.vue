<template>
  <div class="create_group">
      <pre>Group Name <input v-model="groupName" type="String"></pre>

      <pre><button @click="create(groupName)">Create</button></pre>
  </div>
</template>

<script>
export default {

  data() {
    return {groupName: ''}
  },
  methods:{
  create(group) {
    this.groupName = group + 'updated'
  },
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.row img{
  max-height: 15em;
  width: 100%;

}
.row h3{
  cursor:pointer;
}

.home {
  position: absolute;
  left: 50%;
  top:30%;
  transform: translate(-50%, -50%);
  border: 1px solid #000000;
  padding: 30px;
}
</style>
