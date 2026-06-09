<%@ page import="java.util.*, entities.Problem, entities.Comment" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Posts — Lamsetna</title>

<!-- Reuse same fonts -->
<link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">

<style>

/* ===============================
   REUSED DESIGN TOKENS (from homepage)
================================= */
:root {
  --bg-deep:#0c1a30;
  --bg-card:rgba(19,36,66,0.68);
  --text-1:#eef2ff;
  --text-2:#8AD6D6;
  --text-3:#4a6a9a;
  --mustard:#D6E264;
  --pink:#F472B6;
  --border:rgba(244,114,182,0.18);
  --border-h:rgba(244,114,182,0.46);
  --radius-md:16px;
  --radius-lg:24px;
}

/* ===============================
   BASE
================================= */
body {
  font-family:'DM Sans',sans-serif;
  background:var(--bg-deep);
  color:var(--text-1);
  margin:0;
}

/* ===============================
   NAV (REUSED STRUCTURE)
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
  justify-content:space-between;
  align-items:center;
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

.nav-logo em { color:var(--mustard); font-style:normal; }

/* ===============================
   PAGE WRAP
================================= */
.page-wrap {
  max-width:1100px;
  margin:120px auto 60px;
  padding:0 20px;
}

/* ===============================
   HEADER
================================= */
.page-header {
  margin-bottom:40px;
}

.section-title {
  font-family:'Syne';
  font-size:42px;
  font-weight:800;
}

.section-desc {
  color:var(--text-2);
  margin-top:10px;
}

/* ===============================
   POSTS GRID
================================= */
.posts-grid {
  display:grid;
  gap:20px;
}

/* ===============================
   POST CARD (reusing feature-card idea)
================================= */
.post-card {
  background:var(--bg-card);
  border:1px solid var(--border);
  border-radius:var(--radius-lg);
  padding:24px;
  backdrop-filter:blur(20px);
  transition:0.3s;
}

.post-card:hover {
  transform:translateY(-4px);
  border-color:var(--border-h);
}

.post-title {
  font-family:'Syne';
  font-size:20px;
  margin-bottom:10px;
}

.post-meta {
  font-size:13px;
  color:var(--text-3);
  margin-bottom:12px;
}

.post-desc {
  color:var(--text-2);
  margin-bottom:15px;
}

.post-image {
  margin: 15px 0;
  border-radius: var(--radius-md);
  overflow: hidden;
  border: 1px solid var(--border);
}

.post-image img {
  width: 100%;
  height: 260px;
  object-fit: cover;
  display: block;
}

/* ===============================
   COMMENTS
================================= */
.comments-box {
  margin-top:20px;
  padding:15px;
  border-radius:var(--radius-md);
  border:1px solid var(--border);
  background:rgba(0,0,0,0.15);
}

.comment {
  margin-bottom:12px;
}

.comment-user {
  font-weight:600;
  font-size:13px;
}

.comment-text {
  font-size:14px;
  color:var(--text-2);
}

/* ===============================
   FORM
================================= */
.comment-form {
  display:flex;
  gap:10px;
  margin-top:12px;
}

.comment-form input[type="text"] {
  flex:1;
  padding:10px;
  border-radius:10px;
  border:1px solid var(--border);
  background:transparent;
  color:white;
}

.comment-form input[type="submit"] {
  background:var(--mustard);
  border:none;
  padding:10px 16px;
  border-radius:10px;
  font-weight:600;
  cursor:pointer;
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

<!-- NAV reused -->
<nav>
  <a href="home.jsp" class="nav-logo">Lam<em>setna</em></a>
</nav>

<div class="page-wrap">

    <!-- HEADER -->
    <div class="page-header">
        <a href="home.jsp" class="back-link"> Back</a>

        <h1 class="section-title">All Posts</h1>
        <p class="section-desc">Community-reported environmental issues</p>
    </div>

    <div class="posts-grid">

<%
    List<Problem> posts = (List<Problem>) request.getAttribute("posts");

    if (posts != null) {
        for (Problem p : posts) {
%>

        <!-- ===============================
             POST CARD (STRUCTURAL CHANGE)
             Converted from plain div → styled card
        =============================== -->
        <div class="post-card">

            <div class="post-title"><%= p.getTitre() %></div>

            <div class="post-meta">
                Category: <%= p.getCategorie() %> • Votes: <%= p.getVotes() %>
            </div>

            <div class="post-desc">
                <%= p.getDescription() %>
            </div>
            <% if (p.getImageUrl() != null && !p.getImageUrl().isEmpty()) { %>
			    <div class="post-image">
			        <img src="<%= request.getContextPath() + "/" + p.getImageUrl() %>">
			    </div>
			<% } %>

            <!-- COMMENTS -->
            <div class="comments-box">

                <h4>Comments</h4>

                <%
                    if (p.getComments() != null) {
                        for (Comment c : p.getComments()) {
                %>

                <div class="comment">
                    <div class="comment-user">
                        <%= c.getUser().getPrenom() %> <%= c.getUser().getNom() %>
                    </div>
                    <div class="comment-text">
                        <%= c.getContenu() %>
                    </div>
                </div>

                <%
                        }
                    }
                %>

                <!-- ===============================
                     FORM (styled, logic unchanged)
                =============================== -->
                <form action="Controller" method="post" class="comment-form">
                    <input type="hidden" name="problemId" value="<%= p.getId() %>">

                    <input type="text" name="contenu" placeholder="Write a comment..." required>

                    <input type="submit" name="myBtn" value="AddComment">
                </form>

            </div>

        </div>

<%
        }
    }
%>

    </div>
</div>

</body>
</html>