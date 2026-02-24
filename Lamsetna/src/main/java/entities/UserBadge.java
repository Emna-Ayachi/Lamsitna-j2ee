package entities;

import java.io.Serializable;
import jakarta.persistence.*;
import java.sql.Timestamp;


/**
 * The persistent class for the user_badges database table.
 * 
 */
@Entity
@Table(name="user_badges")
@NamedQuery(name="UserBadge.findAll", query="SELECT u FROM UserBadge u")
public class UserBadge implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;

	@Column(name="obtained_at")
	private Timestamp obtainedAt;

	//bi-directional many-to-one association to User
	@ManyToOne
	private User user;

	//bi-directional many-to-one association to Badge
	@ManyToOne
	private Badge badge;

	public UserBadge() {
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Timestamp getObtainedAt() {
		return this.obtainedAt;
	}

	public void setObtainedAt(Timestamp obtainedAt) {
		this.obtainedAt = obtainedAt;
	}

	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Badge getBadge() {
		return this.badge;
	}

	public void setBadge(Badge badge) {
		this.badge = badge;
	}

}