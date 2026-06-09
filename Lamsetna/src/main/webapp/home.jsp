<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Lamsetna — Environmental Action Platform</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;500;600;700;800&family=DM+Sans:ital,opsz,wght@0,9..40,300;0,9..40,400;0,9..40,500;1,9..40,300&display=swap" rel="stylesheet">

<style>
  *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

  :root {
    --blueberry:  #132442;
    --knot-navy:  #3551A4;
    --sea-salt:   #8AD6D6;
    --mustard:    #D6E264;
    --purple:     #80A1F8;
    --pink:       #F472B6;

    --bg-deep:    #0c1a30;
    --bg-mid:     #132442;
    --bg-card:    rgba(19, 36, 66, 0.68);

    --accent:     #D6E264;
    --accent-glow:rgba(214, 226, 100, 0.22);

    --text-1:     #eef2ff;
    --text-2:     #8AD6D6;
    --text-3:     #4a6a9a;

    --border:        rgba(244, 114, 182, 0.18);
    --border-h:      rgba(244, 114, 182, 0.46);
    --border-subtle: rgba(244, 114, 182, 0.08);

    --radius-sm:  10px;
    --radius-md:  16px;
    --radius-lg:  24px;
    --radius-xl:  36px;
  }

  html { scroll-behavior: smooth; }

  body {
    font-family: 'DM Sans', sans-serif;
    background-color: var(--bg-deep);
    color: var(--text-1);
    min-height: 100vh;
    overflow-x: hidden;
  }

  #bg-canvas {
    position: fixed; inset: 0;
    z-index: 0; pointer-events: none;
  }

  /* NAV */
  nav {
    position: fixed; top: 18px; left: 50%;
    transform: translateX(-50%);
    z-index: 100;
    width: calc(100% - 48px); max-width: 1100px;
    display: flex; align-items: center; justify-content: space-between;
    padding: 0 24px; height: 62px;
    background: rgba(10, 22, 46, 0.82);
    backdrop-filter: blur(22px) saturate(160%);
    -webkit-backdrop-filter: blur(22px) saturate(160%);
    border: 1px solid var(--border);
    border-radius: var(--radius-xl);
    animation: slideDown 0.7s cubic-bezier(0.16,1,0.3,1) both;
  }
  @keyframes slideDown {
    from { opacity:0; transform:translateX(-50%) translateY(-20px); }
    to   { opacity:1; transform:translateX(-50%) translateY(0); }
  }

  .nav-logo { display:flex; align-items:center; gap:10px; text-decoration:none; }
  .nav-logo-icon {
    width:34px; height:34px; background:var(--mustard);
    border-radius:10px; display:flex; align-items:center; justify-content:center;
  }
  .nav-logo-icon svg { width:18px; height:18px; }
  .nav-logo-text {
    font-family:'Syne',sans-serif; font-weight:800; font-size:18px;
    color:var(--text-1); letter-spacing:-0.3px;
  }
  .nav-logo-text em { color:var(--mustard); font-style:normal; }

  nav ul { list-style:none; display:flex; align-items:center; gap:2px; }
  nav ul li a {
    display:flex; align-items:center; gap:7px;
    text-decoration:none; color:var(--text-2);
    font-size:14px; font-weight:400;
    padding:8px 15px; border-radius:var(--radius-sm);
    border:1px solid transparent; transition:all 0.22s ease; white-space:nowrap;
  }
  nav ul li a:hover {
    color:var(--text-1);
    background:rgba(128,161,248,0.09);
    border-color:rgba(128,161,248,0.22);
  }
  .nav-dot {
    width:5px; height:5px; border-radius:50%;
    background:var(--text-3); transition:background 0.22s; flex-shrink:0;
  }
  nav ul li a:hover .nav-dot { background:var(--purple); }
  .nav-cta {
    background:var(--mustard) !important; color:var(--blueberry) !important;
    font-weight:600 !important; border:none !important;
  }
  .nav-cta:hover { background:#e4ef6e !important; color:var(--blueberry) !important; }
  .nav-cta .nav-dot { display:none; }

  .page-wrap { position:relative; z-index:1; }

  /* HERO */
  .hero {
    min-height:100vh; display:flex; flex-direction:column;
    align-items:center; justify-content:center;
    text-align:center; padding:120px 24px 80px;
    position:relative; overflow:hidden;
  }
  .blob {
    position:absolute; border-radius:50%;
    pointer-events:none; filter:blur(90px); opacity:0.07;
  }

  .hero-eyebrow {
    display:inline-flex; align-items:center; gap:9px;
    background:rgba(214,226,100,0.09);
    border:1px solid rgba(214,226,100,0.28);
    border-radius:100px; padding:6px 18px 6px 10px;
    font-size:11px; font-weight:500; color:var(--mustard);
    letter-spacing:1px; text-transform:uppercase; margin-bottom:36px;
    animation:fadeUp 0.8s 0.2s cubic-bezier(0.16,1,0.3,1) both;
  }
  .eyebrow-dot {
    width:8px; height:8px; border-radius:50%; background:var(--mustard);
    animation:pulse 2s ease-in-out infinite;
  }
  @keyframes pulse { 0%,100%{opacity:1;transform:scale(1);} 50%{opacity:0.45;transform:scale(0.7);} }

  .hero-title {
    font-family:'Syne',sans-serif;
    font-size:clamp(46px,7.5vw,92px); font-weight:800;
    line-height:1.0; letter-spacing:-2.5px; color:var(--text-1);
    max-width:860px; margin-bottom:28px;
    animation:fadeUp 0.8s 0.35s cubic-bezier(0.16,1,0.3,1) both;
  }
  .hero-title .c-mustard { color:var(--mustard); }
  .hero-title .outline {
    -webkit-text-stroke:2px rgba(244,114,182,0.4); color:transparent;
  }

  .hero-sub {
    font-size:18px; font-weight:300; color:var(--text-2);
    max-width:520px; line-height:1.75; margin-bottom:48px;
    animation:fadeUp 0.8s 0.5s cubic-bezier(0.16,1,0.3,1) both;
  }

  .hero-actions {
    display:flex; gap:14px; flex-wrap:wrap; justify-content:center;
    animation:fadeUp 0.8s 0.65s cubic-bezier(0.16,1,0.3,1) both;
  }

  .btn-primary {
    display:inline-flex; align-items:center; gap:10px;
    background:var(--mustard); color:var(--blueberry);
    padding:14px 28px; border-radius:var(--radius-sm);
    font-family:'DM Sans',sans-serif; font-size:15px; font-weight:600;
    text-decoration:none; border:none; cursor:pointer;
    transition:all 0.22s ease; letter-spacing:-0.1px;
  }
  .btn-primary:hover { background:#e4ef6e; transform:translateY(-2px); }
  .btn-primary svg { width:16px; height:16px; }

  .btn-ghost {
    display:inline-flex; align-items:center; gap:10px;
    background:transparent; color:var(--text-2);
    padding:14px 28px; border-radius:var(--radius-sm);
    font-family:'DM Sans',sans-serif; font-size:15px; font-weight:400;
    text-decoration:none; border:1px solid var(--border);
    cursor:pointer; transition:all 0.22s ease;
  }
  .btn-ghost:hover {
    color:var(--text-1); border-color:var(--border-h);
    background:rgba(244,114,182,0.06); transform:translateY(-2px);
  }

  /* STATS */
  .stats-strip {
    display:flex; align-items:center; gap:0; margin-top:72px;
    border:1px solid var(--border); border-radius:var(--radius-lg);
    overflow:hidden; max-width:680px; width:100%;
    animation:fadeUp 0.8s 0.8s cubic-bezier(0.16,1,0.3,1) both;
  }
  .stat-item {
    flex:1; padding:22px 20px; text-align:center;
    background:var(--bg-card); backdrop-filter:blur(20px);
    border-right:1px solid var(--border);
  }
  .stat-item:last-child { border-right:none; }
  .stat-num {
    font-family:'Syne',sans-serif; font-size:28px; font-weight:700;
    color:var(--text-1); display:block;
  }
  .stat-num .hi { color:var(--mustard); }
  .stat-label {
    font-size:11px; color:var(--text-3); text-transform:uppercase;
    letter-spacing:1px; font-weight:400; display:block; margin-top:4px;
  }

  @keyframes fadeUp {
    from { opacity:0; transform:translateY(24px); }
    to   { opacity:1; transform:translateY(0); }
  }

  /* SECTIONS */
  section { padding:100px 24px; max-width:1100px; margin:0 auto; }

  .section-label {
    display:inline-flex; align-items:center; gap:10px;
    font-size:11px; text-transform:uppercase; letter-spacing:1.6px;
    color:var(--pink); font-weight:500; margin-bottom:18px;
  }
  .section-label::before {
    content:''; display:block; width:22px; height:1px; background:var(--pink);
  }

  .section-title {
    font-family:'Syne',sans-serif;
    font-size:clamp(32px,4vw,52px); font-weight:800;
    letter-spacing:-1.5px; line-height:1.08;
    color:var(--text-1); margin-bottom:16px;
  }
  .section-desc {
    font-size:16px; font-weight:300; color:var(--text-2);
    line-height:1.75; max-width:480px; margin-bottom:52px;
  }

  /* CARDS */
  .cards-grid {
    display:grid;
    grid-template-columns:repeat(auto-fit, minmax(240px,1fr));
    gap:14px;
  }

  .feature-card {
    background:var(--bg-card); border:1px solid var(--border);
    border-radius:var(--radius-lg); padding:30px 26px;
    backdrop-filter:blur(24px); -webkit-backdrop-filter:blur(24px);
    position:relative; overflow:hidden;
    cursor:pointer; text-decoration:none; display:block;
    transition:all 0.32s cubic-bezier(0.16,1,0.3,1);
    animation:fadeUp 0.7s both;
  }
  .feature-card:nth-child(1){ animation-delay:0.1s; }
  .feature-card:nth-child(2){ animation-delay:0.2s; }
  .feature-card:nth-child(3){ animation-delay:0.3s; }
  .feature-card:nth-child(4){ animation-delay:0.4s; }

  /* top stripe */
  .feature-card::before {
    content:''; position:absolute; top:0; left:18px; right:18px; height:2px;
    background:var(--card-stripe, var(--mustard));
    border-radius:0 0 4px 4px; opacity:0.65;
    transition:opacity 0.3s, left 0.3s, right 0.3s;
  }
  /* hover glow */
  .feature-card::after {
    content:''; position:absolute; inset:0;
    background:radial-gradient(circle at 50% -10%, var(--card-glow, rgba(214,226,100,0.06)) 0%, transparent 60%);
    opacity:0; transition:opacity 0.32s ease; pointer-events:none;
  }
  .feature-card:hover { border-color:var(--border-h); transform:translateY(-6px); }
  .feature-card:hover::before { opacity:1; left:10px; right:10px; }
  .feature-card:hover::after { opacity:1; }

  .card-icon-wrap {
    width:50px; height:50px; border-radius:var(--radius-sm);
    background:var(--icon-bg, rgba(214,226,100,0.1));
    border:1px solid var(--icon-border, rgba(214,226,100,0.22));
    display:flex; align-items:center; justify-content:center;
    margin-bottom:22px; transition:transform 0.3s ease;
  }
  .feature-card:hover .card-icon-wrap { transform:scale(1.1) rotate(-3deg); }
  .card-icon-wrap svg { width:22px; height:22px; }

  .card-number {
    position:absolute; top:24px; right:24px;
    font-family:'Syne',sans-serif; font-size:52px; font-weight:800;
    color:rgba(238,242,255,0.027); line-height:1;
    user-select:none; pointer-events:none;
  }
  .card-title {
    font-family:'Syne',sans-serif; font-size:19px; font-weight:700;
    color:var(--text-1); margin-bottom:10px; letter-spacing:-0.3px;
  }
  .card-desc {
    font-size:14px; font-weight:300; color:var(--text-2);
    line-height:1.7; margin-bottom:22px;
  }
  .card-link {
    display:inline-flex; align-items:center; gap:6px;
    font-size:13px; font-weight:500;
    color:var(--link-color, var(--mustard));
    text-decoration:none; transition:gap 0.2s ease;
  }
  .feature-card:hover .card-link { gap:10px; }
  .card-link svg { width:13px; height:13px; }

  /* HOW IT WORKS */
  .steps-container {
    display:grid; grid-template-columns:1fr 1fr;
    gap:56px; align-items:center;
  }
  @media(max-width:720px){ .steps-container{ grid-template-columns:1fr; } }

  .steps-visual {
    height:420px; border:1px solid var(--border); border-radius:var(--radius-lg);
    background:var(--bg-card); backdrop-filter:blur(24px);
    overflow:hidden; display:flex; align-items:center; justify-content:center;
    position:relative;
  }
  .steps-visual::before, .steps-visual::after {
    content:''; position:absolute; width:56px; height:56px;
    border-style:solid; border-color:var(--pink); opacity:0.28;
  }
  .steps-visual::before {
    top:14px; left:14px;
    border-width:1px 0 0 1px; border-radius:4px 0 0 0;
  }
  .steps-visual::after {
    bottom:14px; right:14px;
    border-width:0 1px 1px 0; border-radius:0 0 4px 0;
  }

  .steps-visual-inner { position:relative; width:200px; height:200px; }
  .orbit-ring {
    position:absolute; border-radius:50%;
    border:1px dashed rgba(244,114,182,0.17);
    top:50%; left:50%; transform:translate(-50%,-50%);
  }
  .orbit-ring.r1 { width:100%; height:100%; }
  .orbit-ring.r2 { width:150%; height:150%; border-color:rgba(128,161,248,0.13); }
  .orbit-ring.r3 { width:210%; height:210%; border-color:rgba(138,214,214,0.09); }

  .orbit-center {
    position:absolute; top:50%; left:50%;
    transform:translate(-50%,-50%);
    width:66px; height:66px; background:var(--mustard); border-radius:20px;
    display:flex; align-items:center; justify-content:center;
    box-shadow:0 0 48px var(--accent-glow), 0 0 0 1px rgba(214,226,100,0.35);
  }
  .orbit-center svg { width:28px; height:28px; }

  .orbit-dot {
    position:absolute; width:38px; height:38px; border-radius:11px;
    background:var(--bg-mid); border:1px solid var(--border);
    display:flex; align-items:center; justify-content:center;
    top:50%; left:50%;
  }
  .orbit-dot svg { width:16px; height:16px; }
  .od1 { transform:translate(-50%,-50%) translateX(100px) translateY(-100px); border-color:rgba(214,226,100,0.3); }
  .od2 { transform:translate(-50%,-50%) translateX(130px) translateY(40px);   border-color:rgba(138,214,214,0.3); }
  .od3 { transform:translate(-50%,-50%) translateX(-110px) translateY(90px);  border-color:rgba(128,161,248,0.3); }
  .od4 { transform:translate(-50%,-50%) translateX(-80px) translateY(-120px); border-color:rgba(244,114,182,0.3); }

  .steps-list { list-style:none; display:flex; flex-direction:column; gap:26px; }
  .step-item { display:flex; gap:18px; align-items:flex-start; }
  .step-num {
    width:36px; height:36px; flex-shrink:0; border-radius:10px;
    background:rgba(244,114,182,0.08); border:1px solid rgba(244,114,182,0.22);
    display:flex; align-items:center; justify-content:center;
    font-family:'Syne',sans-serif; font-size:12px; font-weight:700; color:var(--pink);
  }
  .step-text h4 {
    font-family:'Syne',sans-serif; font-size:15px; font-weight:700;
    color:var(--text-1); margin-bottom:4px; letter-spacing:-0.2px;
  }
  .step-text p { font-size:14px; font-weight:300; color:var(--text-2); line-height:1.65; }

  /* BADGES */
  .badges-row { display:flex; gap:14px; flex-wrap:wrap; margin-top:44px; }
  .badge-pill {
    display:inline-flex; align-items:center; gap:10px;
    padding:10px 18px; border-radius:100px;
    border:1px solid var(--b-border, var(--border));
    background:var(--b-bg, rgba(19,36,66,0.7));
    backdrop-filter:blur(12px); font-size:14px; font-weight:500;
    color:var(--b-text, var(--mustard)); transition:all 0.22s ease; cursor:default;
  }
  .badge-pill:hover { transform:translateY(-3px); border-color:var(--b-border-h, var(--border-h)); }
  .badge-icon {
    width:24px; height:24px; border-radius:7px;
    background:var(--b-icon-bg, rgba(214,226,100,0.14));
    display:flex; align-items:center; justify-content:center;
  }
  .badge-icon svg { width:12px; height:12px; }

  .badge-pill.b-sea {
    --b-bg:rgba(138,214,214,0.07); --b-border:rgba(138,214,214,0.22);
    --b-border-h:rgba(138,214,214,0.46); --b-text:#8AD6D6; --b-icon-bg:rgba(138,214,214,0.14);
  }
  .badge-pill.b-purple {
    --b-bg:rgba(128,161,248,0.07); --b-border:rgba(128,161,248,0.22);
    --b-border-h:rgba(128,161,248,0.44); --b-text:#80A1F8; --b-icon-bg:rgba(128,161,248,0.14);
  }
  .badge-pill.b-pink {
    --b-bg:rgba(244,114,182,0.07); --b-border:rgba(244,114,182,0.22);
    --b-border-h:rgba(244,114,182,0.44); --b-text:#F472B6; --b-icon-bg:rgba(244,114,182,0.14);
  }
  .badge-pill.b-navy {
    --b-bg:rgba(53,81,164,0.18); --b-border:rgba(53,81,164,0.38);
    --b-border-h:rgba(53,81,164,0.6); --b-text:#a0b4ff; --b-icon-bg:rgba(53,81,164,0.25);
  }

  /* CTA BANNER */
  .cta-banner {
    max-width:1100px; margin:0 auto 100px;
    background:var(--bg-card); border:1px solid var(--border);
    border-radius:var(--radius-xl); padding:64px; text-align:center;
    backdrop-filter:blur(24px); position:relative; overflow:hidden;
  }
  .cta-banner::before {
    content:''; position:absolute; top:-80px; left:50%; transform:translateX(-50%);
    width:340px; height:220px;
    background:radial-gradient(ellipse, rgba(214,226,100,0.10) 0%, transparent 70%);
    pointer-events:none;
  }
  .cta-banner h2 {
    font-family:'Syne',sans-serif; font-size:clamp(28px,3.5vw,46px);
    font-weight:800; letter-spacing:-1.2px; margin-bottom:16px;
    color:var(--text-1); position:relative; z-index:1;
  }
  .cta-banner p {
    font-size:16px; font-weight:300; color:var(--text-2);
    margin-bottom:36px; line-height:1.7; position:relative; z-index:1;
  }
  .cta-actions {
    display:flex; gap:16px; justify-content:center;
    flex-wrap:wrap; position:relative; z-index:1;
  }

  /* FOOTER */
  footer {
    border-top:1px solid var(--border); padding:32px 48px;
    display:flex; align-items:center; justify-content:space-between;
    max-width:1100px; margin:0 auto; flex-wrap:wrap; gap:16px;
  }
  .footer-logo {
    font-family:'Syne',sans-serif; font-weight:800;
    font-size:16px; color:var(--text-2);
  }
  .footer-logo em { color:var(--mustard); font-style:normal; }
  .footer-links { display:flex; gap:24px; list-style:none; }
  .footer-links a {
    font-size:13px; font-weight:300; color:var(--text-3);
    text-decoration:none; transition:color 0.2s;
  }
  .footer-links a:hover { color:var(--sea-salt); }
  .footer-copy { font-size:12px; color:var(--text-3); font-weight:300; }

  /* REVEAL */
  .reveal {
    opacity:0; transform:translateY(28px);
    transition:opacity 0.7s ease, transform 0.7s cubic-bezier(0.16,1,0.3,1);
  }
  .reveal.visible { opacity:1; transform:translateY(0); }
  
  #msgInput {
    width: 72%;
    padding: 10px;
    border-radius: 10px;
    border: 1px solid rgba(138,214,214,0.25);
    background: rgba(12,26,48,0.6);
    color: #eef2ff;
    outline: none;
}
#chatBox {
    position: fixed;
    bottom: 24px;
    right: 24px;
    width: 340px;
    background: rgba(19, 36, 66, 0.75);
    backdrop-filter: blur(20px);
    border: 1px solid rgba(244,114,182,0.2);
    border-radius: 16px;
    padding: 14px;
    box-shadow: 0 10px 40px rgba(0,0,0,0.35);
    z-index: 999;
}
#chatBox button {
    width: 26%;
    padding: 10px;
    margin-left: 6px;
    border-radius: 10px;
    border: none;
    background: #D6E264;
    color: #132442;
    font-weight: 600;
    cursor: pointer;
}

#chatBox button:hover {
    background: #e4ef6e;
}
</style>
</head>
<body>

<canvas id="bg-canvas"></canvas>

<nav>
  <a href="#" class="nav-logo">
    <div class="nav-logo-icon">
      <svg viewBox="0 0 24 24" fill="none">
        <path d="M5 20s1-7 7-10c4-2 8-1 9-1s0 5-3 8c-3.5 3.5-8 4-13 3z" fill="#132442"/>
        <path d="M5 20c3-3 6-5 9-8" stroke="#132442" stroke-width="1.5" stroke-linecap="round"/>
      </svg>
    </div>
    <span class="nav-logo-text">Lam<em>setna</em></span>
  </a>
  <ul>
    <li><a href="posts"><span class="nav-dot"></span>Posts</a></li>
    <li><a href="events"><span class="nav-dot"></span>Events</a></li>
    <li><a href="badges.html"><span class="nav-dot"></span>Badges</a></li>
    <li><a href="profile"><span class="nav-dot"></span>Profile</a></li>
    <li><a href="createEvent" class="nav-cta">Report Issue</a></li>
  </ul>
</nav>

<div class="page-wrap">

  <!-- HERO -->
  <div class="hero">
    <div class="blob" style="width:520px;height:520px;background:var(--pink);top:-120px;left:-180px;"></div>
    <div class="blob" style="width:420px;height:420px;background:var(--mustard);bottom:-60px;right:-120px;"></div>
    <div class="blob" style="width:300px;height:300px;background:var(--purple);top:30%;right:5%;"></div>

    <div class="hero-eyebrow">
      <span class="eyebrow-dot"></span>
      Citizen-Powered Environmental Action
    </div>

    <h1 class="hero-title">
      Your voice <span class="c-mustard">protects</span><br>
      our <span class="outline">planet</span>
    </h1>

    <p class="hero-sub">
      Report environmental issues in your community, organize events to fix them, and earn recognition for your real-world impact.
    </p>

    <div class="hero-actions">
      <a href="createPoste" class="btn-primary">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2">
          <circle cx="12" cy="12" r="10"/>
          <line x1="12" y1="8" x2="12" y2="12"/>
          <line x1="12" y1="16" x2="12.01" y2="16"/>
        </svg>
        Report a Problem
      </a>
      <a href="events" class="btn-ghost">
        Explore Events
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="width:14px;height:14px">
          <path d="M5 12h14M12 5l7 7-7 7"/>
        </svg>
      </a>
    </div>

    <div class="stats-strip">
      <div class="stat-item">
        <span class="stat-num">2<span class="hi">K+</span></span>
        <span class="stat-label">Issues Reported</span>
      </div>
      <div class="stat-item">
        <span class="stat-num">380<span class="hi">+</span></span>
        <span class="stat-label">Events Hosted</span>
      </div>
      <div class="stat-item">
        <span class="stat-num">14<span class="hi">K</span></span>
        <span class="stat-label">Active Citizens</span>
      </div>
    </div>
  </div>

  <!-- FEATURES -->
  <section>
    <p class="section-label reveal">What You Can Do</p>
    <h2 class="section-title reveal">Act, organize,<br>and get recognized</h2>
    <p class="section-desc reveal">Four simple actions that create real environmental change in your community.</p>

    <div class="cards-grid">
      <a href="createPoste" class="feature-card"
         style="--card-stripe:var(--mustard);--card-glow:rgba(214,226,100,0.07);
                --icon-bg:rgba(214,226,100,0.1);--icon-border:rgba(214,226,100,0.24);
                --link-color:var(--mustard);">
        <div class="card-number">01</div>
        <div class="card-icon-wrap">
          <svg viewBox="0 0 24 24" fill="none" stroke="#D6E264" stroke-width="1.8">
            <circle cx="12" cy="12" r="10"/>
            <line x1="12" y1="8" x2="12" y2="12"/>
            <line x1="12" y1="16" x2="12.01" y2="16"/>
          </svg>
        </div>
        <h3 class="card-title">Report a Problem</h3>
        <p class="card-desc">Spot pollution, illegal dumping, or damaged green spaces? Document it with photos and location for authorities to act.</p>
        <span class="card-link">File a report <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14M12 5l7 7-7 7"/></svg></span>
      </a>

      <a href="createEvent" class="feature-card"
         style="--card-stripe:var(--sea-salt);--card-glow:rgba(138,214,214,0.07);
                --icon-bg:rgba(138,214,214,0.1);--icon-border:rgba(138,214,214,0.24);
                --link-color:var(--sea-salt);">
        <div class="card-number">02</div>
        <div class="card-icon-wrap">
          <svg viewBox="0 0 24 24" fill="none" stroke="#8AD6D6" stroke-width="1.8">
            <rect x="3" y="4" width="18" height="18" rx="2"/>
            <line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/>
            <line x1="3" y1="10" x2="21" y2="10"/>
            <path d="M8 14h.01M12 14h.01M16 14h.01"/>
          </svg>
        </div>
        <h3 class="card-title">Host an Event</h3>
        <p class="card-desc">Turn a reported problem into action. Organize a cleanup, tree planting, or awareness campaign and invite your community.</p>
        <span class="card-link">Create an event <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14M12 5l7 7-7 7"/></svg></span>
      </a>

      <a href="events" class="feature-card"
         style="--card-stripe:var(--purple);--card-glow:rgba(128,161,248,0.07);
                --icon-bg:rgba(128,161,248,0.1);--icon-border:rgba(128,161,248,0.24);
                --link-color:var(--purple);">
        <div class="card-number">03</div>
        <div class="card-icon-wrap">
          <svg viewBox="0 0 24 24" fill="none" stroke="#80A1F8" stroke-width="1.8">
            <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
            <circle cx="9" cy="7" r="4"/>
            <path d="M23 21v-2a4 4 0 0 0-3-3.87"/>
            <path d="M16 3.13a4 4 0 0 1 0 7.75"/>
          </svg>
        </div>
        <h3 class="card-title">Join an Event</h3>
        <p class="card-desc">Browse upcoming environmental actions near you. RSVP, show up, and make a measurable difference alongside fellow citizens.</p>
        <span class="card-link">Browse events <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14M12 5l7 7-7 7"/></svg></span>
      </a>

      <a href="badges.html" class="feature-card"
         style="--card-stripe:var(--pink);--card-glow:rgba(244,114,182,0.07);
                --icon-bg:rgba(244,114,182,0.1);--icon-border:rgba(244,114,182,0.24);
                --link-color:var(--pink);">
        <div class="card-number">04</div>
        <div class="card-icon-wrap">
          <svg viewBox="0 0 24 24" fill="none" stroke="#F472B6" stroke-width="1.8">
            <path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/>
          </svg>
        </div>
        <h3 class="card-title">Earn Badges</h3>
        <p class="card-desc">Every action counts. Collect unique badges that showcase your environmental impact and inspire others to follow suit.</p>
        <span class="card-link">View badges <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M5 12h14M12 5l7 7-7 7"/></svg></span>
      </a>
    </div>
  </section>

  <!-- HOW IT WORKS -->
  <section style="padding-top:0;">
    <p class="section-label reveal">How It Works</p>
    <h2 class="section-title reveal">Simple steps,<br>real impact</h2>

    <div class="steps-container reveal">
      <div class="steps-visual">
        <div class="steps-visual-inner">
          <div class="orbit-ring r1"></div>
          <div class="orbit-ring r2"></div>
          <div class="orbit-ring r3"></div>
          <div class="orbit-center">
            <svg viewBox="0 0 24 24" fill="none" style="width:28px;height:28px;">
              <path d="M5 20s1-7 7-10c4-2 8-1 9-1s0 5-3 8c-3.5 3.5-8 4-13 3z" fill="#132442"/>
              <path d="M5 20c3-3 6-5 9-8" stroke="#132442" stroke-width="1.5" stroke-linecap="round"/>
            </svg>
          </div>
          <div class="orbit-dot od1">
            <svg viewBox="0 0 24 24" fill="none" stroke="#D6E264" stroke-width="1.8" style="width:16px;height:16px">
              <circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/>
            </svg>
          </div>
          <div class="orbit-dot od2">
            <svg viewBox="0 0 24 24" fill="none" stroke="#8AD6D6" stroke-width="1.8" style="width:16px;height:16px">
              <rect x="3" y="4" width="18" height="18" rx="2"/><line x1="16" y1="2" x2="16" y2="6"/>
            </svg>
          </div>
          <div class="orbit-dot od3">
            <svg viewBox="0 0 24 24" fill="none" stroke="#80A1F8" stroke-width="1.8" style="width:16px;height:16px">
              <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/>
            </svg>
          </div>
          <div class="orbit-dot od4">
            <svg viewBox="0 0 24 24" fill="none" stroke="#F472B6" stroke-width="1.8" style="width:16px;height:16px">
              <path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/>
            </svg>
          </div>
        </div>
      </div>

      <ul class="steps-list">
        <li class="step-item">
          <div class="step-num">01</div>
          <div class="step-text">
            <h4>Spot an issue, report it</h4>
            <p>Take a photo, drop a pin, write a description. Your report reaches local authorities and the community.</p>
          </div>
        </li>
        <li class="step-item">
          <div class="step-num">02</div>
          <div class="step-text">
            <h4>Organize or join an event</h4>
            <p>Turn reports into action. Create a cleanup event linked to an issue, or join one already happening near you.</p>
          </div>
        </li>
        <li class="step-item">
          <div class="step-num">03</div>
          <div class="step-text">
            <h4>Track your contribution</h4>
            <p>Every report and event attendance is logged on your profile, building a visible track record of change.</p>
          </div>
        </li>
        <li class="step-item">
          <div class="step-num">04</div>
          <div class="step-text">
            <h4>Unlock badges and recognition</h4>
            <p>Reach milestones and earn community-recognized badges that reflect your real environmental commitment.</p>
          </div>
        </li>
      </ul>
    </div>
  </section>

  <!-- BADGES -->
  <section style="padding-top:0;">
    <p class="section-label reveal">Achievements</p>
    <h2 class="section-title reveal">Badges you can earn</h2>
    <p class="section-desc reveal">Each badge represents a real action. Start with your first report and work your way to community champion.</p>

    <div class="badges-row reveal">
      <div class="badge-pill">
        <div class="badge-icon">
          <svg viewBox="0 0 24 24" fill="none" stroke="#D6E264" stroke-width="2"><circle cx="12" cy="12" r="9"/><path d="M9 12l2 2 4-4"/></svg>
        </div>
        First Reporter
      </div>
      <div class="badge-pill b-sea">
        <div class="badge-icon">
          <svg viewBox="0 0 24 24" fill="none" stroke="#8AD6D6" stroke-width="2"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/></svg>
        </div>
        Event Organizer
      </div>
      <div class="badge-pill b-purple">
        <div class="badge-icon">
          <svg viewBox="0 0 24 24" fill="none" stroke="#80A1F8" stroke-width="2"><path d="M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"/></svg>
        </div>
        Eco Champion
      </div>
      <div class="badge-pill b-pink">
        <div class="badge-icon">
          <svg viewBox="0 0 24 24" fill="none" stroke="#F472B6" stroke-width="2"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"/><polyline points="9 22 9 12 15 12 15 22"/></svg>
        </div>
        Community Builder
      </div>
      <div class="badge-pill b-navy">
        <div class="badge-icon">
          <svg viewBox="0 0 24 24" fill="none" stroke="#a0b4ff" stroke-width="2"><circle cx="11" cy="11" r="8"/><line x1="21" y1="21" x2="16.65" y2="16.65"/></svg>
        </div>
        Issue Hunter
      </div>
    </div>
  </section>
  
<div id="chatBox" style="position:fixed;bottom:20px;right:20px;width:300px;background:#132442;padding:10px;border-radius:10px;">
    <div id="messages" style="height:200px;overflow-y:auto;color:white;"></div>

    <input id="msgInput" type="text" placeholder="Ask something..." style="width:70%;">
    <button onclick="sendMsg()">Send</button>
</div>
  <!-- CTA -->
  <div class="cta-banner reveal" style="margin: 0 auto 100px; max-width: 1100px;">
    <h2>Ready to make a difference?</h2>
    <p>Join thousands of citizens already transforming their communities through action.</p>
    <div class="cta-actions">
      <a href="signup" class="btn-primary">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" style="width:16px;height:16px">
          <path d="M12 5v14M5 12l7 7 7-7"/>
        </svg>
        Get Started
      </a>
      <a href="profile" class="btn-ghost">View Your Profile</a>
    </div>
  </div>

  <footer>
    <div class="footer-logo">Lam<em>setna</em></div>
    <ul class="footer-links">
      <li><a href="posts">Posts</a></li>
      <li><a href="events">Events</a></li>
      <li><a href="badges.html">Badges</a></li>
    </ul>
    <span class="footer-copy">© 2026 Lamsetna Platform. Built for citizens.</span>
  </footer>

</div>

<script>
(function() {
	  const canvas = document.getElementById('bg-canvas');
	  const ctx = canvas.getContext('2d');
	  let W, H, flowers;

	  function resize() {
	    W = canvas.width = window.innerWidth;
	    H = canvas.height = window.innerHeight;
	  }

	  function createFlower() {
	    return {
	      x: Math.random() * W,
	      y: Math.random() * H,
	      size: Math.random() * 6 + 4,
	      speed: Math.random() * 0.3 + 0.1,
	      rotation: Math.random() * Math.PI * 2,
	      petals: Math.floor(Math.random() * 3) + 5
	    };
	  }

	  function drawFlower(f) {
	    ctx.save();
	    ctx.translate(f.x, f.y);
	    ctx.rotate(f.rotation);

	    for (let i = 0; i < f.petals; i++) {
	      ctx.rotate((Math.PI * 2) / f.petals);
	      ctx.beginPath();
	      ctx.ellipse(0, f.size, f.size / 2, f.size, 0, 0, Math.PI * 2);
	      ctx.fillStyle = "rgba(244, 114, 182, 0.18)"; // 🌸 pink petals
	      ctx.fill();
	    }

	    // center
	    ctx.beginPath();
	    ctx.arc(0, 0, f.size / 2, 0, Math.PI * 2);
	    ctx.fillStyle = "rgba(255, 182, 193, 0.35)"; // soft pink center
	    ctx.fill();

	    ctx.restore();
	  }

	  function init() {
	    resize();
	    flowers = Array.from({ length: 40 }, createFlower);
	  }

	  function animate() {
	    ctx.clearRect(0, 0, W, H);

	    flowers.forEach(f => {
	      f.y -= f.speed;
	      f.rotation += 0.002;

	      if (f.y < -20) {
	        f.y = H + 20;
	        f.x = Math.random() * W;
	      }

	      drawFlower(f);
	    });

	    requestAnimationFrame(animate);
	  }

	  window.addEventListener('resize', resize);
	  init();
	  animate();
	})();
function sendMsg() {
    let msg = document.getElementById("msgInput").value;

    if (!msg.trim()) return;

    addMessage("You", msg);
    document.getElementById("msgInput").value = "";

    fetch("chatbot", {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: "message=" + encodeURIComponent(msg)
    })
    .then(res => res.json())   // ✅ IMPORTANT: parse JSON
    .then(data => {
        // extract assistant message safely
        let botReply = data?.choices?.[0]?.message?.content 
                     || data?.message?.content 
                     || "No response";

        addMessage("Bot", botReply);
    })
    .catch(err => {
        console.error(err);
        addMessage("Bot", "⚠️ Error contacting server");
    });
}
function addMessage(label, text) {
    const div = document.createElement("div");
    div.textContent = label + ": " + text;
    document.getElementById("messages").appendChild(div);
}

const io = new IntersectionObserver(entries => {
  entries.forEach(e => { if(e.isIntersecting){e.target.classList.add('visible');io.unobserve(e.target);} });
}, {threshold:0.1});
document.querySelectorAll('.reveal').forEach(el => io.observe(el));
</script>

</body>
</html>
