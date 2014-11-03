var post = document.getElementsByClassName("post")[0];
var body = document.getElementsByTagName("body")[0];
body.style.background = '#ffffff';
post.style.background = '#ffffff';
post.style.float = "left";
post.style.width = "90%"
post.style.font = "20px Helvetica";
body.removeChild(body.children[0]);
body.appendChild(post);


