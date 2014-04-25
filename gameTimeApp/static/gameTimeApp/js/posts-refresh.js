var req; 

function sendRequest() {
	if (window.XMLHttpRequest) {
		req = new XMLHttpRequest();
	} else {
		req = new ActiveXObject("Microsoft.XMLHTTP");
	}
	game_id = $("#game-id").attr("value");
	req.onreadystatechange = handleResponse;
	req.open("GET","/gameTime/refreshPosts/"+game_id,true);
	req.send();
}

function handleResponse() {
	// check for server status
	if ((req.readyState != 4) || (req.status != 200)) {
		return;
	}

	responseHtml = req.responseText;
	
	var div = document.createElement('div');
	div.innerHTML = responseHtml;

	dom = div;

	$(dom).find("div.post-wrapper").each(function(){
		postId = $(this).attr('id');
		
		if ($("div.post-wrapper" + "#"+postId + "[type='blogPost']").length == 0) {
			console.log("did not find " + postId);
			$("[type='blogPost']").parent().prepend($(this));

			url = "/gameTime/like/";

			$(this).find("a.like").click(function(e){
				e.preventDefault();
				if (userAuth === "False") {
					$("#login-modal").modal("show");
					return false;
				}
				var $currBtn = $(this);
				if ($currBtn.attr("flag") == 0) {
					$currBtn.css("color", "#8E2800");
					$.get(url + $currBtn.attr("pid") + "/0", function(data){
						var numberSpan = $currBtn.parent().find("span")[1];
						numberSpan.innerHTML = numberSpan.innerHTML*1+1;
						$currBtn.attr("flag",1);
						$currBtn.tooltip('hide')
								.attr('data-original-title', 'dislike it')
					});
				}
				if ($currBtn.attr("flag") == 1) {
					$currBtn.css("color", "#468966");
					$.get(url + $currBtn.attr("pid") + "/1", function(data){
						var numberSpan = $currBtn.parent().find("span")[1];
						numberSpan.innerHTML = numberSpan.innerHTML*1-1;
						$currBtn.attr("flag",0);
						$currBtn.tooltip('hide')
								.attr('data-original-title', 'like it')
					});
				}
			}); 
		}
	});
}

window.setInterval(sendRequest,2000);
