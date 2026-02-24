package entities;

import java.io.Serializable;
import jakarta.persistence.*;
import java.util.List;


/**
 * The persistent class for the badges database table.
 * 
 */
@Entity
@Table(name="badges")
@NamedQuery(name="Badge.findAll", query="SELECT b FROM Badge b")
public class Badge implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int id;

	private String description;

	private String icone;

	private String nom;

	@Column(name="points_requis")
	private int pointsRequis;

	//bi-directional many-to-one association to UserBadge
	@OneToMany(mappedBy="badge", fetch=FetchType.EAGER)
	private List<UserBadge> userBadges;

	public Badge() {
	}

	public int getId() {
		return this.id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getIcone() {
		return this.icone;
	}

	public void setIcone(String icone) {
		this.icone = icone;
	}

	public String getNom() {
		return this.nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

	public int getPointsRequis() {
		return this.pointsRequis;
	}

	public void setPointsRequis(int pointsRequis) {
		this.pointsRequis = pointsRequis;
	}

	public List<UserBadge> getUserBadges() {
		return this.userBadges;
	}

	public void setUserBadges(List<UserBadge> userBadges) {
		this.userBadges = userBadges;
	}

	public UserBadge addUserBadge(UserBadge userBadge) {
		getUserBadges().add(userBadge);
		userBadge.setBadge(this);

		return userBadge;
	}

	public UserBadge removeUserBadge(UserBadge userBadge) {
		getUserBadges().remove(userBadge);
		userBadge.setBadge(null);

		return userBadge;
	}

}