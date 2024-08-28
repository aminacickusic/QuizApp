<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" href="<%=request.getContextPath()%>/images/logo.png"
	type="image/x-icon">
<link href="<%=request.getContextPath()%>/css/startpage.css"
	rel="stylesheet" type="text/css">
<link href="<%=request.getContextPath()%>/css/chooseavatar.css"
	rel="stylesheet" type="text/css">
	
<title>Change Avatar</title>

</head>
<body>
	<section class="ftco-section">
		<div class="container">
			<nav class="navbar navbar-expand-lg ftco_navbar ftco-navbar-light"
				id="ftco-navbar">
				<div class="container">
					<img src="<%=request.getContextPath()%>/images/logo-color.png"
						alt="logo-image" class="logo-image-navbar">
					<button class="navbar-toggler" type="button" data-toggle="collapse"
						data-target="#ftco-nav" aria-controls="ftco-nav"
						aria-expanded="false" aria-label="Toggle navigation">
						<span class="fa fa-bars"></span> Menu
					</button>
				</div>
			</nav>
			<div class="choose-avatar">CHANGE AVATAR:</div>
		</div>
	</section>

	<div class="avatars">



		
		<div class="avatars-row">
			<div class="container mt-5 avatar-row-element">
				<button class="btn btn-primary btn-circle">
					<i class="material-icons"><img
						src="<%=request.getContextPath()%>/images/avatars/1.jpg"
						alt="avatar-image" class="avatar-icon" id="1"></i>
				</button>
			</div>
			<div class="container mt-5 avatar-row-element">
				<button class="btn btn-primary btn-circle">
					<i class="material-icons"><img
						src="<%=request.getContextPath()%>/images/avatars/2.jpg"
						alt="avatar-image" class="avatar-icon" id="2"></i>
				</button>
			</div>
			<div class="container mt-5 avatar-row-element">
				<button class="btn btn-primary btn-circle">
					<i class="material-icons"><img
						src="<%=request.getContextPath()%>/images/avatars/3.jpg"
						alt="avatar-image" class="avatar-icon" id="3"></i>
				</button>
			</div>
			<div class="container mt-5 avatar-row-element">
				<button class="btn btn-primary btn-circle">
					<i class="material-icons"><img
						src="<%=request.getContextPath()%>/images/avatars/4.jpg"
						alt="avatar-image" class="avatar-icon" id="4"></i>
				</button>
			</div>
		</div>
		
		<div class="avatars-row">
			<div class="container mt-5 avatar-row-element">
				<button class="btn btn-primary btn-circle">
					<i class="material-icons"><img
						src="<%=request.getContextPath()%>/images/avatars/5.jpg"
						alt="avatar-image" class="avatar-icon" id="5"></i>
				</button>
			</div>
			<div class="container mt-5 avatar-row-element">
				<button class="btn btn-primary btn-circle">
					<i class="material-icons"><img
						src="<%=request.getContextPath()%>/images/avatars/6.jpg"
						alt="avatar-image" class="avatar-icon" id="6"></i>
				</button>
			</div>
			<div class="container mt-5 avatar-row-element">
				<button class="btn btn-primary btn-circle">
					<i class="material-icons"><img
						src="<%=request.getContextPath()%>/images/avatars/7.jpg"
						alt="avatar-image" class="avatar-icon" id="7"></i>
				</button>
			</div>
			<div class="container mt-5 avatar-row-element">
				<button class="btn btn-primary btn-circle">
					<i class="material-icons"><img
						src="<%=request.getContextPath()%>/images/avatars/8.jpg"
						alt="avatar-image" class="avatar-icon" id="8"></i>
				</button>
			</div>
		</div>
		
		<div class="avatars-row">
			<div class="container mt-5 avatar-row-element">
				<button class="btn btn-primary btn-circle">
					<i class="material-icons"><img
						src="<%=request.getContextPath()%>/images/avatars/9.jpg"
						alt="avatar-image" class="avatar-icon" id="9"></i>
				</button>
			</div>
			<div class="container mt-5 avatar-row-element">
				<button class="btn btn-primary btn-circle">
					<i class="material-icons"><img
						src="<%=request.getContextPath()%>/images/avatars/10.jpg"
						alt="avatar-image" class="avatar-icon" id="10"></i>
				</button>
			</div>
			<div class="container mt-5 avatar-row-element">
				<button class="btn btn-primary btn-circle">
					<i class="material-icons"><img
						src="<%=request.getContextPath()%>/images/avatars/11.jpg"
						alt="avatar-image" class="avatar-icon" id="11"></i>
				</button>
			</div>
			<div class="container mt-5 avatar-row-element">
				<button class="btn btn-primary btn-circle">
					<i class="material-icons"><img
						src="<%=request.getContextPath()%>/images/avatars/12.jpg"
						alt="avatar-image" class="avatar-icon" id="12"></i>
				</button>
			</div>
		</div>



	</div>
	<br>
	<div class="button-outer">
		<form action="<%=request.getContextPath()%>/admin/updateavatar" method="POST">
		   
			<input type="hidden" name="chosenAvatar" id="chosenAvatar" value="">
			 <input type="hidden" name="email" id="email" value="<%=request.getParameter("id")%>">
			<div class="continue-button">
				<button class="button-82-pushable" role="button" type="submit">
					<span class="button-82-shadow"></span> <span class="button-82-edge"></span>
					<span class="button-82-front text front1"> Change </span>
				</button>
			</div>
		</form>
	</div>
	<div>
		<footer class="footer">
			&copy;
			<script>
				document.write(new Date().getFullYear())
			</script>
			  , Friendship-driven, code-powered 💻❤️

		</footer>
	</div>
	<script>
function handleAvatarClick(event) {
	const allImages = document.querySelectorAll('.avatar-icon');
	allImages.forEach(img => img.classList.remove('active-border'));

	const clickedImage = event.target;
	if (clickedImage && clickedImage.classList.contains('avatar-icon')) {
		clickedImage.classList.add('active-border');

		
		const chosenAvatarInput = document.getElementById('chosenAvatar');
		chosenAvatarInput.value = clickedImage.id;
	}
}


const avatarImages = document.querySelectorAll('.avatar-icon');
avatarImages.forEach(img => {
	img.addEventListener('click', handleAvatarClick);
});
	</script>




</body>
</html>