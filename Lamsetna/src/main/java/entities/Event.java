package entities;

import java.io.Serializable;
import jakarta.persistence.*;
import java.util.Date;
import java.sql.Timestamp;
import java.util.List;


/**
 * The persistent class for the events database table.
 * 
 */
@Entity
@Table(name="events")
@NamedQuery(name="Event.findAll", query="SELECT e FROM Event e")
public class Event implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;

	private byte approuve;

	@Column(name="created_at")
	private Timestamp createdAt;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name="date_event")
	private Date dateEvent;

	@Lob
	private String description;

	private String lieu;

	@Column(name="max_participants")
	private int maxParticipants;

	private String titre;

	//bi-directional many-to-one association to EventParticipant
	@OneToMany(mappedBy="event", fetch=FetchType.EAGER)
	private List<EventParticipant> eventParticipants;

	//bi-directional many-to-one association to User
	@ManyToOne
@JoinColumn(name="organisateur_id")
	private User user;

	public Event() {
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public byte getApprouve() {
		return this.approuve;
	}

	public void setApprouve(byte approuve) {
		this.approuve = approuve;
	}

	public Timestamp getCreatedAt() {
		return this.createdAt;
	}

	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	public Date getDateEvent() {
		return this.dateEvent;
	}

	public void setDateEvent(Date dateEvent) {
		this.dateEvent = dateEvent;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getLieu() {
		return this.lieu;
	}

	public void setLieu(String lieu) {
		this.lieu = lieu;
	}

	public int getMaxParticipants() {
		return this.maxParticipants;
	}

	public void setMaxParticipants(int maxParticipants) {
		this.maxParticipants = maxParticipants;
	}

	public String getTitre() {
		return this.titre;
	}

	public void setTitre(String titre) {
		this.titre = titre;
	}

	public List<EventParticipant> getEventParticipants() {
		return this.eventParticipants;
	}

	public void setEventParticipants(List<EventParticipant> eventParticipants) {
		this.eventParticipants = eventParticipants;
	}

	public EventParticipant addEventParticipant(EventParticipant eventParticipant) {
		getEventParticipants().add(eventParticipant);
		eventParticipant.setEvent(this);

		return eventParticipant;
	}

	public EventParticipant removeEventParticipant(EventParticipant eventParticipant) {
		getEventParticipants().remove(eventParticipant);
		eventParticipant.setEvent(null);

		return eventParticipant;
	}

	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

}