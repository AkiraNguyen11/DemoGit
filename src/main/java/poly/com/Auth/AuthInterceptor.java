package poly.com.Auth;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import poly.com.entity.Users;
import poly.com.service.SessionServiceIn;

@Component
public class AuthInterceptor implements HandlerInterceptor {
	@Autowired
	private SessionServiceIn session;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		String uri = request.getRequestURI();
		Users user = session.get("user");
		String error = "";

		if (user == null) {
			error = "Please Login";
		} else {
			// Check if the user is an admin and trying to access admin resources
			if (user.isAdmin() && uri.startsWith("/admin")) {
				error = "Access Denied";
			}
		}

		if (!error.isEmpty()) {
			session.set("security-uri", uri);
			response.sendRedirect("/login?message=" + error);
			return false;
		}
		return true;
	}
}
