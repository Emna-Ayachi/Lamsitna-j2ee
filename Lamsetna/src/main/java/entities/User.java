package entities;

import java.io.Serializable;
import jakarta.persistence.*;
import java.sql.Timestamp;
import java.util.List;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

/**
 * The persistent class for the users database table.
 * 
 */
@Entity
@Table(name="users")
@NamedQuery(name="User.findAll", query="SELECT u FROM User u")
public class User implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;

	@Column(name="created_at")
	private Timestamp createdAt;

	private String email;

	private String nom;

	private String password;

	private int points;

	private String prenom;

	private String role;

	//bi-directional many-to-one association to Comment
	@OneToMany(mappedBy="user", fetch=FetchType.EAGER)
	private List<Comment> comments;

	//bi-directional many-to-one association to EventParticipant
	@OneToMany(mappedBy="user", fetch=FetchType.EAGER)
	private List<EventParticipant> eventParticipants;

	//bi-directional many-to-one association to Event
	@OneToMany(mappedBy="user", fetch=FetchType.EAGER)
	private List<Event> events;

	//bi-directional many-to-one association to Problem
	@OneToMany(mappedBy="user", fetch=FetchType.EAGER)
	private List<Problem> problems;

	//bi-directional many-to-one association to UserBadge
	@OneToMany(mappedBy="user", fetch=FetchType.EAGER)
	private List<UserBadge> userBadges;

	public User() {
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Timestamp getCreatedAt() {
		return this.createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	public String getEmail() {
		return this.email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getNom() {
		return this.nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public int getPoints() {
		return this.points;
	}

	public void setPoints(int points) {
		this.points = points;
	}

	public String getPrenom() {
		return this.prenom;
	}

	public void setPrenom(String prenom) {
		this.prenom = prenom;
	}

	public String getRole() {
		return this.role;
	}

	public void setRole(String role) {
		this.role = role;
	}
    public static boolean createUser(EntityManager em, User user) {
        try {
            em.persist(user);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
	public List<Comment> getComments() {
		return this.comments;
	}

	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}

	public Comment addComment(Comment comment) {
		getComments().add(comment);
		comment.setUser(this);

		return comment;
	}

	public Comment removeComment(Comment comment) {
		getComments().remove(comment);
		comment.setUser(null);

		return comment;
	}

	public List<EventParticipant> getEventParticipants() {
		return this.eventParticipants;
	}

	public void setEventParticipants(List<EventParticipant> eventParticipants) {
		this.eventParticipants = eventParticipants;
	}

	public EventParticipant addEventParticipant(EventParticipant eventParticipant) {
		getEventParticipants().add(eventParticipant);
		eventParticipant.setUser(this);

		return eventParticipant;
	}

	public EventParticipant removeEventParticipant(EventParticipant eventParticipant) {
		getEventParticipants().remove(eventParticipant);
		eventParticipant.setUser(null);

		return eventParticipant;
	}

	public List<Event> getEvents() {
		return this.events;
	}

	public void setEvents(List<Event> events) {
		this.events = events;
	}

	public Event addEvent(Event event) {
		getEvents().add(event);
		event.setUser(this);

		return event;
	}

	public Event removeEvent(Event event) {
		getEvents().remove(event);
		event.setUser(null);

		return event;
	}

	public List<Problem> getProblems() {
		return this.problems;
	}

	public void setProblems(List<Problem> problems) {
		this.problems = problems;
	}

	public Problem addProblem(Problem problem) {
		getProblems().add(problem);
		problem.setUser(this);

		return problem;
	}

	public Problem removeProblem(Problem problem) {
		getProblems().remove(problem);
		problem.setUser(null);

		return problem;
	}

	public List<UserBadge> getUserBadges() {
		return this.userBadges;
	}

	public void setUserBadges(List<UserBadge> userBadges) {
		this.userBadges = userBadges;
	}

	public UserBadge addUserBadge(UserBadge userBadge) {
		getUserBadges().add(userBadge);
		userBadge.setUser(this);

		return userBadge;
	}

	public UserBadge removeUserBadge(UserBadge userBadge) {
		getUserBadges().remove(userBadge);
		userBadge.setUser(null);

		return userBadge;
	}

}