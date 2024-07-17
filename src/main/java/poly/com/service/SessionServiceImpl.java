package poly.com.service;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SessionServiceImpl implements SessionServiceIn {

    @Autowired
    HttpSession session;

    @Override
    public <T> T get(String name) {
        return (T) session.getAttribute(name);
    }

    @Override
    public <T> T getValue(String name, T defaultValue) {
        T value = get(name);
        return value != null ? value : defaultValue;
    }

    @Override
    public void set(String name, Object value) {
        session.setAttribute(name, value);
    }

    @Override
    public void remove(String name) {
        session.removeAttribute(name);
    }
}
