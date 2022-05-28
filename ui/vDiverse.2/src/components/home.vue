<template>
  <div class="home">
      <pre>Username <input type="String" :value="username"></pre>
      <pre>Password <input type="String" :value="password"></pre>
      <pre><button @click="login">login</button></pre>
  </div>
</template>

<script>
export default {
  methods:{
  login() {
    this.$router.push({name: 'search'})
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
