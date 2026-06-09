package mvcController;

import jakarta.ejb.EJB;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import mvcModel.ChatBotService;
import mvcModel.EventService;
import mvcModel.ProblemService;
import mvcModel.UserService;

import java.io.File;
import java.io.IOException;
import java.util.List;

import entities.*;

/**
 * Servlet implementation class Controller
 */
@WebServlet(urlPatterns = {"/Controller", "/posts" , "/events" , "/profile" , "/home", "/createEvent" , "/createPoste",  "/login",
	    "/signup", "/chatbot"})
@MultipartConfig(
	    fileSizeThreshold = 1024 * 1024,
	    maxFileSize = 5 * 1024 * 1024,
	    maxRequestSize = 10 * 1024 * 1024
	)
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@EJB
    private UserService userService;
	@EJB
	private ProblemService problemService;
	@EJB
	private EventService eventService;
	@EJB
	private ChatBotService chatBotService;
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Controller() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (request.getServletPath().equals("/posts")) {

            List<Problem> posts = problemService.getAllProblems();

            request.setAttribute("posts", posts);

            RequestDispatcher rd = request.getRequestDispatcher("posts.jsp");
            rd.forward(request, response);
            return;
        }
        if (request.getServletPath().equals("/events")) {

            List<Event> events = eventService.getAllEvents();

            request.setAttribute("events", events);

            RequestDispatcher rd = request.getRequestDispatcher("events.jsp");
            rd.forward(request, response);
            return;
        }
        if (request.getServletPath().equals("/profile")) {

            HttpSession session = request.getSession(false);
            User user = (session != null) ? (User) session.getAttribute("activeUser") : null;

            if (user == null) {
                response.sendRedirect("login");
                return;
            }

            request.setAttribute("user", user);

            RequestDispatcher rd = request.getRequestDispatcher("profile.jsp");
            rd.forward(request, response);
            return;
        }
        if (request.getServletPath().equals("/home")) {

            HttpSession session = request.getSession(false);
            User user = (session != null) ? (User) session.getAttribute("activeUser") : null;

            if (user == null) {
                response.sendRedirect("login");
                return;
            }

            request.setAttribute("user", user);

            RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
            rd.forward(request, response);
            return;
        }
        if (request.getServletPath().equals("/createEvent")) {

            HttpSession session = request.getSession(false);
            User user = (session != null) ? (User) session.getAttribute("activeUser") : null;

            if (user == null) {
                response.sendRedirect("login");
                return;
            }

            RequestDispatcher rd = request.getRequestDispatcher("createEvent.jsp");
            rd.forward(request, response);
            return;
        }
        if (request.getServletPath().equals("/createPoste")) {

            HttpSession session = request.getSession(false);
            User user = (session != null) ? (User) session.getAttribute("activeUser") : null;

            if (user == null) {
                response.sendRedirect("login");
                return;
            }

            RequestDispatcher rd = request.getRequestDispatcher("createPoste.jsp");
            rd.forward(request, response);
            return;
        }
        if (request.getServletPath().equals("/login")) {
            RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
            rd.forward(request, response);
            return;
        }
        if (request.getServletPath().equals("/signup")) {
            RequestDispatcher rd = request.getRequestDispatcher("signup.jsp");
            rd.forward(request, response);
            return;
        }

        RequestDispatcher rd = request.getRequestDispatcher("signup.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String btnValue = request.getParameter("myBtn");

        if (btnValue != null && btnValue.equals("Signup")) {
            String nom      = request.getParameter("nom");
            String prenom   = request.getParameter("prenom");
            String email    = request.getParameter("email");
            String password = request.getParameter("password");

            try {
                boolean isSaved = userService.createUser(nom, prenom, email, password);

                if (isSaved) {
                    request.setAttribute("message", "Account created successfully! You can now login.");
                    RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                    rd.forward(request, response);
                } else {
                    request.setAttribute("error", "Failed to create account. Email may already exist.");
                    RequestDispatcher rd = request.getRequestDispatcher("signup.jsp");
                    rd.forward(request, response);
                }

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "An unexpected error occurred: " + e.getMessage());
                RequestDispatcher rd = request.getRequestDispatcher("signup.jsp");
                rd.forward(request, response);
            }
        }
        if (btnValue != null && btnValue.equals("Login")) {

            String email = request.getParameter("email");
            String password = request.getParameter("password");

            try {
                User user = userService.login(email, password);

                if (user != null) {
                    HttpSession session = request.getSession(true);
                    session.setAttribute("activeUser", user);

                    response.sendRedirect("home");
                    return;

                } else {
                    request.setAttribute("error", "Invalid email or password");
                    RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                    rd.forward(request, response);
                    return;
                }

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Error: " + e.getMessage());
                RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                rd.forward(request, response);
            }
        }
        if (btnValue != null && btnValue.equals("CreatePost")) {

            String titre = request.getParameter("titre");
            String description = request.getParameter("description");
            String categorie = request.getParameter("categorie");
            //System.out.println("categorie = " + categorie);
            String localisation = request.getParameter("localisation");
            Part imagePart = request.getPart("image");

            String imageUrl = null;

            if (imagePart != null && imagePart.getSize() > 0) {

                String originalFileName = imagePart.getSubmittedFileName();

                String fileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));

                String fileName = System.currentTimeMillis() + fileExtension;

                String uploadPath = getServletContext().getRealPath("/uploads");

                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();

                imagePart.write(uploadPath + File.separator + fileName);

                imageUrl = "uploads/" + fileName;
            }
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("activeUser");

            try {
                problemService.createProblem(
                        titre,
                        description,
                        categorie,
                        localisation,
                        user,
                        imageUrl
                );

                response.sendRedirect("posts");
                return;

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Error creating post");
                request.getRequestDispatcher("createPoste.jsp").forward(request, response);
            }
        }
        if (btnValue != null && btnValue.equals("CreateEvent")) {

            String titre = request.getParameter("titre");
            String description = request.getParameter("description");
            String lieu = request.getParameter("lieu");
            int maxParticipants = Integer.parseInt(request.getParameter("maxParticipants"));

            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("activeUser");

            try {
                eventService.createEvent(
                        titre,
                        description,
                        lieu,
                        maxParticipants,
                        user
                );

                response.sendRedirect("events");
                return;

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Error creating event");
                request.getRequestDispatcher("createEvent.jsp").forward(request, response);
            }
        }
        if (btnValue != null && btnValue.equals("JoinEvent")) {

            int eventId = Integer.parseInt(request.getParameter("eventId"));

            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("activeUser");

            eventService.joinEvent(eventId, user);

            response.sendRedirect("events");
            return;
        }
        if (btnValue != null && btnValue.equals("AddComment")) {

            int problemId = Integer.parseInt(request.getParameter("problemId"));
            String contenu = request.getParameter("contenu");

            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("activeUser");
            if (user == null) {
                response.sendRedirect("login");
                return;
            }
            problemService.addComment(problemId, contenu, user);

            response.sendRedirect("posts");
            return;
        }
        if (request.getServletPath().equals("/chatbot")) {

            String message = request.getParameter("message");

            try {
            	String reply = chatBotService.getResponse(message);
                response.setContentType("text/plain");
                response.getWriter().write(reply);
                return;

            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().write("Error contacting chatbot");
                return;
            }
        }
    }

}
