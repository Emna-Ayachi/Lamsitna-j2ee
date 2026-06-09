<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Login — Lamsetna</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;800&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">

<style>
* { margin:0; padding:0; box-sizing:border-box; }

:root{
  --bg:#0c1a30;
  --card:rgba(19,36,66,0.75);
  --text:#eef2ff;
  --muted:#8AD6D6;
  --accent:#D6E264;
  --border:rgba(244,114,182,0.18);
  --radius:18px;
}

body{
  font-family:'DM Sans',sans-serif;
  background:var(--bg);
  color:var(--text);
  height:100vh;
  display:flex;
  align-items:center;
  justify-content:center;
}

.login-box{
  width:420px;
  padding:40px;
  border-radius:var(--radius);
  background:var(--card);
  border:1px solid var(--border);
  backdrop-filter:blur(20px);
  animation:fadeUp .7s ease;
}

h1{
  font-family:'Syne';
  font-size:32px;
  margin-bottom:10px;
}

p{
  color:var(--muted);
  font-size:14px;
  margin-bottom:25px;
}

label{
  font-size:13px;
  color:var(--muted);
}

input{
  width:100%;
  padding:12px;
  margin:8px 0 18px;
  border-radius:10px;
  border:1px solid var(--border);
  background:transparent;
  color:var(--text);
  outline:none;
}

input:focus{
  border-color:var(--accent);
}

button{
  width:100%;
  padding:12px;
  border:none;
  border-radius:12px;
  background:var(--accent);
  color:#132442;
  font-weight:600;
  cursor:pointer;
  transition:.2s;
}

button:hover{
  transform:translateY(-2px);
}

a{
  display:block;
  text-align:center;
  margin-top:15px;
  color:var(--muted);
  font-size:13px;
  text-decoration:none;
}

@keyframes fadeUp{
  from{opacity:0; transform:translateY(20px);}
  to{opacity:1; transform:translateY(0);}
}
</style>
</head>

<body>

<div class="login-box">
  <h1>Welcome Back</h1>
  <p>Login to continue your environmental impact</p>

  <form action="Controller" method="post">
    <label>Email</label>
    <input type="email" name="email" required>

    <label>Password</label>
    <input type="password" name="password" required>

    <button type="submit" name="myBtn" value="Login">Login</button>
  </form>

  <a href="signup.jsp">Create a new account</a>
</div>

</body>
</html>