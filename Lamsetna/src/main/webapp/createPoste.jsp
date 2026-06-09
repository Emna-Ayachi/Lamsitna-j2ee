<%@ page import="entities.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Create Post — Lamsetna</title>

<link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">

<style>

/* ===============================
   DESIGN TOKENS
================================= */
:root {
  --bg-deep:#0c1a30;
  --bg-card:rgba(19,36,66,0.68);
  --text-1:#eef2ff;
  --text-2:#8AD6D6;
  --text-3:#4a6a9a;
  --mustard:#D6E264;
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
   PAGE
================================= */
.page-wrap {
  max-width:700px;
  margin:120px auto 60px;
  padding:0 20px;
}

/* ===============================
   HEADER
================================= */
.section-title {
  font-family:'Syne';
  font-size:36px;
  font-weight:800;
  margin-bottom:10px;
}

.section-desc {
  color:var(--text-2);
  margin-bottom:30px;
}

/* ===============================
   FORM CARD
================================= */
.form-card {
  background:var(--bg-card);
  border:1px solid var(--border);
  border-radius:var(--radius-lg);
  padding:30px;
  backdrop-filter:blur(20px);
}

/* ===============================
   INPUTS
================================= */
.form-group {
  margin-bottom:18px;
}

.form-group label {
  display:block;
  font-size:13px;
  color:var(--text-3);
  margin-bottom:6px;
}

.form-group input,
.form-group select {
  width:100%;
  padding:12px;
  border-radius:10px;
  border:1px solid var(--border);
  background:transparent;
  color:var(--text-1);
}

/* ===============================
   BUTTON
================================= */
.btn-primary {
  width:100%;
  margin-top:10px;
  background:var(--mustard);
  color:#132442;
  border:none;
  padding:12px;
  border-radius:10px;
  font-weight:600;
  cursor:pointer;
}

.btn-primary:hover {
  background:#e4ef6e;
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

</style>
</head>

<body>

<!-- NAV -->
<nav>
  <a href="home.jsp" class="nav-logo">Lam<em>setna</em></a>
</nav>

<div class="page-wrap">

    <h1 class="section-title">Create Post</h1>
    <p class="section-desc">What environmental problem has been bothering you?</p>

    <!-- ===============================
         FORM (LOGIC KEPT EXACT)
    =============================== -->
    <div class="form-card">

        <form action="Controller" method="post" enctype="multipart/form-data">

            <div class="form-group">
                <label>Title</label>
                <input type="text" name="titre" required>
            </div>

            <div class="form-group">
                <label>Description</label>
                <input type="text" name="description" required>
            </div>

            <div class="form-group">
                <label>Image URL</label>
                <input type="file" name="image" accept="image/*">
            </div>

            <div class="form-group">
                <label>Status</label>
                <input type="text" name="statut">
            </div>

            <div class="form-group">
                <label>Location</label>
                <input type="text" name="localisation" required>
            </div>

            <div class="form-group">
                <label>Category</label>
                <select name="categorie">
                    <option value="air-pollution">Air pollution</option>
                    <option value="water-pollution">Water pollution</option>
                    <option value="waste-and-illegal-dumping">Waste and illegal dumping</option>
                    <option value="noise-and-vibration">Noise and vibration</option>
                    <option value="biodiversity-and-green-spaces">Biodiversity and green spaces</option>
                    <option value="climate-and-weather-related--issues">Climate and weather-related issues</option>
                </select>
            </div>

            <input type="submit" name="myBtn" value="CreatePost" class="btn-primary">

        </form>

    </div>

</div>

</body>
</html>