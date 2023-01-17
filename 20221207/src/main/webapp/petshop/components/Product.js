/**
 *  Product.js
 */
import MyHeader from './Header.js';

export default {
	template: `
	<div>
    <my-header></my-header>
    <h1>id {{$route.params.id}} 입니다.</h1>
    <div class="row">
      <div class="col-md-5 col-md-offset-0">
        <figure>
          <img class="product" v-bind:src="product.image">
        </figure>
      </div>
      <div class="col-md-6 col-md-offset-0 description">
        <h1>{{product.title}}</h1>
        <p v-html="product.description"></p>
        <p class="price">{{product.price}}</p>
        <button @click="edit">상품 수정</button>
        <router-view></router-view>
      </div>
    </div>
  </div>
	`,
	components: { MyHeader },
	data() {
		return {
			product: ''
		}
	},
	methods: {
		edit() {
			this.$router.push({ name: 'edit' })
		}
	},
	created: function() {
		axios.get('./static/products.json')
			.then((response) => {
				this.product = response.data.products.filter(data => data.id == this.$route.params.id)[0];
				this.product.image = './' + this.product.image;
			});
	}
}