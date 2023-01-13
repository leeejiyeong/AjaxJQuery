/**
 * bookVue.js
 */
const memberAry = [];

const addComponent = {
	template: `
		<div id="addMember">
			<table class="table">
				<tr>
					<th>{{idLabel}}</th>
					<td><input type="text" v-model="mId"></td>
				</tr>
				<tr>
					<th>{{nameLabel}}</th>
					<td><input type="text" v-model="mName"></td>
				</tr>
				<tr>
					<th>{{ageLabel}}</th>
					<td><input type="text" v-model="mAge"></td>
				</tr>
				<tr>
					<th>{{telLabel}}</th>
					<td><input type="text" v-model="mTel"></td>
				</tr>
				<tr>
					<th>{{addrLabel}}</th>
					<td><input type="text" v-model="mAddr"></td>
				</tr>
				<tr>
					<td colspan='2'>
						<button v-bind:style="{'color':myColor}" class="btn btn-primary" v-on:click="addMember">회원등록</button>
						<button v-bind:style="{'color':myColor}" class="btn btn-primary" v-on:click="selectedMemberDel">선택삭제</button>
					</td>
				</tr>
			</table>
		</div>
	`,
	data: function() {
		return {
			//라벨
			idLabel: '회원 아이디',
			nameLabel: '회원 이름',
			ageLabel: '회원 나이',
			telLabel: '회원 연락처',
			addrLabel: '회원 주소',

			//입력
			mId: 'user1',
			mName: '김또치',
			mAge: 20,
			mTel: '010-1234-1234',
			mAddr: '대구 달서구',
			members: memberAry,

			myColor: 'hotpink'

		}
	},
	methods: {
		addMember: function() {
			let params = 'memberId=' + this.mId
				+ '&memberName=' + this.mName
				+ '&memberPassword=1234'
				+ '&memberAge=' + this.mAge
				+ '&memberTel=' + this.mTel
				+ '&memberAddress=' + this.mAddr
			fetch('../memberAddAjax.do', {
				method: 'post',
				headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
				body: params
			})
				.then(resolve => resolve.json())
				.then(result => {
					console.log(result);
					this.members.push(result.data)
				})
				.catch(reject => {
					console.log(reject)
				})

		},
		selectedMemberDel: function() {
			//얘가 위치한 곳은 addComponent인데 지워야될 대상이 listComponent에 있다. 어케야될까?
			console.log(this.$parent.$children[1].targetMember)
			let targetList = this.$parent.$children[1].targetMember;
			console.log(this.members[5].memberId)
			
			//this.members에 포함된 값과 동일한 것 삭제
			fetch('../memberDelAjax.do?id=' + members.memberId)
				.then(resolve => resolve.json())
				.then(result => {
					if (result.retCode == 'Success') {
						this.members.forEach((member, idx) => {
							//삭제 아이디와 동일한 값을 배열에서 제거함
							if (member.memberId == targetList) {
								this.members.splice(idx, 1);
							}
						})
					}
				})
				.catch(reject => {
					console.log(reject)
				})

		}
	}
}

const listComponent = {
	template: `
	<div>
		<table class="table">
			<thead>
				<tr>
					<th><input type="checkbox"></th>
					<th>아이디</th>
					<th>이름</th>
					<th>나이</th>
					<th>연락처</th>
					<th>주소</th>
				</tr>
			</thead>
			<tbody>
				<tr v-for="member in members">
					<td><input type="checkbox" v-bind:value="member.memberId" v-model="targetMember"></td>
					<td>{{member.memberId}}</td>
					<td>{{member.memberName}}</td>
					<td>{{member.memberAge}}</td>
					<td>{{member.memberTel}}</td>
					<td>{{member.memberAddress}}</td>
					<td><button v-on:click="deleteMember(member.memberId)">삭제</button></td>
				</tr>
			</tbody>
		</table>
		{{targetMember}}
	</div>
	`,
	data: function() {
		return {
			members: memberAry,
			targetMember: []
		}
	},
	methods: {
		deleteMember: function(id) {
			fetch('../memberDelAjax.do?id=' + id)
				.then(resolve => resolve.json())
				.then(result => {
					if (result.retCode == 'Success') {
						this.members.forEach((member, idx) => {
							//삭제 아이디와 동일한 값을 배열에서 제거함
							if (member.memberId == id) {
								this.members.splice(idx, 1);
							}
						})
					} else {
						alert('처리중 에러')
					}
				})
				.catch(reject => {
					console.log(reject);
				})
		}
	}
}

new Vue({
	el: '#app',
	components: {
		'add-component': addComponent,
		'list-component': listComponent
	},
	data: {
		members: memberAry
	},
	beforeCreate: function() {
		console.log('beforeCreate hook')
	},
	created: function() {
		console.log('created hook')
		fetch('../memberListAjax.do')
			.then(resolve => resolve.json())
			.then(result => {
				console.log(result);
				result.forEach(member => {
					this.members.push(member);

				})
			})
			.catch(reject => {
				console.log(reject)
			})
	},
	beforeMount: function() {
		console.log('beforeMount hook')
	},
	mounted: function() {
		console.log('mounted hook')
	}
})