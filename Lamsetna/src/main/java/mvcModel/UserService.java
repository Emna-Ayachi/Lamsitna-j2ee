package mvcModel;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import entities.User;

@Stateless
public class UserService {

    @PersistenceContext(unitName = "Lamsetna")
    private EntityManager em;

    public boolean createUser(String nom, String prenom, String email, String password) {
        try {
            User user = new User();
            user.setNom(nom);
            user.setPrenom(prenom);
            user.setEmail(email);
            user.setPassword(password);
            em.persist(user);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    public User login(String email, String password) {
        try {
            return em.createQuery(
                    "SELECT u FROM User u WHERE u.email = :email AND u.password = :password",
                    User.class)
                    .setParameter("email", email)
                    .setParameter("password", password)
                    .getSingleResult();
        } catch (Exception e) {
            return null; 
        }
    }
}