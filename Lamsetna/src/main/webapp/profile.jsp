<%@ page import="entities.User" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Profile — Lamsetna</title>

<link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">

<style>

/* ===============================
   DESIGN TOKENS (REUSED)
================================= */
:root {
  --bg-deep:#0c1a30;
  --bg-card:rgba(19,36,66,0.68);
  --text-1:#eef2ff;
  --text-2:#8AD6D6;
  --text-3:#4a6a9a;
  --mustard:#D6E264;
  --purple:#80A1F8;
  --border:rgba(244,114,182,0.18);
  --border-h:rgba(244,114,182,0.46);
  --radius-md:16px;
  --radius-lg:24px;
}

/* ===============================
   BASE
================================= */
body {
  margin:0;
  font-family:'DM Sans',sans-serif;
  background:var(--bg-deep);
  color:var(--text-1);
}

/* ===============================
   NAV
================================= */
nav {
  position:fixed;
  top:18px;
  left:50%;
  transform:translateX(-50%);
  width:calc(100% - 48px);
  max-width:1100px;
  height:60px;
  display:flex;
  align-items:center;
  justify-content:space-between;
  padding:0 20px;
  background:rgba(10,22,46,0.85);
  border:1px solid var(--border);
  border-radius:36px;
}

.nav-logo {
  font-family:'Syne';
  font-weight:800;
  color:white;
  text-decoration:none;
}

.nav-logo em {
  color:var(--mustard);
  font-style:normal;
}

/* ===============================
   PAGE WRAP
================================= */
.page-wrap {
  max-width:900px;
  margin:120px auto 60px;
  padding:0 20px;
}

/* ===============================
   BACK LINK
================================= */
.back-link {
  display:inline-block;
  margin-bottom:20px;
  color:var(--mustard);
  text-decoration:none;
}

/* ===============================
   HEADER
================================= */
.section-title {
  font-family:'Syne';
  font-size:40px;
  font-weight:800;
  margin-bottom:30px;
}

/* ===============================
   PROFILE CARD
================================= */
.profile-card {
  background:var(--bg-card);
  border:1px solid var(--border);
  border-radius:var(--radius-lg);
  padding:30px;
  backdrop-filter:blur(20px);
  transition:0.3s;
}

.profile-card:hover {
  border-color:var(--border-h);
  transform:translateY(-4px);
}

/* ===============================
   PROFILE INFO
================================= */
.profile-row {
  display:flex;
  justify-content:space-between;
  padding:12px 0;
  border-bottom:1px solid var(--border);
}

.profile-row:last-child {
  border-bottom:none;
}

.profile-label {
  color:var(--text-3);
  font-size:13px;
}

.profile-value {
  font-weight:500;
}

/* ===============================
   POINTS BADGE
================================= */
.points-badge {
  display:inline-block;
  margin-top:20px;
  padding:10px 18px;
  border-radius:999px;
  background:rgba(214,226,100,0.1);
  border:1px solid rgba(214,226,100,0.3);
  color:var(--mustard);
  font-weight:600;
}

/* ===============================
   RESPONSIVE
================================= */
@media(max-width:600px){
  .profile-row {
    flex-direction:column;
    gap:4px;
  }
}

</style>
</head>

<body>

<!-- NAV -->
<nav>
  <a href="home.jsp" class="nav-logo">Lam<em>setna</em></a>
</nav>

<div class="page-wrap">

    <!-- BACK -->
    <a href="home.jsp" class="back-link"> Back</a>

<%
    User user = (User) request.getAttribute("user");
%>

    <!-- HEADER -->
    <h1 class="section-title">User Profile</h1>

    <!-- ===============================
         PROFILE CARD (MAJOR UPGRADE)
    =============================== -->
    <div class="profile-card">

        <div class="profile-row">
            <span class="profile-label">First Name</span>
            <span class="profile-value"><%= user.getPrenom() %></span>
        </div>

        <div class="profile-row">
            <span class="profile-label">Last Name</span>
            <span class="profile-value"><%= user.getNom() %></span>
        </div>

        <div class="profile-row">
            <span class="profile-label">Email</span>
            <span class="profile-value"><%= user.getEmail() %></span>
        </div>

        <div class="profile-row">
            <span class="profile-label">Role</span>
            <span class="profile-value"><%= user.getRole() %></span>
        </div>

        <!-- Highlighted Points -->
        <div class="points-badge">
            Points: <%= user.getPoints() %>
        </div>

    </div>

</div>

</body>
</html>