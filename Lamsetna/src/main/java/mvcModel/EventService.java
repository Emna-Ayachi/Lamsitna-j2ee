package mvcModel;

import jakarta.ejb.LocalBean;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;

import java.util.List;

import entities.*;

/**
 * Session Bean implementation class EventService
 */
@Stateless
@LocalBean
public class EventService {

    /**
     * Default constructor. 
     */
    public EventService() {
        // TODO Auto-generated constructor stub
    }
    @PersistenceContext(unitName = "Lamsetna")
    private EntityManager em;

    public List<Event> getAllEvents() {
        return em.createQuery("SELECT e FROM Event e", Event.class)
                .getResultList();
    }

    public void createEvent(String titre, String description, String lieu, int maxParticipants, User user) {

        Event e = new Event();

        e.setTitre(titre);
        e.setDescription(description);
        e.setLieu(lieu);
        e.setMaxParticipants(maxParticipants);

        e.setUser(user);
        e.setApprouve((byte) 0);

        em.persist(e);
    }
    
    public void joinEvent(int eventId, User user) {

        Event event = em.find(Event.class, eventId);

        if (event.getUser().getId() == user.getId()) {
            return;
        }

        Long count = em.createQuery(
            "SELECT COUNT(ep) FROM EventParticipant ep WHERE ep.event.id = :eid AND ep.user.id = :uid",
            Long.class
        )
        .setParameter("eid", eventId)
        .setParameter("uid", user.getId())
        .getSingleResult();

        if (count > 0) {
            return;
        }

        Long participants = em.createQuery(
            "SELECT COUNT(ep) FROM EventParticipant ep WHERE ep.event.id = :eid",
            Long.class
        )
        .setParameter("eid", eventId)
        .getSingleResult();

        if (participants >= event.getMaxParticipants()) {
            return;
        }

        EventParticipant ep = new EventParticipant();
        ep.setEvent(event);
        ep.setUser(user);
        ep.setJoinedAt(new java.sql.Timestamp(System.currentTimeMillis()));

        em.persist(ep);
    }
    public Long countParticipants(int eventId) {
        return em.createQuery(
            "SELECT COUNT(ep) FROM EventParticipant ep WHERE ep.event.id = :eid",
            Long.class
        )
        .setParameter("eid", eventId)
        .getSingleResult();
    }

}
