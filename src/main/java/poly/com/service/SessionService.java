package poly.com.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SessionService {

    @Autowired
    HttpSession session;

    public String get(String key) {
        Object value = session.getAttribute(key);
        return value != null ? value.toString() : "";
    }

    public void set(String key, String value) {
        session.setAttribute(key, value);
    }
}
