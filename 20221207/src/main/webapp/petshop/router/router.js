/**
 *  router.js : url pattern랑 component랑 매핑한다.
	얘를 쓸라면 라이브러리가 필요하다.
 */
import Main from '../components/Main.js';
import Form from '../components/Form.js';
import Product from '../components/Product.js';
import EditProduct from '../components/EditProduct.js';


export default new VueRouter({		//얘도 app.js에서 import하기 때문에 export해줌
	//mode:'history',					//url에 #제거해줌
	routes: [
		{
			path: '/',
			name: 'main',			//name : 나중에 링크 호출할때 사용됨
			component: Main		
		},
		{
			path: '/form',
			name: 'form',
			component: Form
		},
		{
			path: '/product/:id',	//파라메터 넘길때는 콜론(:) 다음에 적으면 된다.
			name: 'Id',
			component: Product,
			children: [
				{
					path: 'edit',
					name: 'edit',
					component: EditProduct
				}
			]
		},
		{	//위에서 적은것 이외의 요청이 들어올때
			path: '*',
			redirect: '/'	//제일 상위에 있는 url(main으로 가도록)
		}
	]
})