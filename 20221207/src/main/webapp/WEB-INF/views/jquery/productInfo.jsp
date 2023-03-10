<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Bootstrap icons-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />

</style>
<!-- Product section-->
<section class="py-5">
	<div class="container px-4 px-lg-5 my-5">
		<div class="row gx-4 gx-lg-5 align-items-center">
			<div class="col-md-6">
				<img class="card-img-top mb-5 mb-md-0"
					src="https://dummyimage.com/600x700/dee2e6/6c757d.jpg" alt="..." />
			</div>
			<div class="col-md-6">
				<div class="small mb-1">${productCode }</div>
				<h1 class="display-5 fw-bolder">Shop item template</h1>
				<div class="fs-5 mb-5">
					<span class="text-decoration-line-through">$45.00</span> <span>$40.00</span>
				</div>
				<p class="lead">Lorem ipsum dolor sit amet consectetur
					adipisicing elit. Praesentium at dolorem quidem modi. Nam sequi
					consequatur obcaecati excepturi alias magni, accusamus eius
					blanditiis delectus ipsam minima ea iste laborum vero?</p>
				<div class="d-flex">
					<input class="form-control text-center me-3" id="inputQuantity"
						type="num" value="1" style="max-width: 3rem" />
					<button class="btn btn-outline-dark flex-shrink-0" type="button">
						<i class="bi-cart-fill me-1"></i> Add to cart
					</button>
				</div>
			</div>
		</div>
	</div>
</section>
<!-- Related items section-->
<section class="py-5 bg-light">
	<div class="container px-4 px-lg-5 mt-5">
		<h2 class="fw-bolder mb-4">Related products</h2>
		<div
			class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">

			<div class="col mb-5">
				<div class="card h-100">
					<!-- Sale badge-->
					<div class="badge bg-dark text-white position-absolute"
						style="top: 0.5rem; right: 0.5rem">Sale</div>
					<!-- Product image-->
					<img class="card-img-top"
						src="https://dummyimage.com/450x300/dee2e6/6c757d.jpg" alt="..." />
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
								<div class="bi-star-fill"></div>
								<div class="bi-star-fill"></div>
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
<script src="js/jquery-3.6.3.min.js"></script>
<script>
	//??????????????? ?????? ???????????? ????????????
	let template = $('section.py-5:nth-of-type(1)');
	$.ajax({
		url : 'productDetail.do?item=${productCode }',
		dataType : 'json',
		success : function(result) {
			console.log(result)
			template.find('h1').text(result.productName); //????????????
			//??????
			price = result.price.toLocaleString('ko-KR') //????????? ?????? ????????????
			salePrice = result.salePrice.toLocaleString('ko-KR')
			template.find('div .fs-5 > span:nth-of-type(1)').text('???' + price); //????????????
			template.find('div .fs-5 > span:nth-of-type(2)').text(
					'???' + salePrice); //????????????
			template.find('p.lead').text(result.productDesc); //????????????
			template.find('img').attr('src', 'images/' + result.image) //?????????

		},
		error : function(error) {
			console.log(error)
		}
	})

	/*  $.ajax({
		url : 'productList.do',
		dataType: 'json',
		success: function(result){
			console.log(result)
			console.log(location.href)
			let productCode = location.href.slice(-5)
			
			$(result).each(function(idx, item){
				if(productCode == item.productCode){
					$('div .col-md-6 > img').attr('src', 'images/' + item.image)	//??????
					$('div .col-md-6 > .small').text(item.productCode)				//????????????
					$('div .col-md-6 > h1').text(item.productName)					//????????????
					//???????????? ??????
					price = item.price.toLocaleString('ko-KR')
					salePrice = item.salePrice.toLocaleString('ko-KR')
					$('div .fs-5 > span:nth-child(1)').text('???' + price)		//??????
					$('div .fs-5 > span:nth-child(2)').text('???' + salePrice)	//????????????
					$('div .col-md-6 > p').text(item.productDesc)				//????????????
					
				}
				
			})
		},
		error: function(reject){
			console.log(reject)
		}
	}) */

	//???????????? ??????
	$.ajax({
		url : 'relatedProducts.do',
		dataType : 'json',
		success : function(result) {
			console.log(result)

			$(result).each(
					function(idx, item) {
						let template = $('div.col.mb-5:nth-child(1)').clone();

						template.find('img')
								.attr('src', 'images/' + item.image)
						template.find('h5').text(item.productName);

						//??????
						price = item.price.toLocaleString('ko-KR') //????????? ?????? ????????????
						salePrice = item.salePrice.toLocaleString('ko-KR')
						template.find('div .text-center > span:nth-of-type(1)')
								.text('???' + price)
						template.find('div .text-center > span:nth-of-type(2)')
								.text('???' + salePrice)

						//??????
						template.find('div .d-flex > div').remove() //????????? ????????????(???)??? remove()
						let target = template.find('div .d-flex') //parent????????? ????????? ????????????

						for (let i = 0; i < 5; i++) {
							if (i < Math.floor(item.likeIt)) { //Math.floor : ????????? ??????
								target.append($('<div />').attr('class',
										'bi-star-fill')) //????????? div??? ????????? ????????? class??????
							} else if (i < item.likeIt) {
								target.append($('<div />').addClass(
										'bi-star-half'))
							} else {
								target.append($('<div />').addClass('bi-star'))
							}
						}
						//????????? ?????????
						$('div .row:nth-child(2)').append(template);
					})

			//display:none(?????? ???????????? div ????????????)
			$('div.col.mb-5:nth-child(1)').css('display', 'none');

		},
		error : function(error) {
			console.log(error)
		}
	})
</script>