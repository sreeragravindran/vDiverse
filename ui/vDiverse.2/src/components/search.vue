<template>
	<div class="search">
	    <h1>{{title}}</h1><br>
        <input type="text" v-model="query" placeholder="Role description..."/> 
        <button type="submit" @click="getProfiles()"> SUBMIT</button>
        <br>
        <br>
        <br>
        <br>
        <table class="table" id="myTable" border="1px">
            <thead border="1px">
            <tr border="1px">
                <th>Name</th>
                <th>Gender</th>
                <th>Age</th>
            </tr>
            </thead>
            <tbody v-for="profile in profiles" border="1px">
            <tr>
                <td>{{ profile.name }}</td>
                <td>{{ profile.gender }}</td>
                <td>{{ profile.age }}</td>
            </tr>
            </tbody>
        </table>
	</div>
</template>
<script>
	export default{
		name:'search',
		data (){
			return {
				title:'SEARCH',
                query: '',
                profiles: []
			}
		},
        methods: {
            async getProfiles() {
                console.log('Method Called')
                const url = 'http://localhost:4000/vDiverse/api/recommendations?role=' + this.query
                const response = await this.$http.get(url);
                console.log(url)
                this.profiles = response.data;
            }
	    }
    }
</script>

<style scoped>

.search {
  position: absolute;
  left: 50%;
  top:40%;
  transform: translate(-50%, -50%);
  width: 1200px;
  height: 400px;
  padding: 30px;
}
</style>