<!DOCTYPE html>
<html>
<head>
<title>Facebook Login JavaScript Example</title>
<meta charset="UTF-8">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
	<script>
		var response1 = '';
		window.fbAsyncInit = function() {
			// FB JavaScript SDK configuration and setup
			FB.init({
				// appId      : '487213461639385', // FB App ID //1472339642852990
				appId : '1472339642852990',
				cookie : true, // enable cookies to allow the server to access the session
				xfbml : true, // parse social plugins on this page
				version : 'v2.8' // use graph api version 2.8
			});

			// Check whether the user already logged in
			FB.getLoginStatus(function(response) {
				if (response.status === 'connected') {
					//display user data
					getFbUserData();
				}
			});
		};

		// Load the JavaScript SDK asynchronously
		(function(d, s, id) {
			var js, fjs = d.getElementsByTagName(s)[0];
			if (d.getElementById(id))
				return;
			js = d.createElement(s);
			js.id = id;
			js.src = "//connect.facebook.net/en_US/sdk.js";
			fjs.parentNode.insertBefore(js, fjs);
		}(document, 'script', 'facebook-jssdk'));

		// Facebook login with JavaScript SDK
		function fbLogin() {
			FB
					.login(
							function(response) {
								if (response.authResponse) {
									// Get and display the user profile data
									console.log(response.authResponse)
									getFbUserData();
								} else {
									document.getElementById('status').innerHTML = 'User cancelled login or did not fully authorize.';
								}
							},
							{
								scope : 'email,user_likes,public_profile,user_friends,user_events,user_birthday,user_location,user_hometown,user_photos,user_posts,manage_pages,pages_show_list,read_insights,publish_pages,pages_show_list,pages_manage_instant_articles'
							});
		}

		// Fetch the user profile data from facebook
		function getFbUserData() {
			FB
					.api(
							'/me',
							{
								locale : 'en_US',
								fields : 'id,first_name,last_name,email,link,gender,locale,picture,friends,hometown,birthday,location,photos'
							},

							function(response) {
								console.log("getFbUserData", response)
								document.getElementById('facebookPost').style.display = 'block';
								document.getElementById('fbLink').setAttribute(
										"onclick", "fbLogout()");
								document.getElementById('fbLink').innerHTML = 'Logout from Facebook';
								document.getElementById('status').innerHTML = 'Thanks for logging in, '
										+ response.first_name + '!';
								document.getElementById('userData').innerHTML = '<p><b>FB ID:</b> '
										+ response.id
										+ '</p><p><b>Name:</b> '
										+ response.first_name
										+ ' '
										+ response.last_name
										+ '</p><p><b>Email:</b> '
										+ response.email
										+ '</p><p><b>Gender:</b> '
										+ response.gender
										+ '</p><p><b>Locale:</b> '
										+ response.locale
										+ '</p><p><b>Picture:</b> <img src="'+response.picture.data.url+'"/></p><p><b>Current Location:</b></p>'
										+ response.location.name
										+ '</p><p><b>HomeTown:</b>'
										+ response.hometown.name
										+ '</p><p><b>Birthday:</b>'
										+ response.birthday
										+ '</p><p><b>FB Profile:</b> <a target="_blank" href="'
        +response.link+'">click to view profile</a></p>';
							});
		}

		// post through api

		/* function post(){
		 var status=document.getElementById("Status").value;
		 var token='EAAU7Fclmpn4BACD2eZAb0KVtDcaL6Ag2ZBWxmMZBIZAEmSaZAAbkUmkrdSCPJ8VCnTl7WwSBIOEpt0GJscLZAYrwzcgoRcRUOtpQX62YPsAPxwBKbRbZAih2qbrz27aXjZBeXeUFSy1ZAN5cajLMsZATYP2hLWkcOigIp77LcamSHsEQZDZD';
		 console.log(status);
		 FB.api("/1447533955330298/accounts","GET",
		 function (response) {
		 if (response && !response.error) {
		 console.log("success",response)
		 alert('success',response);
		 }
		 }
		 )
		 };
		 */

		function getpagesDetail() {
			console.log("in getpagesDetail")
			var token = 'EAAU7Fclmpn4BACD2eZAb0KVtDcaL6Ag2ZBWxmMZBIZAEmSaZAAbkUmkrdSCPJ8VCnTl7WwSBIOEpt0GJscLZAYrwzcgoRcRUOtpQX62YPsAPxwBKbRbZAih2qbrz27aXjZBeXeUFSy1ZAN5cajLMsZATYP2hLWkcOigIp77LcamSHsEQZDZD';
			console.log(status);
			FB.api("/1447533955330298/accounts", "GET", function(response) {
				if (response && !response.error) {
					console.log("success", JSON.stringify(response))
					alert( JSON.stringify(response.data[0]));
				}
			}

			)

		}

		// Logout from facebook
		function fbLogout() {
			FB
					.logout(function() {
						document.getElementById('fbLink').setAttribute(
								"onclick", "fbLogin()");

						document.getElementById('userData').innerHTML = '';
						document.getElementById('status').innerHTML = 'You have successfully logout from Facebook.';
					});
		}
	</script>

	<a href="javascript:void(0);" onclick="fbLogin()" id="fbLink">Login
	</a>

	<div id="status"></div>
	<div id="userData"></div>

	<div id=facebookPost class="input-group input-group-lg"
		style="display: none">

		<button onclick="getpagesDetail()">User Facebook Pages</button>
	</div>
	<br>



</body>
</html>