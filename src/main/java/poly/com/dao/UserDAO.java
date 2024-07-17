package poly.com.dao;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import poly.com.entity.Users;

import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;

@Repository
public class UserDAO {

    @PersistenceContext
    private EntityManager entityManager;

    @Transactional
    public Users findByUsername(String username) {
        String jpql = "SELECT u FROM Users u WHERE u.username = :username";
        TypedQuery<Users> query = entityManager.createQuery(jpql, Users.class);
        query.setParameter("username", username);
        try {
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    @Transactional
    public Users findByEmail(String email) {
        String jpql = "SELECT u FROM Users u WHERE u.email = :email";
        TypedQuery<Users> query = entityManager.createQuery(jpql, Users.class);
        query.setParameter("email", email);
        try {
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    @Transactional
    public void save(Users user) {
        entityManager.persist(user);
    }
    
    @Transactional
    public void update(Users user) {
        entityManager.merge(user);
    }
    
    @Transactional
    public Users findById(Long id) {
        return entityManager.find(Users.class, id);
    }
}
