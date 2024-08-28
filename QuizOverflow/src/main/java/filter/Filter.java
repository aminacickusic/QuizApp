package filter;

import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

import java.io.IOException;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;

public class Filter extends HttpFilter implements jakarta.servlet.Filter {

	private static final long serialVersionUID = 1L;
	private static final String[] USER_MANAGEMENT_URLS = { "/admin/usermanagement", "/admin/deleteuser",
			"/admin/adduser", "/admin/updateavatar" };

	public Filter() {
		super();

	}

	public void destroy() {

	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;

		HttpSession session = httpRequest.getSession(false);
		String loginURI = httpRequest.getContextPath() + "/login";
		String requestURI = httpRequest.getRequestURI();

		boolean loggedIn = session != null && session.getAttribute("currentUser") != null;
		boolean loginRequest = httpRequest.getRequestURI().equals(loginURI);

		boolean isRoleValid = false;
		if (loggedIn) {
			User user = (User) session.getAttribute("currentUser");
			isRoleValid = user.getRole().equals("admin") || user.getRole().equals("editor");

			if (!user.getRole().equals("admin") && isUserManagementURL(requestURI)) {

				httpResponse.sendRedirect(loginURI);
				return;
			}
		}

		if ((loggedIn && isRoleValid) || loginRequest) {

			chain.doFilter(request, response);
		} else {
			httpResponse.sendRedirect(loginURI);
		}

	}

	private boolean isUserManagementURL(String requestURI) {

		for (String url : USER_MANAGEMENT_URLS) {

			if (requestURI.contains(url)) {
				return true;
			}
		}
		return false;
	}

	public void init(FilterConfig fConfig) throws ServletException {

	}

}
