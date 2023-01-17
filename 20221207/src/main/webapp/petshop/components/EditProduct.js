/**
 * EditProduct.js
 */

export default {
	template:`
	<div>
		<h1>상품 정보 수정</h1>
		상품명: <input type="text" v-model="title"><br>
		상품가격: <input type="text" v-model="price"><br>
		상품설명: <textarea v-model="description"></textarea><br>
		<button v-on:click="changeInfo">수정</button>
	</div>
	`,
	data(){
		return {
			price: 100,
			title: '변경제목',
			description: '변경내용'
		}
	},
	methods:{
		changeInfo: function(){
			console.log(this.$parent.product)
			this.$parent.product.price = this.price;
			this.$parent.product.title = this.title;
			this.$parent.product.description = this.description;
		}
	}
}