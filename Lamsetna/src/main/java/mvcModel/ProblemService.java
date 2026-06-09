package mvcModel;

import jakarta.ejb.LocalBean;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import java.util.List;

import entities.*;

/**
 * Session Bean implementation class ProblemService
 */
@Stateless
@LocalBean
public class ProblemService {

	/**
	 * Default constructor.
	 */
	public ProblemService() {
		// TODO Auto-generated constructor stub
	}

	@PersistenceContext(unitName = "Lamsetna")
	private EntityManager em;

	public List<Problem> getAllProblems() {
		return em.createQuery("SELECT p FROM Problem p", Problem.class).getResultList();
	}

	public void createProblem(String titre, String description, String categorie,
            String localisation, User user, String imageUrl) {

Problem p = new Problem();

p.setTitre(titre);
p.setDescription(description);
p.setCategorie(categorie);
p.setLocalisation(localisation);
p.setUser(user);
p.setVotes(0);
p.setStatut("ouvert");

if (imageUrl != null) {
p.setImageUrl(imageUrl);
}

em.persist(p);
}
	
	public void addComment(int problemId, String contenu, User user) {

	    Problem problem = em.find(Problem.class, problemId);

	    Comment c = new Comment();
	    c.setContenu(contenu);
	    c.setCreatedAt(new java.sql.Timestamp(System.currentTimeMillis()));
	    c.setProblem(problem);
	    c.setUser(user);

	    em.persist(c);
	}

}
