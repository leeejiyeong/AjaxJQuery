<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Bootstrap icons-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />

<!-- slick관련 css, js -->
<link rel="stylesheet" type="text/css"
	href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<link rel="stylesheet" type="text/css" href="css/slick-theme.css" />
<script type="text/javascript"
	src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script type="text/javascript"
	src="//code.jquery.com/jquery-migrate-1.2.1.min.js"></script>
<script type="text/javascript"
	src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>

<!-- Header-->
<header class="bg-dark py-5">
	<div class="container px-4 px-lg-5 my-5">
		<div class="text-center text-white">
			<h1 class="display-4 fw-bolder">Roasted coffee beans</h1>
			<p class="lead fw-normal text-white-50 mb-0">Enjoy fragrant
				coffee at home.</p>
			<div class="all-images"></div>
		</div>
	</div>
</header>
<!-- Section-->
<section class="py-5">
	<div class="container px-4 px-lg-5 mt-5">
		<div
			class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">

			<div class="col mb-5">
				<div class="card h-100">
					<!-- Sale badge-->
					<div class="badge bg-dark text-white position-absolute"
						style="top: 0.5rem; right: 0.5rem">Sale</div>
					<!-- Product image-->
					<a><img class="card-img-top"
						src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." /></a>
					<!-- Product details-->
					<div class="card-body p-4">
						<div class="text-center">
							<!-- Product name-->
							<h5 class="fw-bolder">Special Item</h5>
							<!-- Product reviews-->
							<div
								class="d-flex justify-content-center small text-warning mb-2">
								<div class="bi-star-fill"></div>
								<div class="bi-star-fill"></div>
								<div class="bi-star-fill"></div>
								<div class="bi-star-half"></div>
								<div class="bi-star"></div>
							</div>
							<!-- Product price-->
							<span class="text-muted text-decoration-line-through">$20.00</span>
							<span>$18.00</span>
						</div>
					</div>
					<!-- Product actions-->
					<div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
						<div class="text-center">
							<a class="btn btn-outline-dark mt-auto" href="#">Add to cart</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<!-- <script src="js/jquery-3.6.3.min.js"></script> -->
<script>
	//상품정보를 불러오기 위한 ajax호출
	$
			.ajax({
				url : 'productList.do',
				dataType : 'json',
				success : function(result) {
					console.log(result)

					//each반복문
					$(result)
							.each(
									function(idx, item) {
										//.all-images 하위에 <div><img src="" item=""></div>
										$('.all-images')
												.append(
														$('<div><img style="width:250px; height:250px;" src="images/'+item.image+'" item="'+item.productCode+'"></div>'));

										let template = $(
												'div.col.mb-5:nth-child(1)')
												.clone(); //'div.col.mb-5:nth-child(1)'를 복제해서 하나 더 만들어준다는 뜻
										console.log(template)
										template.find('h5').text(
												item.productName); //하위 요소중에서 h5를 찾아서 텍스트 넣어줌

										template.find('img').attr('src',
												'images/' + item.image)

										//상품코드 링크로 넘기기
										template.find('a').attr(
												'href',
												"productInfo.do?item="
														+ item.productCode)

										//span, span 가져와서 가격정보 수정
										price = item.price
												.toLocaleString('ko-KR') //가격에 콤마 넣어주기
										salePrice = item.salePrice
												.toLocaleString('ko-KR')
										template
												.find(
														'div .text-center > span:nth-of-type(1)')
												.text('￦' + price) //div의 하위요소 중에 span 중에서만 순번을 따짐
										template
												.find(
														'div .text-center > span:nth-of-type(2)')
												.text('￦' + salePrice) //nth-child를 사용하려면 'div .text-center > span:nth-child(4)'

										//평점(별점) ex)3.5점 -> 3:fill, 0.5:half, 1:()
										//기존에 고정되어있던걸 지우고 평점에 따라 append해주는 방식으로 하자
										template.find('div .d-flex > div')
												.remove() //기존의 하위요소(별)를 remove()
										let target = template
												.find('div .d-flex') //parent요소를 변수로 지정해줌

										for (let i = 0; i < 5; i++) {
											if (i < Math.floor(item.likeIt)) { //Math.floor : 소수점 버림
												target
														.append($('<div />')
																.attr('class',
																		'bi-star-fill')) //새로운 div를 만들어 붙이고 class추가
											} else if (i < item.likeIt) {
												target
														.append($('<div />')
																.addClass(
																		'bi-star-half'))
											} else {
												target.append($('<div />')
														.addClass('bi-star'))
											}
										}

										$('div.row').append(template);
									})
					//display:none
					$('div.col.mb-5:nth-child(1)').css('display', 'none');

					//slick호출
					$('.all-images').slick({
						autoplay : true,
						autoplaySpeed : 2000,
						centerMode : true,
						centerPadding : '60px',
						slidesToShow : 3,
						responsive : [ {
							breakpoint : 768,
							settings : {
								arrows : false,
								centerMode : true,
								centerPadding : '40px',
								slidesToShow : 3
							}
						}, {
							breakpoint : 480,
							settings : {
								arrows : false,
								centerMode : true,
								centerPadding : '40px',
								slidesToShow : 1
							}
						} ]
					});

				},
				error : function(reject) {
					console.log(reject)
				}

			})

	$('.all-images').on('click', function(event, slick, direction) {
		console.log(event.target.getAttribute('item'))
		let item = event.target.getAttribute('item');
		//이미지가 아닌 곳을 클릭하면 이동 안하도록
		if (item) {
			$(location).attr('href', 'productInfo.do?item=' + item);
			//location.href = 'productInfo.do?item='+item;
		}
	});
</script>