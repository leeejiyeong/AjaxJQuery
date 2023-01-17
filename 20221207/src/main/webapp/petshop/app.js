/**
 * app.js
 */

import router from './router/router.js'

const template = `
	<div id="app">
		<router-view></router-view>
	</div>
`

new Vue({
	el: '#app',
	template,		//template: template의 줄임표현. 이름이 같으면 줄여쓸수 있다. 
	router			//router: {router: router}의 줄임표현
})