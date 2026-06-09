<%@ page import="java.util.List" %>
<%@ page import="entities.Event" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Events — Lamsetna</title>

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
  --sea:#8AD6D6;
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
   NAV (CONSISTENT)
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
   PAGE LAYOUT
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
  margin-top:10px;
  color:var(--text-2);
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
   GRID
================================= */
.events-grid {
  display:grid;
  gap:20px;
}

/* ===============================
   EVENT CARD (feature-card style)
================================= */
.event-card {
  background:var(--bg-card);
  border:1px solid var(--border);
  border-radius:var(--radius-lg);
  padding:24px;
  backdrop-filter:blur(20px);
  transition:0.3s;
}

.event-card:hover {
  transform:translateY(-4px);
  border-color:var(--border-h);
}

/* ===============================
   CONTENT
================================= */
.event-title {
  font-family:'Syne';
  font-size:20px;
  margin-bottom:10px;
}

.event-desc {
  color:var(--text-2);
  margin-bottom:15px;
}

/* META INFO */
.event-meta {
  font-size:14px;
  color:var(--text-3);
  display:flex;
  flex-wrap:wrap;
  gap:15px;
  margin-bottom:15px;
}

/* PARTICIPANTS BAR STYLE */
.participants {
  font-size:13px;
  color:var(--sea);
  margin-bottom:15px;
}

/* ===============================
   BUTTON
================================= */
.btn-primary {
  background:var(--mustard);
  color:#132442;
  border:none;
  padding:10px 16px;
  border-radius:10px;
  font-weight:600;
  cursor:pointer;
}

.btn-primary:hover {
  background:#e4ef6e;
}

/* ===============================
   RESPONSIVE
================================= */
@media(max-width:600px){
  .section-title { font-size:30px; }
}

</style>
</head>

<body>

<!-- NAV -->
<nav>
  <a href="home.jsp" class="nav-logo">Lam<em>setna</em></a>
</nav>

<div class="page-wrap">

    <!-- HEADER -->
    <div class="page-header">
        <a href="home.jsp" class="back-link"> Back</a>

        <h1 class="section-title">Events</h1>
        <p class="section-desc">Join environmental actions happening around you</p>
    </div>

    <div class="events-grid">

<%
    List<Event> events = (List<Event>) request.getAttribute("events");
    entities.User activeUser = (entities.User) session.getAttribute("activeUser");

    if (events != null) {
        for (Event e : events) {

            int currentParticipants = e.getEventParticipants() != null 
                ? e.getEventParticipants().size() 
                : 0;
%>

        <!-- ===============================
             EVENT CARD (STRUCTURAL UPGRADE)
        =============================== -->
        <div class="event-card">

            <div class="event-title">
                <%= e.getTitre() %>
            </div>

            <div class="event-desc">
                <%= e.getDescription() %>
            </div>

            <!-- META -->
            <div class="event-meta">
                <span><b>Lieu:</b> <%= e.getLieu() %></span>
                <span><b>Date:</b> <%= e.getDateEvent() %></span>
            </div>

            <!-- PARTICIPANTS -->
            <div class="participants">
                Participants: <%= currentParticipants %> / <%= e.getMaxParticipants() %>
            </div>

            <%
                // LOGIC PRESERVED EXACTLY
                if (activeUser != null 
                    && e.getUser() != null 
                    && activeUser.getId() != e.getUser().getId()
                    && currentParticipants < e.getMaxParticipants()) {
            %>

            <!-- JOIN BUTTON (styled) -->
            <form action="Controller" method="post">
                <input type="hidden" name="eventId" value="<%= e.getId() %>">

                <input type="submit" name="myBtn" value="JoinEvent" class="btn-primary">
            </form>

            <%
                }
            %>

        </div>

<%
        }
    }
%>

    </div>
</div>

</body>
</html>